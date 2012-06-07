//
//  ProductDetailsViewController.h
//  Phresco
//
//  Created by photon on 11/11/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddToBagViewController;
@class ReviewViewController;
@class Tabbar;

@interface ProductDetailsViewController : UIViewController {

	UIScrollView *scrollView;
    UIImageView *starImage;
    BOOL loginChk;
    int index;
    
    Tabbar *tabbar;
    ReviewViewController* reviewViewController;
    AddToBagViewController *addToBagController;
   
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) AddToBagViewController *addToBagController;

@property (nonatomic, retain) ReviewViewController* reviewViewController;

@property (nonatomic) BOOL loginChk;

@property (nonatomic) int index;

-(void) loadNavigationBar;

-(void) initializeProductImageView;

-(void) initializeProductDescription;

-(void) setProductDetail;


@end
