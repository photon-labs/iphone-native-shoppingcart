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
//  SpecialOffersViewController.h
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReviewViewController;
@class AddToBagViewController;
@class BrowseViewController;
@class ProductDetailsViewController;
@class Tabbar;

@interface SpecialOffersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* specialProductTable;
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;

    NSMutableArray	*priceArray;
    
        
    UIButton* review;
    
    UIActivityIndicatorView* activityIndicator;
    
    BOOL loginChk;
    
    int index;

    Tabbar *tabbar;
    
    ReviewViewController *reviewViewController;
    
    AddToBagViewController *addToBagViewController;
    
    BrowseViewController *browseViewController;
    
    ProductDetailsViewController *productDetailsViewController;
}

@property (nonatomic, retain)UITableView* specialProductTable; 

@property (nonatomic, retain) NSMutableArray *productImageArray;

@property (nonatomic, retain) NSMutableArray	*productNameArray;

@property (nonatomic, retain) NSMutableArray	*priceArray;


@property (nonatomic, retain) UIButton* review;

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

@property (nonatomic) BOOL loginChk;

@property (nonatomic, retain)ReviewViewController *reviewViewController;

@property (nonatomic, retain)AddToBagViewController *addToBagViewController;

@property (nonatomic, retain)BrowseViewController *browseViewController;

@property (nonatomic, retain) ProductDetailsViewController *productDetailsViewController;



-(void) loadNavigationBar;

-(void) initializeProductResults;

-(void)reviewButtonSelected :(id)sender;

-(void)goBack:(id)sender;

@end
