//
//  AddtoBagCustomCell.h
//  Phresco
//
//  Created by photon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddtoBagCustomCell : UITableViewCell
{

    UIImageView *productImageView;

    UILabel *productLabel;
    
    UILabel *productCountLabel;

    UILabel	*Quantity;
        
	UILabel	*priceLabel;
    
    UILabel	*priceValue;
    
    UITextField *quantityTextView;
    
    UIButton *btnRemove;
    
    NSString *delObj;
    
    NSString *strQuantity;
    
}

@property (nonatomic, retain) UIImageView *productImageView;

@property (nonatomic, retain) UILabel *productLabel;

@property (nonatomic, retain) UILabel *productCountLabel;

@property (nonatomic, retain) UILabel *Quantity;

@property (nonatomic, retain) UILabel *priceLabel;

@property (nonatomic, retain) UILabel *priceValue;

@property (nonatomic, retain) UITextField* quantityTextView;

@property (nonatomic, retain) UIButton *btnRemove;

@property (nonatomic, retain)  NSString *delObj;

@property (nonatomic, retain)  NSString *strQuantity;


@end
