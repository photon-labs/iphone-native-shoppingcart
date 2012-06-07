//
//  SpecialOfferCustomCell.m
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "SpecialOfferCustomCell.h"

@implementation SpecialOfferCustomCell
@synthesize productImage;
@synthesize productName;
@synthesize productPrice;
@synthesize priceLabel;
@synthesize reviewsButton;
@synthesize ratingsView;
@synthesize disImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            productName = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 350, 80)];
            [productName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
            productName.backgroundColor = [UIColor clearColor];
            productName.font = [UIFont fontWithName:@"Helvetica" size:24];
            productName.numberOfLines = 3;
            productName.textColor = [UIColor whiteColor];
            
            productImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 90)];
            [productImage setBackgroundColor:[UIColor clearColor]];
            
            priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 87, 75, 80)];
            
            [priceLabel setText:@"Price:"];
            [priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
            priceLabel.textColor = [UIColor whiteColor];
            [priceLabel setBackgroundColor:[UIColor clearColor]];
            
            productPrice = [[UILabel alloc] initWithFrame:CGRectMake(220, 87, 80, 80)];
            
            [productPrice setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
            productPrice.backgroundColor = [UIColor clearColor];
            productPrice.textColor = [UIColor yellowColor];
            
            
            reviewsButton = [[UIButton alloc] init];
            reviewsButton.frame = CGRectMake(600, 182, 120, 45);
            [reviewsButton setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
            
            disImage = [[UIImageView alloc] initWithFrame:CGRectMake(720, 90, 24, 37)];
            [disImage setBackgroundColor:[UIColor clearColor]];
            
            [self addSubview:disImage];
            [self addSubview:productName];
            [self addSubview:productImage];
            [self addSubview:productPrice];
            [self addSubview:priceLabel];
            [self addSubview:reviewsButton];
        }
        else {
		productName = [[UILabel alloc] initWithFrame:CGRectMake(75, 7, 210, 50)];
        [productName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		productName.backgroundColor = [UIColor clearColor];
		productName.font = [UIFont fontWithName:@"Helvetica" size:12];
        productName.numberOfLines = 3;
	    productName.textColor = [UIColor whiteColor];
        
		productImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 60, 60)];
        [productImage setBackgroundColor:[UIColor clearColor]];
		
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productName.frame.origin.x+10, (productName.frame.origin.y + productName.frame.size.height), 45, productName.frame.size.height)];
		
		[priceLabel setText:@"Price:"];
		[priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
		priceLabel.textColor = [UIColor whiteColor];
		[priceLabel setBackgroundColor:[UIColor clearColor]];
		
        productPrice = [[UILabel alloc] initWithFrame:CGRectMake((priceLabel.frame.origin.x + priceLabel.frame.size.width)  , priceLabel.frame.origin.y, 60, priceLabel.frame.size.height)];
        
       	[productPrice setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
		productPrice.backgroundColor = [UIColor clearColor];
        productPrice.textColor = [UIColor yellowColor];
        
		
		reviewsButton = [[UIButton alloc] init];
		reviewsButton.frame = CGRectMake(250, priceLabel.frame.origin.y + priceLabel.frame.size.height + 5, 70, 25);
		[reviewsButton setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
        
        disImage = [[UIImageView alloc] initWithFrame:CGRectMake(290, 60, 14, 21)];
        [disImage setBackgroundColor:[UIColor clearColor]];
            
        [self addSubview:disImage];
        
		[self addSubview:productName];
		[self addSubview:productImage];
		[self addSubview:productPrice];
		[self addSubview:priceLabel];
		[self addSubview:reviewsButton];
        
    }
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}


- (void)dealloc {
	
	[productImage release];
    [productPrice release];
	[priceLabel release];
	[reviewsButton release];
    [ratingsView release];
	[super dealloc];
}


@end
