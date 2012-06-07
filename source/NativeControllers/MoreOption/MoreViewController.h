//
//  MoreViewController.h
//  Phresco
//
//  Created by bharat kumar on 07/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tabbar;

@interface MoreViewController : UIViewController<UITextViewDelegate>
{
    UIView* moreView;
    Tabbar *tabbar;
}
@property (nonatomic, retain) UIView* moreView;

-(void) loadNavigationBar;
-(void) initializeTextView;
-(void)goBack:(id)sender;
@end
