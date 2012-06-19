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
//  RegistrationViewController.h
//  Phresco
//
//  Created by chandramouli shivakumar on 11/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tabbar;

@interface RegistrationViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate> {
    
    
    
    UITextField* firstName;
    UITextField* lastName;
    UITextField* emailAddress;
    UITextField* passWord;
    UITextField* confirmPassword;
    UITextField* phoneNumber;
    UIScrollView* regScrollView;
    UIView* backGroundView;
    UIView *viewController;
    UIButton *okButton;
    UIButton *closeButton;
    UIImageView *myImageView;
    
    UIButton* registerButton;
    UIButton* cancelButton;
    UIActivityIndicatorView* activityIndicator;
    Tabbar *tabbar;
    
}

@property (nonatomic, retain) UIView* backGroundView;
@property (nonatomic, retain)  UIView *viewController;
@property (nonatomic, retain) UIButton *okButton;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) UIButton* registerButton;
@property (nonatomic, retain) UIButton* cancelButton;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

-(void) loadNavigationBar;

-(void) createRegistrationScreen;

- (BOOL)validateEmail:(NSString *)inputText;
   

@end
