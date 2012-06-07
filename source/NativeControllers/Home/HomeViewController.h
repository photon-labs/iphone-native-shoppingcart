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
