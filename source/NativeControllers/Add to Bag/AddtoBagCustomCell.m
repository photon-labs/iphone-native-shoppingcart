//
//  AddtoBagCustomCell.m
//  Phresco
//
//  Created by photon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddtoBagCustomCell.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "AddToBagViewController.h"


@implementation AddtoBagCustomCell
@synthesize productImageView;
@synthesize productLabel;
@synthesize productCountLabel;
@synthesize Quantity;
@synthesize quantityTextView;
@synthesize priceLabel;
@synthesize priceValue;
@synthesize btnRemove;
@synthesize delObj;
@synthesize strQuantity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
		productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 70)];
		
		
		productLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 240, 60)];
		[productLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		productLabel.backgroundColor = [UIColor clearColor];
        productLabel.numberOfLines = 2;
        [productLabel setTextColor:[UIColor whiteColor]];
        
		Quantity = [[UILabel alloc] initWithFrame:CGRectMake(productLabel.frame.origin.x, productLabel.frame.size.height + 20, 240, 60)];
		[Quantity setFont:[UIFont fontWithName:@"Helvetica" size:28]];
		Quantity.backgroundColor = [UIColor clearColor];
        [Quantity setText:@"Quantity: "];
        [Quantity setTextColor:[UIColor whiteColor]];
        
        
        quantityTextView = [[UITextField alloc] initWithFrame:CGRectMake(Quantity.frame.size.width , productLabel.frame.size.height + 25, 60, 30)];
        [quantityTextView setBackgroundColor:[UIColor whiteColor]];
        quantityTextView.keyboardType = UIKeyboardTypeDefault;
        quantityTextView.returnKeyType = UIReturnKeyDone;
        [quantityTextView setEnabled: YES];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productLabel.frame.origin.x, productLabel.frame.size.height+ Quantity.frame.size.height ,80, 50)];
		[priceLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		priceLabel.backgroundColor = [UIColor clearColor];
        [priceLabel setText:@"Price: "];
        [priceLabel setTextColor:[UIColor whiteColor]];
        
        priceValue = [[UILabel alloc] initWithFrame:CGRectMake(210,80 , 80, 50)];
		[priceValue setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		priceValue.backgroundColor = [UIColor clearColor];
        [priceValue setTextColor:[UIColor yellowColor]];
        
        productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 10, 60, 50)];
		[productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		productCountLabel.backgroundColor = [UIColor clearColor];
        
        
		[self addSubview:productImageView];
		[self addSubview:productLabel];
        [self addSubview:productCountLabel];
        [self addSubview:Quantity];
        [self addSubview:priceLabel];
        [self addSubview:priceValue];
        [self addSubview:btnRemove];
        [self addSubview:quantityTextView];
        
        
    }
    
    else {
        
        productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 40)];
		
		
		productLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 7, 150, 30)];
		[productLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		productLabel.backgroundColor = [UIColor clearColor];
        productLabel.numberOfLines = 2;
        [productLabel setTextColor:[UIColor whiteColor]];
        
		Quantity = [[UILabel alloc] initWithFrame:CGRectMake(productLabel.frame.origin.x, productLabel.frame.size.height + 10, 150, 30)];
		[Quantity setFont:[UIFont fontWithName:@"Helvetica" size:14]];
		Quantity.backgroundColor = [UIColor clearColor];
        [Quantity setText:@"Quantity: "];
        [Quantity setTextColor:[UIColor whiteColor]];
        
        
        quantityTextView = [[UITextField alloc] initWithFrame:CGRectMake(Quantity.frame.size.width , productLabel.frame.size.height + 15, 40, 20)];
        [quantityTextView setBackgroundColor:[UIColor whiteColor]];
        quantityTextView.keyboardType = UIKeyboardTypeDefault;
        quantityTextView.returnKeyType = UIReturnKeyDone;
        [quantityTextView setEnabled: YES];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productLabel.frame.origin.x, productLabel.frame.size.height+ Quantity.frame.size.height ,50, 30)];
		[priceLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		priceLabel.backgroundColor = [UIColor clearColor];
        [priceLabel setText:@"Price: "];
        [priceLabel setTextColor:[UIColor whiteColor]];
        
        priceValue = [[UILabel alloc] initWithFrame:CGRectMake(120,60 , 50, 30)];
		[priceValue setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		priceValue.backgroundColor = [UIColor clearColor];
        [priceValue setTextColor:[UIColor yellowColor]];
        
        productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 7, 40, 30)];
		[productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		productCountLabel.backgroundColor = [UIColor clearColor];
        
        
		[self addSubview:productImageView];
		[self addSubview:productLabel];
        [self addSubview:productCountLabel];
        [self addSubview:Quantity];
        [self addSubview:priceLabel];
        [self addSubview:priceValue];
        [self addSubview:btnRemove];
        [self addSubview:quantityTextView];
        
        
    }

    }
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}


- (void)dealloc {
	
	[productImageView release];
	[productLabel release];
    [productCountLabel release];
    [super dealloc];
}



@end
