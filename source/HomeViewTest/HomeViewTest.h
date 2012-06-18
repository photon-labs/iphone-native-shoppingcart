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
//  HomeViewTest.h
//  HomeViewTest
//
//  Created by bharat kumar on 23/03/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIkit.h>

#import "PhrescoAppDelegate.h"
#import "RootViewController.h"
#import "HomeViewController.h"
#import "BrowseViewController.h"
#import "ResultViewController.h"
#import "ProductDetailsViewController.h"
#import "AddToBagViewController.h"
#import "ViewCartController.h"
#import "CheckOutViewController.h"
#import "CheckOutOVerallViewController.h"
#import "ReviewViewController.h"
#import "ReviewCommentsViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "SpecialOffersViewController.h"

@interface HomeViewTest : SenTestCase
{
@private
iShopAppDelegate *appDelegate;
RootViewController *rootController;
HomeViewController *homeController;
BrowseViewController *browseController;
ResultViewController *resultController;
ProductDetailsViewController *pdtDetailController;
AddToBagViewController *addCartController;
ViewCartController *viewCartController;
CheckOutViewController *checkViewController;
CheckOutOVerallViewController *checkOverallController;
ReviewViewController *reviewController;
ReviewCommentsViewController *reviewCommentsController;
LoginViewController *loginController;
RegistrationViewController *registerController;
SpecialOffersViewController *splOfferController;
    
    UITableView *tblView;
}
-(void) testAction;
@end
