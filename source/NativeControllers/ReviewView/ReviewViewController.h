//
//  ReviewViewController.h
//  Phresco
//
//  Created by bharat kumar on 27/12/11.
//  Copyright (c) 2011 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddToBagViewController;
@class SubmitReviewViewController;
@class SpecialOffersViewController;
@class ReviewCommentsViewController;
@class Tabbar;
@class LoginViewController;
@interface ReviewViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    
    UITableView* reviewTableView;
    UITextView* reviewTextview;
    
    UILabel* oneStar;
    UILabel* twoStar;
    UILabel* threeStar;
    UILabel* fourStar;
    UILabel* fiveStar;
       
    NSMutableArray* commentArray;
    UIImageView *starImage ;
    NSMutableArray* averageArray;
    UILabel* average;
    
    AddToBagViewController* addToBagViewController;
    
    SubmitReviewViewController *submitReviewViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    ReviewCommentsViewController *reviewCommentsViewController;
    
    UIButton* submitReview;
    
    NSString* revId;
    
    NSString *stringAverage;
    
    Tabbar *tabbar;
     BOOL isSpecialOffer;
    
    LoginViewController* loginViewController;
    
   BOOL loginChk;
    int reviewProductId;
    
    NSMutableArray* array_;
}
@property (nonatomic, retain) NSMutableArray* commentArray;
@property (nonatomic, retain) NSMutableArray* averageArray;
@property (nonatomic, retain) UITableView* reviewTableView;
@property (nonatomic, retain) UITextView* reviewTextview;
@property (nonatomic, retain) UILabel* oneStar;
@property (nonatomic, retain) UILabel* twoStar;
@property (nonatomic, retain) UILabel* threeStar;
@property (nonatomic, retain) UILabel* fourStar;
@property (nonatomic, retain) UILabel* fiveStar;
@property (nonatomic, retain) NSMutableArray* array_;
@property (nonatomic, retain) UILabel* average;
@property (nonatomic, retain) UIButton* submitReview;
@property (nonatomic) BOOL isSpecialOffer;
@property (nonatomic) BOOL loginChk;
@property (nonatomic) int reviewProductId;

@property (nonatomic, retain) LoginViewController* loginViewController;

@property (nonatomic, retain) AddToBagViewController* addToBagViewController;

@property (nonatomic, retain) SubmitReviewViewController *submitReviewViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, retain)ReviewCommentsViewController *reviewCommentsViewController;

-(void) loadNavigationBar;
-(void) initializeTableView;
-(void) goBack:(id) sender;
-(void)ratingValuechanged:(id)sender;
-(void)submitReviewButtonSelected:(id)sender;


@end
