//
//  BrowseViewCustomCell.h
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrowseViewCustomCell : UITableViewCell {

	UIImageView *productImageView;
	
	UILabel *productLabel;
    UILabel *productCountLabel;
    UIImageView* disImage;
    UIImageView* countImage;
}

@property (nonatomic, retain) UIImageView *productImageView;

@property (nonatomic, retain) UILabel *productLabel;

@property (nonatomic, retain) UILabel *productCountLabel;

@property(nonatomic, retain) UIImageView* disImage;

@property(nonatomic, retain) UIImageView* countImage;

@end
