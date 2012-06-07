//
//  NavigationBar.m
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NavigationBar.h"
#import "DebugOutput.h"

@implementation NavigationBar

@synthesize showSearch;
@synthesize showBackButton;
@synthesize delegate;
@synthesize infoButton, searchButton, backgroundImage, plusButton, previousButton, backButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		[self addSubview:backgroundImage];
		
		self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[infoButton setFrame:CGRectMake(10, 16, 17, 17)];
		[infoButton addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:infoButton];

		self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[searchButton setFrame:CGRectMake(280, 10, 26, 25)];
		[self addSubview:searchButton];
	
    }
    return self;
}

-(void)setHeaderImages:(NSDictionary*)imagesDict{

	debug(@"%@",imagesDict);
		
	NSEnumerator *enumerator = [imagesDict keyEnumerator];
	id key;
	
	while ((key = [enumerator nextObject])) {

		if([key isEqualToString:@"InformationIcon"])
			[self.infoButton setImage:[imagesDict objectForKey:key] forState:UIControlStateNormal];
		if([key isEqualToString:@"SearchIcon"])	
			[self.searchButton setImage:[imagesDict objectForKey:key] forState:UIControlStateNormal];
	}

}
							  
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 // Drawing code
}

-(void)back:(id)sender {
	
}

-(void)search:(id)sender {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Progress" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	
	[alert show];
	
	[alert release];
	
}

-(void)addToWishList:(id)sender {
	
}

-(void)hideInfoButton:(BOOL)hide {
	
}

-(void)infoAction:(id)sender {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Progress" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];

	[alert show];
	
	[alert release];

}

- (void) dealloc {

	[super dealloc];
	[backgroundImage release];
}

@end
