//
//  ResultViewCustomCell.m
//  Phresco
//
//  Created by photon on 11/10/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "ResultViewCustomCell.h"


@implementation ResultViewCustomCell

@synthesize productImage;
@synthesize productName;
@synthesize productPrice;
@synthesize priceLabel;
@synthesize reviewsButton;
@synthesize dollarSign;
@synthesize ratingsView;
@synthesize imageFramesArray;
@synthesize isSelected;
@synthesize disImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            productName = [[UILabel alloc] initWithFrame:CGRectMake(135, 22, 390, 70)];
            [productName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
            productName.backgroundColor = [UIColor clearColor];
            productName.font = [UIFont fontWithName:@"Helvetica" size:24];
            productName.numberOfLines = 3;
            productName.textColor = [UIColor whiteColor];
            
            
            productImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 90, 90)];
            [productImage setBackgroundColor:[UIColor clearColor]];
            
            priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productName.frame.origin.x+10, (productName.frame.origin.y + productName.frame.size.height), 75, productName.frame.size.height)];
            
            [priceLabel setText:@"Price:"];
            [priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            priceLabel.textColor = [UIColor whiteColor];
            [priceLabel setBackgroundColor:[UIColor clearColor]];
            
            
            dollarSign = [[UILabel alloc] initWithFrame:CGRectMake( (priceLabel.frame.origin.x + priceLabel.frame.size.width)  , priceLabel.frame.origin.y, 15, priceLabel.frame.size.height)]; 
            
            [dollarSign setText:@"$"];
            [dollarSign setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            dollarSign.textColor = [UIColor yellowColor];
            [dollarSign setBackgroundColor:[UIColor clearColor]];
            
            productPrice = [[UILabel alloc] initWithFrame:CGRectMake( (dollarSign.frame.origin.x + dollarSign.frame.size.width), dollarSign.frame.origin.y , dollarSign.frame.size.width + 100, dollarSign.frame.size.height)];
            [productPrice setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            productPrice.backgroundColor = [UIColor clearColor];
            productPrice.textColor = [UIColor yellowColor];
            
            
            reviewsButton = [[UIButton alloc] init];
            reviewsButton.frame = CGRectMake(590, priceLabel.frame.origin.y + priceLabel.frame.size.height + 5, 110, 45);
            [reviewsButton setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
            
                       
            disImage = [[UIImageView alloc] initWithFrame:CGRectMake(720, 60, 24, 37)];
            [disImage setBackgroundColor:[UIColor clearColor]];
            
            [self addSubview:disImage];
            [self addSubview:productName];
            [self addSubview:productImage];
            [self addSubview:productPrice];
            [self addSubview:priceLabel];
            [self addSubview:dollarSign];
            [self addSubview:reviewsButton];
        }
        else {
            
            productName = [[UILabel alloc] initWithFrame:CGRectMake(75, 7, 210, 35)];
            [productName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            productName.backgroundColor = [UIColor clearColor];
            productName.font = [UIFont fontWithName:@"Helvetica" size:12];
            productName.numberOfLines = 3;
            productName.textColor = [UIColor whiteColor];
            
            
            productImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 60, 60)];
            [productImage setBackgroundColor:[UIColor clearColor]];
            
            priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productName.frame.origin.x+10, productName.frame.size.height, 45, productName.frame.size.height)];
            
            [priceLabel setText:@"Price:"];
            [priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
            priceLabel.textColor = [UIColor whiteColor];
            [priceLabel setBackgroundColor:[UIColor clearColor]];
            
            
            dollarSign = [[UILabel alloc] initWithFrame:CGRectMake( (priceLabel.frame.origin.x + priceLabel.frame.size.width)  , priceLabel.frame.origin.y, 15, priceLabel.frame.size.height)]; 
            
            [dollarSign setText:@"$"];
            [dollarSign setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
            dollarSign.textColor = [UIColor yellowColor];
            [dollarSign setBackgroundColor:[UIColor clearColor]];
            
            productPrice = [[UILabel alloc] initWithFrame:CGRectMake( (dollarSign.frame.origin.x + dollarSign.frame.size.width), dollarSign.frame.origin.y , dollarSign.frame.size.width + 100, dollarSign.frame.size.height)];
            [productPrice setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
            productPrice.backgroundColor = [UIColor clearColor];
            productPrice.textColor = [UIColor yellowColor];
            
            
            reviewsButton = [[UIButton alloc] init];
            reviewsButton.frame = CGRectMake(200, priceLabel.frame.origin.y + priceLabel.frame.size.height + 5, 70, 25);
            [reviewsButton setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
            
            disImage = [[UIImageView alloc] initWithFrame:CGRectMake(290, 50, 14, 21)];
            [disImage setBackgroundColor:[UIColor clearColor]];
            
            [self addSubview:disImage];
            [self addSubview:productName];
            [self addSubview:productImage];
            [self addSubview:productPrice];
            [self addSubview:priceLabel];
            [self addSubview:dollarSign];
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
    [dollarSign release];
    [ratingsView release];
    [imageFramesArray release];
	[super dealloc];
}


@end
