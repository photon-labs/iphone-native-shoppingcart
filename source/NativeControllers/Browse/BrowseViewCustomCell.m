//
//  BrowseViewCustomCell.m
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "BrowseViewCustomCell.h"


@implementation BrowseViewCustomCell

@synthesize productImageView;
@synthesize productLabel;
@synthesize productCountLabel;
@synthesize disImage;
@synthesize countImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
         if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             
             productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 50, 50)];
             
             disImage = [[UIImageView alloc] initWithFrame:CGRectMake(700, 16, 24, 37)];
             [disImage setBackgroundColor:[UIColor clearColor]];
             [self addSubview:disImage];
             
             productLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 7, 320, 70)];
             [productLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
             productLabel.backgroundColor = [UIColor clearColor];
             productLabel.textColor = [UIColor whiteColor];
             
             
             productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(510, 7, 60, 60)];
             [productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
             productCountLabel.backgroundColor = [UIColor clearColor];
             productCountLabel.textColor = [UIColor whiteColor];
             
             countImage = [[UIImageView alloc] initWithFrame:CGRectMake(490, 15, 70, 40)];
             [countImage setBackgroundColor:[UIColor clearColor]];
             [self addSubview:countImage];
             
             
             [self addSubview:productImageView];
             [self addSubview:productLabel];
             [self addSubview:productCountLabel];
         }
         else {
             
             productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 40)];
             
             disImage = [[UIImageView alloc] initWithFrame:CGRectMake(290, 16, 14, 21)];
             [disImage setBackgroundColor:[UIColor clearColor]];
             [self addSubview:disImage];
             
             productLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 150, 30)];
             [productLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
             productLabel.backgroundColor = [UIColor clearColor];
             productLabel.textColor = [UIColor whiteColor];
             
             
             productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 9, 30, 20)];
             [productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
             productCountLabel.backgroundColor = [UIColor clearColor];
             productCountLabel.textColor = [UIColor whiteColor];
             
             countImage = [[UIImageView alloc] initWithFrame:CGRectMake(220, 6, 40, 30)];
             [countImage setBackgroundColor:[UIColor clearColor]];
             [self addSubview:countImage];
             
             
             [self addSubview:productImageView];
             [self addSubview:productLabel];
             [self addSubview:productCountLabel];
         }
		
				
    }
    return self;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	
	[productImageView release];
	[productLabel release];
    [productCountLabel release];
    [super dealloc];
}


@end
