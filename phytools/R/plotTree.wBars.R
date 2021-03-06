## function to plot bars at the tips of a plotted tree
## written by Liam J. Revell 2014, 2015

plotTree.wBars<-function(tree,x,scale=1,width=NULL,type="phylogram",method="plotTree",tip.labels=FALSE,
	col="grey",border=NULL,...){
	if(!inherits(tree,"phylo")) stop("tree should be an object of class \"phylo\".")
	d<-scale*(max(x)-min(0,min(x)))
	H<-nodeHeights(tree)
	if(tip.labels==FALSE){
		lims<-c(-max(H)-d,max(H)+d)
		sw<-0
	} else {
		if(hasArg(fsize)) fsize<-list(...)$fsize
		else fsize<-1
		if(type=="phylogram"){
			pp<-par("pin")[1]
			sw<-fsize*(max(strwidth(tree$tip.label,units="inches")))+1.37*fsize*strwidth("W",units="inches")
			alp<-optimize(function(a,H,sw,pp,d) (a*1.04*(max(H)+d)+sw-pp)^2,H=H,sw=sw,pp=pp,d=d,interval=c(0,1e6))$minimum
			lims<-c(min(H),max(H)+d+sw/alp)
		} else if(type=="fan"){
			pp<-par("pin")[1]
			sw<-fsize*(max(strwidth(tree$tip.label,units="inches")))+1.37*fsize*strwidth("W",units="inches")
			alp<-optimize(function(a,H,sw,pp,d) (a*2*1.04*(max(H)+d)+2*sw-pp)^2,H=H,sw=sw,pp=pp,d=d,interval=c(0,1e6))$minimum
			lims<-c(-max(H)-d-sw/alp,max(H)+d+sw/alp)
		}	
	}	
	if(type=="phylogram"){
		if(method=="plotTree") capture.output(plotTree(tree,ftype=if(tip.labels) "i" else "off",xlim=c(0,lims[2]),...))
		else if(method=="plotSimmap") capture.output(plotSimmap(tree,ftype=if(tip.labels) "i" else "off",xlim=c(0,lims[2]),...))
	} else if(type=="fan"){
		if(method=="plotTree") capture.output(plotTree(tree,type="fan",ftype=if(tip.labels) "i" else "off",xlim=lims,ylim=lims,...))
		else if(method=="plotSimmap") capture.output(plotSimmap(tree,type="fan",ftype=if(tip.labels) "i" else "off",xlim=lims,ylim=lims,...))
	}
	obj<-get("last_plot.phylo",envir=.PlotPhyloEnv)
	x<-x[tree$tip.label]*scale
	if(is.null(width))
		width<-if(type=="fan") (par()$usr[4]-par()$usr[3])/(max(c(max(x)/max(nodeHeights(tree)),1))*length(tree$tip.label)) 
			else if(type=="phylogram") (par()$usr[4]-par()$usr[3])/(2*length(tree$tip.label))
	w<-width
	if(length(col)<Ntip(tree)) col<-rep(col,ceiling(Ntip(tree)/length(col)))[1:Ntip(tree)]
	if(is.null(names(col))) names(col)<-tree$tip.label
	col<-col[tree$tip.label]
	if(type=="phylogram"){
		if(hasArg(direction)) direction<-list(...)$direction
		else direction<-"rightwards"
		sw<-if(tip.labels) fsize*(max(strwidth(tree$tip.label)))+fsize*strwidth("1") else strwidth("l")
		for(i in 1:length(x)){
			dx<-if(min(x)>=0) obj$xx[i] else max(obj$xx)
			dy<-obj$yy[i]
			x1<-x2<-dx+sw
			x3<-x4<-x1+x[i]
			y1<-y4<-dy-w/2
			y2<-y3<-dy+w/2
			polygon(c(x1,x2,x3,x4)-min(0,min(x)),
				c(y1,y2,y3,y4),col=col[i],border=border)
		}
	} else if(type=="fan"){
		if(min(x)<0) h<-max(nodeHeights(tree))
		sw<-if(tip.labels) fsize*(max(strwidth(tree$tip.label)))+fsize*strwidth("1") else strwidth("l")
		for(i in 1:length(x)){
			theta<-atan(obj$yy[i]/obj$xx[i])
			s<-if(obj$xx[i]>0) 1 else -1
			if(min(x)>=0){
				dx<-obj$xx[i]+s*cos(theta)*sw
				dy<-obj$yy[i]+s*sin(theta)*sw
			} else {
				dx<-s*h*cos(theta)+s*cos(theta)*sw
				dy<-s*h*sin(theta)+s*sin(theta)*sw
			}
			x1<-dx+(w/2)*cos(pi/2-theta)-s*min(0,min(x))*cos(theta)
			y1<-dy-(w/2)*sin(pi/2-theta)-s*min(0,min(x))*sin(theta)
			x2<-dx-(w/2)*cos(pi/2-theta)-s*min(0,min(x))*cos(theta)
			y2<-dy+(w/2)*sin(pi/2-theta)-s*min(0,min(x))*sin(theta)
			x3<-s*x[i]*cos(theta)+x2
			y3<-s*x[i]*sin(theta)+y2
			x4<-s*x[i]*cos(theta)+x1
			y4<-s*x[i]*sin(theta)+y1
			polygon(c(x1,x2,x3,x4),c(y1,y2,y3,y4),col=col[i],
				border=border)
		}
	}
	invisible(obj)
}

