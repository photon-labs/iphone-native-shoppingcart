//
//  ViewCartController.h
//  Phresco
//
//  Created by photon on 11/25/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckOutViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;

@interface ViewCartController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UITableView* viewCartTable;
    UILabel* Quantity;
    UILabel* Product;
    UILabel* Price;
    UILabel *lblSubtotal;
    UILabel* PriceLabel;
    
    NSString *cartPurchaseTotal;
    NSString *cartQuantity;
    
    CheckOutViewController  *checkCartController;
    
    BrowseViewController *browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    Tabbar *tabbar;
    
}
@property(nonatomic, retain)  UITableView* viewCartTable;

@property(nonatomic, retain)UILabel* Quantity;

@property(nonatomic, retain)UILabel*  Product;

@property(nonatomic, retain)UILabel*  Price;

@property(nonatomic, retain)UILabel*  PriceLabel;

@property (nonatomic, retain) NSString *cartPurchaseTotal;

@property (nonatomic, retain) NSString *cartQuantity;

@property (nonatomic, retain) CheckOutViewController  *checkCartController;

@property (nonatomic, retain) BrowseViewController *browseViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;



-(void) loadNavigationBar;
-(void) initializeTableView;
-(void)goBack:(id)sender;
@end

