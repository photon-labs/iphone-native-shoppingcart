//
//  LoginViewController.h
//  Phresco
//
//  Created by photon on 11/3/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistrationViewController;
@class iShopAppDelegate;
@class Tabbar;
@class SubmitReviewViewController;
@class BrowseViewController;
@class HomeViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate> {

	UITextField *emailAddress;
    
    UITextField *password;
    RegistrationViewController *registrationViewController;
    UIButton *backButton;
    
    UIButton *closeButton;
    UIButton *okButton;
    UIButton* registerButton;
    UIButton *button_;
    UIButton *loginButton;
    UIButton *cancelButton;
    iShopAppDelegate* appDelegate;
    UIActivityIndicatorView* activityIndicator;
    Tabbar *tabbar;
    
    int index;
    BOOL isLogin;
    
    
    NSMutableString* strMsg; 
   
    NSMutableString* successMsg; 
    
    NSMutableString* userID; 
    
    NSMutableString* userName;
   
    NSMutableArray* loginArray;
    
    SubmitReviewViewController* submitReviewViewController;
    
    BrowseViewController *browseViewController;
    
    HomeViewController *homeViewController;
    
}

@property (nonatomic, retain) UITextField *emailAddress;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIButton *okButton;
@property (nonatomic, retain) UIButton* registerButton;
@property (nonatomic, retain) UIButton* button_;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property  BOOL isLogin;

@property (nonatomic, retain)NSMutableString* strMsg;
@property (nonatomic, retain) NSMutableString* successMsg; 
@property (nonatomic, retain)NSMutableString* userID; 
@property (nonatomic, retain)NSMutableString* userName;
@property (nonatomic, retain)NSMutableArray* loginArray;

@property (nonatomic, retain) SubmitReviewViewController* submitReviewViewController;
@property (nonatomic, retain) BrowseViewController *browseViewController;
@property (nonatomic, retain)  HomeViewController *homeViewController;
@property (nonatomic, retain) RegistrationViewController *registrationViewController;


-(void) loadNavigationBar;

-(void) createLoginScreen;

@end
