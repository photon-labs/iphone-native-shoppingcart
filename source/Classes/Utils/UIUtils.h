/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
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
