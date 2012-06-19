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
//  Tabbar.h
//
//  Created by PHOTON on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabbarRect	CGRectMake(0, 413, 320, 49)

@interface Tabbar : UIView {

    NSArray *viewControllers;
    NSInteger selectedIndex;
    NSInteger lastSelectedIndex;
}

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger selectedIndex;

- (UIView*)initWithInfo:(NSArray*)names;
- (void)setControllers:(NSArray*)controllers;
- (void)setSelectedIndex:(int)index fromSender:sender;
- (void)highlightTab:(UIButton*)button atIndex:(int)index;
- (void)highlightTabAtIndex:(int)index;
- (void)unHighlightLastSelectedTab;
- (UIImage*) getImageForButton:(NSString*)btnTitle  isHighlighted:(BOOL)isHighlighted;
- (void)reloadFeatureTab:(int)index;

@end
