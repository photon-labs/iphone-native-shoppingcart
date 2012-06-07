//
//  SpecialOfferCustomCell.h
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialOfferCustomCell : UITableViewCell
{
    UIImageView		*productImage;
	
	UILabel		    *productName;
    
    UILabel			*productPrice;
    
	UILabel			*priceLabel;
    
	UIButton		*reviewsButton;
	
	UIImageView		*ratingsView;
    
    UIImageView     *disImage;
}


@property (nonatomic, retain) UIImageView		*productImage;

@property (nonatomic, retain) UILabel		    *productName;

@property (nonatomic, retain) UILabel			*productPrice;

@property (nonatomic, retain) UILabel			*priceLabel;

@property (nonatomic, retain) UIButton		    *reviewsButton;

@property (nonatomic, retain)UIImageView		*ratingsView;

@property (nonatomic, retain)UIImageView		*disImage;

@end
