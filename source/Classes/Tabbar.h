//
//  Tabbar.h
//
//  Created by PHOTON on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabbarRect	CGRectMake(0, 413, 320, 49)

@interface Tabbar : UIView {

    NSArray *viewControllers;
    NSInteger selectedIndex;
    NSInteger lastSelectedIndex;
}

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger selectedIndex;

- (UIView*)initWithInfo:(NSArray*)names;
- (void)setControllers:(NSArray*)controllers;
- (void)setSelectedIndex:(int)index fromSender:sender;
- (void)highlightTab:(UIButton*)button atIndex:(int)index;
- (void)highlightTabAtIndex:(int)index;
- (void)unHighlightLastSelectedTab;
- (UIImage*) getImageForButton:(NSString*)btnTitle  isHighlighted:(BOOL)isHighlighted;
- (void)reloadFeatureTab:(int)index;

@end
