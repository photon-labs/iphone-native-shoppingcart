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
