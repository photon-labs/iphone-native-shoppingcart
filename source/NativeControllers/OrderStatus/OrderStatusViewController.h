//
//  OrderStatusViewController.h
//  Phresco
//
//  Created by bharat kumar on 07/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrowseViewController;
@class Tabbar;

@interface OrderStatusViewController : UIViewController<UITextViewDelegate>
{
    UITextView* orderStatusTextView;//orderStatusTextView
    BrowseViewController* browseViewController;
    Tabbar *tabbar;
}
@property (nonatomic, retain) UITextView* orderStatusTextView;
@property (nonatomic, retain) BrowseViewController* browseViewController;

-(void) loadNavigationBar;
-(void) initializeTextView;
-(void)goBack:(id)sender;
@end
