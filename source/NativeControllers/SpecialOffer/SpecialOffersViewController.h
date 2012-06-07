//
//  SpecialOffersViewController.h
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReviewViewController;
@class AddToBagViewController;
@class BrowseViewController;
@class ProductDetailsViewController;
@class Tabbar;

@interface SpecialOffersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* specialProductTable;
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;

    NSMutableArray	*priceArray;
    
        
    UIButton* review;
    
    UIActivityIndicatorView* activityIndicator;
    
    BOOL loginChk;
    
    int index;

    Tabbar *tabbar;
    
    ReviewViewController *reviewViewController;
    
    AddToBagViewController *addToBagViewController;
    
    BrowseViewController *browseViewController;
    
    ProductDetailsViewController *productDetailsViewController;
}

@property (nonatomic, retain)UITableView* specialProductTable; 

@property (nonatomic, retain) NSMutableArray *productImageArray;

@property (nonatomic, retain) NSMutableArray	*productNameArray;

@property (nonatomic, retain) NSMutableArray	*priceArray;


@property (nonatomic, retain) UIButton* review;

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

@property (nonatomic) BOOL loginChk;

@property (nonatomic, retain)ReviewViewController *reviewViewController;

@property (nonatomic, retain)AddToBagViewController *addToBagViewController;

@property (nonatomic, retain)BrowseViewController *browseViewController;

@property (nonatomic, retain) ProductDetailsViewController *productDetailsViewController;



-(void) loadNavigationBar;

-(void) initializeProductResults;

-(void)reviewButtonSelected :(id)sender;

-(void)goBack:(id)sender;

@end
