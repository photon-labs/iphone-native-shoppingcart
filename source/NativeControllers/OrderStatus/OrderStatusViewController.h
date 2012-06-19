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
//  OrderStatusViewController.h
//  Phresco
//
//  Created by bharat kumar on 07/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrowseViewController;
@class Tabbar;

@interface OrderStatusViewController : UIViewController<UITextViewDelegate>
{
    UITextView* orderStatusTextView;//orderStatusTextView
    BrowseViewController* browseViewController;
    Tabbar *tabbar;
}
@property (nonatomic, retain) UITextView* orderStatusTextView;
@property (nonatomic, retain) BrowseViewController* browseViewController;

-(void) loadNavigationBar;
-(void) initializeTextView;
-(void)goBack:(id)sender;
@end
