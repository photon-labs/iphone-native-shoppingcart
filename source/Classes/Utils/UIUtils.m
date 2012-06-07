//
//  UIUtils.m
//
//  Created by Admin on 02/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIUtils.h"
#import "PhrescoAppDelegate.h"

static UIUtils *sharedUIUtilsObject = nil;

@implementation UIUtils
- (id) init {
	self = [super init];	
	
	return self;
}

+ (UIUtils *)sharedInstance {
    @synchronized(self) {
        if (sharedUIUtilsObject == nil) 
		{
			sharedUIUtilsObject= [[self alloc] init]; // assignment not done here
        }
    }
	
    return sharedUIUtilsObject;
}

- (void) dealloc
{
	[super dealloc];
}

-(void) fadeIn:(UIView*) view : (double) duration
{
	UIView *fadeView = [[[UIView alloc]init] autorelease];
	fadeView.backgroundColor = [UIColor blackColor];
	//fadeView.frame = CGRectMake(0.0, 0.0, 320.0, 460.0);
	
	fadeView.frame = view.frame;
	fadeView.hidden = NO;
	
	fadeView.alpha = 1;
	
	[view addSubview:fadeView];
	
	
	[UIView beginAnimations:nil  context:nil];
	
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:duration];
	
	fadeView.alpha = 0;
	
	[UIView commitAnimations];
	
	[view bringSubviewToFront:fadeView];
	
	//[fadeView removeFromSuperview];
	
}

//moves a view to any place....animated or not animated 
-(void) moveView:(UIView*)view: 
				(float)xVal:
				(float)yVal:
				(BOOL)isAnimated: 
				(float)duration: 
				(int) transitionPhase
{
	
	
	if(isAnimated)
	{
		
		if (transitionPhase==kBeginAnimations || transitionPhase==kBeginAndCommitAnimation)
			[UIView beginAnimations:nil context:nil];
		
		[UIView setAnimationDuration:duration];
		view.frame = CGRectMake(xVal, 
								yVal, 
								view.frame.size.width, 
								view.frame.size.height);
		
		
		if (transitionPhase==kCommitAnimations|| transitionPhase==kBeginAndCommitAnimation)
			[UIView commitAnimations];
	}
	else{
		view.frame = CGRectMake(xVal, 
								yVal, 
								view.frame.size.width, 
								view.frame.size.height);
	}
	
	
}

-(UIView*)createLoadingViewWithTag:(NSInteger)tag
{
	//Loading indicator - start
	UIView *loadingView;
	loadingView = [[UIView alloc]init];
	loadingView.backgroundColor = [UIColor grayColor];
	loadingView.frame = CGRectMake(0.0, 0.0, 320.0, 456.0);
	loadingView.hidden = NO;
	[loadingView setTag:tag];
	
	loadingView.alpha = 0.6;

	
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]init];
	spinner.frame = CGRectMake(150,174,20,20);
	
	[loadingView insertSubview:spinner aboveSubview:loadingView];
	[spinner startAnimating];
	[spinner release];
	
	return [loadingView autorelease];
	
}

-(void)removeLoadingViewFromView:(UIView*)fromView WithTag:(NSInteger)tag {
    
    UIView *loadingView = (UIView*)[fromView viewWithTag:tag];
    
    if (nil != loadingView) {
        [loadingView removeFromSuperview];
    }
}

-(void)presentModalView:(UIView*)view 
{   
	//now move the view down
	[self moveView:view
			    :0:480 :NO :0.4 :kNoAnimation];

	//animate it up now.
	[self moveView:view
				:0:0 :YES :0.4 :kBeginAndCommitAnimation];
}

-(void)dismissModalView:(UIView*)view
{
	//animate view and remove it	
	[self moveView:view
                :0:480: YES :0.4 :kBeginAndCommitAnimation];
	
    [view performSelector:@selector(removeFromSuperview)
               withObject:nil
               afterDelay:0.6];
}

@end
