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
//  BrowseViewController.h
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResultViewController;
@class AddToBagViewController;
@class ProductDetailsViewController;
@class SpecialOffersViewController;
@class Tabbar;
@class LoginViewController;

@interface BrowseViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {

	IBOutlet UISearchBar *searchBar;
	
	IBOutlet UITableView	*productTable;
	
	IBOutlet NSMutableArray *productImageArray;
	
	IBOutlet NSMutableArray	*productNameArray;
    
    IBOutlet NSMutableArray  *productCountArray; 
	
    IBOutlet UITextField	*txtBar;
    
    IBOutlet UIButton *btnSearchIcon;
    
    BOOL loginChk;
    
    NSMutableArray* array_;
    
    UIActivityIndicatorView* activityIndicator;
    
    Tabbar *tabbar;
    
    LoginViewController* loginViewController;
    
    ResultViewController *resultViewController;
    
    AddToBagViewController* addToBagViewController;
    
    ProductDetailsViewController* product;
    
    SpecialOffersViewController *specialOffersViewController;
    
   
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) IBOutlet UITableView	*productTable;

@property (nonatomic, retain) IBOutlet NSMutableArray *productImageArray;

@property (nonatomic, retain) IBOutlet NSMutableArray	*productNameArray;

@property (nonatomic, retain) IBOutlet NSMutableArray  *productCountArray;

@property (nonatomic) BOOL loginChk;

@property (nonatomic, retain) NSMutableArray* array_;

@property (nonatomic, retain) ResultViewController *resultViewController;

@property (nonatomic, retain) AddToBagViewController* addToBagViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, retain) LoginViewController* loginViewController;


-(void) loadNavigationBar;

-(void) addSearchBar;

-(void) initializeTableView;

- (void)searchButtonSelected:(id)sender;


@end
