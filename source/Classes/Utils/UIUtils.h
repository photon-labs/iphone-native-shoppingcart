//
//  UIUtils.h
//
//  Created by Admin on 02/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBeginAnimations 0
#define kAddAnimation 1
#define kCommitAnimations 2
#define kBeginAndCommitAnimation  3
#define kNoAnimation  4

#define kLoadingIndicatorTag	509	

@interface UIUtils : NSObject {

}

-(void) fadeIn:(UIView*) view : (double) duration;
-(UIView*)createLoadingViewWithTag:(NSInteger)tag;
-(void)removeLoadingViewFromView:(UIView*)fromView WithTag:(NSInteger)tag;
+ (UIUtils *)sharedInstance;
-(void) moveView:(UIView*)view: 
				(float)xVal:
				(float)yVal:
				(BOOL)isAnimated: 
				(float)duration: 
				(int) transitionPhase;
-(void)presentModalView:(UIView*)view;
-(void)dismissModalView:(UIView*)view;
@end
