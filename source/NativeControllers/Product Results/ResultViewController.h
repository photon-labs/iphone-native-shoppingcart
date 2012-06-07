//
//  ResultViewController.h
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductDetailsViewController;
@class ReviewViewController;
@class AddToBagViewController;
@class SpecialOffersViewController;
@class Tabbar;
@class LoginViewController;

@interface ResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;
	
	UITableView		*resultTable;
	
	NSMutableArray	*priceArray;
    
    
    
    NSMutableArray* array_;
    
    BOOL loginChk;
    
    int index;
    
    UIActivityIndicatorView* activityIndicator;
    
	ProductDetailsViewController *productDetailsViewController;
    
	ReviewViewController* reviewViewController;
    
    AddToBagViewController* addToBagViewController;

    SpecialOffersViewController *specialOffersViewController;

    LoginViewController* loginViewController;

     Tabbar *tabbar;
    
}

@property (nonatomic, retain) NSMutableArray *productImageArray;

@property (nonatomic, retain) NSMutableArray	*productNameArray;

@property (nonatomic, retain) UITableView		*resultTable;

@property (nonatomic, retain) NSMutableArray	*priceArray;



@property (nonatomic) BOOL loginChk;

@property (nonatomic, retain) NSMutableArray* array_;

@property (nonatomic, retain) AddToBagViewController* addToBagViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, retain)LoginViewController* loginViewController;

@property (nonatomic, retain) ProductDetailsViewController *productDetailsViewController;

@property (nonatomic, retain) ReviewViewController *reviewViewController;


-(void) loadNavigationBar;

-(void) initializeProductResults;

-(void) finishedProductDetialsService:(id) data;

-(void)reviewButtonSelected :(id)sender;

@end
