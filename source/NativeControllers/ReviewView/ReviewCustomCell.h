//
//  ReviewCustomCell.h
//  Phresco
//
//  Created by bharat kumar on 03/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCustomCell : UITableViewCell
{
    UIImageView* ratingImage;
    UILabel* commentsLabel;
    UIImageView* disImage;
    UILabel *userNameLabel;
    UILabel *dateLabel;
    NSMutableArray            *imageFramesArray;
}
@property(nonatomic, retain) UILabel*  commentsLabel;
@property(nonatomic, retain) UIImageView* ratingImage;
@property(nonatomic, retain) UIImageView* disImage;
@property (nonatomic, retain) UILabel *userNameLabel; 
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) NSMutableArray *imageFramesArray;

@end
