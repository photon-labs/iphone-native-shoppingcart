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
//  CheckOutOVerallViewController.h
//  Phresco
//
//  Created by photon on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderStatusViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;

@interface CheckOutOVerallViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
   
    UIButton *btnSaved;
    NSString *strFirst;
    NSString *strLast;
    NSString *strComp;
    NSString *strAddr1;
    NSString *strAddr2;
    NSString *strCity;
    NSString *strState;
    NSString *strCountry;
    NSString *strZip;
    NSString *strPhone;
    NSString *strEmailId;
    NSString *strOrderComments;
    
    UITableView		*addToBagTable;
    NSMutableArray *productImageArray;
	NSMutableArray	*productNameArray;
    NSMutableIndexSet *expandedSections;
    NSMutableData *receivedData;
	NSURLResponse *response;
	NSError *error;
	NSData *data;
	NSString *responseString;
    NSString *stringTotalPrice;
    UIActivityIndicatorView* activityIndicator;

    Tabbar *tabbar;
    OrderStatusViewController* orderStatusViewController;
    BrowseViewController* browseViewController;
    SpecialOffersViewController *specialOffersViewController;
}


@property (nonatomic, retain) UITableView	*addToBagTable;

@property (nonatomic, retain) NSMutableArray *productImageArray;

@property (nonatomic, retain) NSMutableArray	*productNameArray;

@property (nonatomic, retain)  NSString *strFirst;

@property (nonatomic, retain)  NSString *strLast;

@property (nonatomic, retain)  NSString *strComp;

@property (nonatomic, retain)  NSString *strAddr1;

@property (nonatomic, retain)  NSString *strAddr2;

@property (nonatomic, retain)  NSString *strCity;

@property (nonatomic, retain)  NSString *strState;

@property (nonatomic, retain)  NSString *strCountry;

@property (nonatomic, retain)  NSString *strZip;

@property (nonatomic, retain)  NSString *strPhone;

@property (nonatomic, retain)  NSString *strEmailId;

@property (nonatomic, retain)  NSString *strOrderComments;

@property (nonatomic, retain)  NSString *stringTotalPrice;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, retain)  SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, retain) OrderStatusViewController *orderStatusViewController;

@property (nonatomic, retain)  BrowseViewController *browseViewController;


-(void)goBack:(id)sender;

-(void) loadNavigationBar;

-(void) initializeTableView;

-(void)reviewAction:(id)sender;

-(void)cancelAction:(id)sender;


@end
