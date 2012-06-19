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
//  ProductDetailsViewController.h
//  Phresco
//
//  Created by photon on 11/11/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddToBagViewController;
@class ReviewViewController;
@class Tabbar;

@interface ProductDetailsViewController : UIViewController {

	UIScrollView *scrollView;
    UIImageView *starImage;
    BOOL loginChk;
    int index;
    
    Tabbar *tabbar;
    ReviewViewController* reviewViewController;
    AddToBagViewController *addToBagController;
   
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) AddToBagViewController *addToBagController;

@property (nonatomic, retain) ReviewViewController* reviewViewController;

@property (nonatomic) BOOL loginChk;

@property (nonatomic) int index;

-(void) loadNavigationBar;

-(void) initializeProductImageView;

-(void) initializeProductDescription;

-(void) setProductDetail;


@end
