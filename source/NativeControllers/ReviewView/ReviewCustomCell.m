//
//  ReviewCustomCell.m
//  Phresco
//
//  Created by bharat kumar on 03/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "ReviewCustomCell.h"

@implementation ReviewCustomCell

@synthesize  commentsLabel;
@synthesize ratingImage;
@synthesize disImage;
@synthesize userNameLabel;
@synthesize dateLabel;
@synthesize imageFramesArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 600, 120)];
        [commentsLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		commentsLabel.backgroundColor = [UIColor clearColor];
        commentsLabel.numberOfLines = 3;
	    commentsLabel.textColor = [UIColor whiteColor];
        [self addSubview:commentsLabel];
        
        disImage = [[UIImageView alloc] initWithFrame:CGRectMake(730, 100, 20, 31)];
        [disImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:disImage];
        
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 0, 200, 50)];
        [userNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		userNameLabel.backgroundColor = [UIColor clearColor];
	    userNameLabel.textColor = [UIColor yellowColor];
        [self addSubview:userNameLabel];  
         
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentsLabel.frame.origin.x,commentsLabel.frame.origin.y+ commentsLabel.frame.size.height + 10, 300, 50)]; 
        [dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		dateLabel.backgroundColor = [UIColor clearColor];
	    dateLabel.textColor = [UIColor whiteColor];
        [self addSubview:dateLabel];  
        }
        else {
            commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 260, 65)];
            [commentsLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            commentsLabel.backgroundColor = [UIColor clearColor];
            commentsLabel.numberOfLines = 3;
            commentsLabel.textColor = [UIColor whiteColor];
            [self addSubview:commentsLabel];
            
            disImage = [[UIImageView alloc] initWithFrame:CGRectMake(300, 30, 14, 21)];
            [disImage setBackgroundColor:[UIColor clearColor]];
            [self addSubview:disImage];
            
            userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 100, 25)];
            [userNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            userNameLabel.backgroundColor = [UIColor clearColor];
            userNameLabel.textColor = [UIColor yellowColor];
            [self addSubview:userNameLabel];  
            
            dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentsLabel.frame.origin.x,commentsLabel.frame.origin.y+ commentsLabel.frame.size.height + 10, 200, 30)];
            [dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.textColor = [UIColor whiteColor];
            [self addSubview:dateLabel];  
        }
        
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}


- (void)dealloc {
	
    [commentsLabel release];
    [dateLabel release];
    [userNameLabel release];
    [disImage release];
    [super dealloc];
}

@end

