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
//  HomeViewController.h
//  Phresco
//
//  Created by photon on 11/2/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class LoginViewController;
@class RegistrationViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class ResultViewController;
@class Tabbar;
@class SubmitReviewViewController;

@interface HomeViewController : UIViewController<UISearchBarDelegate, UITextFieldDelegate> {

	
    UITextField	*searchTextField;
    
    UIButton *btnSearchIcon;

    NSMutableArray* array;

    UIActivityIndicatorView* activityIndicator;
    
    Tabbar *tabbar;
    
    SubmitReviewViewController* SubmitReviewViewController;
    
    LoginViewController *loginViewController;
    
    RegistrationViewController  *registrationViewController;
	
	BrowseViewController		*browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    ResultViewController        *resultViewController;

}


@property (nonatomic, retain) UITextField	*searchTextField;

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, retain) NSMutableArray* array_;

@property (nonatomic, retain) LoginViewController *loginViewController;

@property (nonatomic, retain) RegistrationViewController  *registrationViewController;

@property (nonatomic, retain) BrowseViewController		*browseViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, retain) ResultViewController        *resultViewController;

@property (nonatomic, retain) SubmitReviewViewController *submitReviewViewController;



-(void) loadNavigationBar;

-(void) addSearchBar;

-(void) addHomePageIcons;

-(BOOL) checkIfOdd:(int) num;

-(void) buttonAction:(id) sender;

- (void)searchButtonSelected;

@end
