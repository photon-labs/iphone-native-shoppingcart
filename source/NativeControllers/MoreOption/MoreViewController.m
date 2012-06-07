//
//  MoreViewController.m
//  Phresco
//
//  Created by bharat kumar on 07/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "MoreViewController.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "Tabbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation MoreViewController
@synthesize moreView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"MoreViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"MoreViewController" bundle:nil];
        
    }

    return self;
}

-(void) loadNavigationBar
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        UIImageView *navBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 90)];
        
        [navBarView setImage:[UIImage imageNamed:@"header_logo-72.png"]];
        
        [self.view addSubview:navBarView];
        
        [navBarView release];
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91, 768, 845)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
        [bgView release];
        
        UIButton *backButton = [[UIButton alloc] init];
        
        [backButton setFrame:CGRectMake(5, 15, 123, 60)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn-72.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        [backButton release];
    }
    else {
        
        UIImageView *navBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        [navBarView setImage:[UIImage imageNamed:@"header_logo.png"]];
        
        [self.view addSubview:navBarView];
        
        [navBarView release];
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 320, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        [bgView release];
        
        UIButton *backButton = [[UIButton alloc] init];
        
        [backButton setFrame:CGRectMake(5, 5, 60, 30)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        [backButton release];

    }
       
}

 -(void)initializeTextView
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        moreView =[[UIView  alloc]initWithFrame:CGRectMake(40, 200,670,450)];
        UIImage* image  = [UIImage imageNamed:@"iconbg2_screen-72.png"];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setImage:image];
        [moreView addSubview:imageView];
        [self.view addSubview:moreView];     
        
        UIButton* wishlist = [UIButton buttonWithType:UIButtonTypeCustom];
        [wishlist setFrame:CGRectMake(80, 80, 120, 160)];
        [wishlist setImage:[UIImage imageNamed:@"wishlist_icon-72.png"] forState:UIControlStateNormal];
        [wishlist addTarget:self action:@selector(wishListButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:wishlist];
        
        UIButton* coupons = [UIButton buttonWithType:UIButtonTypeCustom];
        [coupons setFrame:CGRectMake(400, 80, 120, 160)];
        [coupons setImage:[UIImage imageNamed:@"coupons_icon-72.png"] forState:UIControlStateNormal];
        [coupons addTarget:self action:@selector(couponsButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:coupons];
    }
    else 
    {
        moreView =[[UIView  alloc]initWithFrame:CGRectMake(5, 120,310,150)];
        UIImage* image  = [UIImage imageNamed:@"iconbg2_screen.png"];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setImage:image];
        [moreView addSubview:imageView];
        [self.view addSubview:moreView];
             
        UIButton* wishlist = [UIButton buttonWithType:UIButtonTypeCustom];
        [wishlist setFrame:CGRectMake(40, 40, 60, 80)];
        [wishlist setImage:[UIImage imageNamed:@"wishlist_icon.png"] forState:UIControlStateNormal];
        [wishlist addTarget:self action:@selector(wishListButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:wishlist];
        
        UIButton* coupons = [UIButton buttonWithType:UIButtonTypeCustom];
        [coupons setFrame:CGRectMake(210, 40, 60, 80)];
        [coupons setImage:[UIImage imageNamed:@"coupons_icon.png"] forState:UIControlStateNormal];
        [coupons addTarget:self action:@selector(couponsButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:coupons];
    }
  
}

-(void)couponsButtonSelected:(id)sender
{
    NSLog(@"sdjfksdf");
}


-(void)wishListButtonSelected:(id)sender
{
    NSLog(@"qweqwe");

}
-(void)goBack:(id)sender
{
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
    }
    else {
        
        tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
    }
    
    NSMutableArray *names = [NSMutableArray array];
    
    int startIndex = 0;
    
    int lastIndex = 4;
    
    for(int i = startIndex; i <= lastIndex; i++) {
        [names addObject:[assetsData.featureLayout objectAtIndex:i]];
    }
    
    //create tabbar with given features
    [tabbar initWithInfo:names];
    
    [self.view addSubview:(UIView*)tabbar];
    
    [tabbar setSelectedIndex:4 fromSender:nil];
    
    [self loadNavigationBar];
    
    [self initializeTextView];
   
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc
{
    [super dealloc];
    [moreView release];
}
@end
