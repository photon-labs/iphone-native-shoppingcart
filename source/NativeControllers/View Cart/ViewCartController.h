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
//  ViewCartController.h
//  Phresco
//
//  Created by photon on 11/25/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckOutViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;

@interface ViewCartController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UITableView* viewCartTable;
    UILabel* Quantity;
    UILabel* Product;
    UILabel* Price;
    UILabel *lblSubtotal;
    UILabel* PriceLabel;
    
    NSString *cartPurchaseTotal;
    NSString *cartQuantity;
    
    CheckOutViewController  *checkCartController;
    
    BrowseViewController *browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    Tabbar *tabbar;
    
}
@property(nonatomic, retain)  UITableView* viewCartTable;

@property(nonatomic, retain)UILabel* Quantity;

@property(nonatomic, retain)UILabel*  Product;

@property(nonatomic, retain)UILabel*  Price;

@property(nonatomic, retain)UILabel*  PriceLabel;

@property (nonatomic, retain) NSString *cartPurchaseTotal;

@property (nonatomic, retain) NSString *cartQuantity;

@property (nonatomic, retain) CheckOutViewController  *checkCartController;

@property (nonatomic, retain) BrowseViewController *browseViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;



-(void) loadNavigationBar;
-(void) initializeTableView;
-(void)goBack:(id)sender;
@end

