//
//  OrderStatusViewController.m
//  Phresco
//
//  Created by bharat kumar on 07/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "OrderStatusViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BrowseViewController.h"
#import "DataModelEntities.h"
#import "ServiceHandler.h"
#import "SharedObjects.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"

@implementation OrderStatusViewController
@synthesize orderStatusTextView;
@synthesize browseViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"OrderStatusViewController-iPad" bundle:nil];
		
	}
	else 
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"OrderStatusViewController" bundle:nil];
        
    }

    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    
    [tabbar setSelectedIndex:2 fromSender:nil];
    
    [self loadNavigationBar];
    
    [self initializeTextView];
    
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
        
        [backButton setFrame:CGRectMake(5, 5, 123, 60)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn-72.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        [backButton release];
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        [searchBarView release];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_highlighted.png"],nil];
        
        int x  = 8;
        
        int y = 92;
        
        int width = 250;
        
        int height = 55;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setBackgroundImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            x = x + 252;
            if(i==0) {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            [button release];
            
        }
        
        UIImageView    *titleHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 151, 768, 60)];
        
        [titleHeader setImage:[UIImage imageNamed:@"product_header.png"]];
        
        [self.view addSubview:titleHeader];
        
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(190,151,570,60)];
        [titleLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"Order Status Screen"];
        [self.view addSubview:titleLabel];
        [titleHeader release];
        
        UILabel* orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25,230,720,60)];
        [orderLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        orderLabel.backgroundColor = [UIColor clearColor];
        [orderLabel setTextColor:[UIColor whiteColor]];
        [orderLabel setText:@"Order Status Message"];
        [self.view addSubview:orderLabel];
        [orderLabel release];
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
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 , 320, 40)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
        
        [self.view addSubview:searchBarView];
        
        [searchBarView release];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_highlighted.png"],nil];
        
        int x  = 5;
        
        int y = 42;
        
        int width = 100;
        
        int height = 35;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setBackgroundImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            x = x + 102;
            if(i==0) {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i==2)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            [button release];
            
        }
        
        UIImageView    *titleHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 30)];
        
        [titleHeader setImage:[UIImage imageNamed:@"product_header.png"]];
        
        [self.view addSubview:titleHeader];
        
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95,80,320,25)];
        [titleLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:14]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"Order Status Screen"];
        [self.view addSubview:titleLabel];
        [titleHeader release];
        
        UILabel* orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,120,320,25)];
        [orderLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:14]];
        orderLabel.backgroundColor = [UIColor clearColor];
        [orderLabel setTextColor:[UIColor whiteColor]];
        [orderLabel setText:@"Order Status Message"];
        [self.view addSubview:orderLabel];
        [orderLabel release];
    }
	
    
}

-(void)goBack:(id)sender
{
    [self.view removeFromSuperview];
}
- (void)initializeTextView 
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        orderStatusTextView =[[UITextView alloc]initWithFrame:CGRectMake(10, 300,740,400)];
        orderStatusTextView.delegate = self;
        orderStatusTextView.editable = NO;
        orderStatusTextView.backgroundColor =[UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [orderStatusTextView setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:26]];
        [orderStatusTextView.layer setBorderColor:[[UIColor grayColor]CGColor]];
        [orderStatusTextView.layer setBorderWidth:1.0];
        [orderStatusTextView.layer setCornerRadius:8.0f];
        [orderStatusTextView.layer setMasksToBounds:YES];
        orderStatusTextView.textAlignment = UITextAlignmentLeft;
        orderStatusTextView.textColor = [UIColor whiteColor];
        orderStatusTextView.text = @"Your order is complete!\nyour order number is 007.\nThanks you for shopping at Phresco.While logged in.\nYou may continue shopping or view your order status and order.";
        [self.view addSubview:orderStatusTextView];
    }
    else {
        orderStatusTextView =[[UITextView alloc]initWithFrame:CGRectMake(5, 150,310,150)];
        orderStatusTextView.delegate = self;
        orderStatusTextView.editable = NO;
        orderStatusTextView.backgroundColor =[UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [orderStatusTextView setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:13]];
        [orderStatusTextView.layer setBorderColor:[[UIColor grayColor]CGColor]];
        [orderStatusTextView.layer setBorderWidth:1.0];
        [orderStatusTextView.layer setCornerRadius:8.0f];
        [orderStatusTextView.layer setMasksToBounds:YES];
        orderStatusTextView.textAlignment = UITextAlignmentLeft;
        orderStatusTextView.textColor = [UIColor whiteColor];
        orderStatusTextView.text = @"Your order is complete!\nyour order number is 007.\nThanks you for shopping at Phresco.While logged in.\nYou may continue shopping or view your order status and order.";
        [self.view addSubview:orderStatusTextView];
    }
    
}
#pragma mark Button Actions

#pragma mark Button Actions

- (void) browseButtonSelected:(id)sender 
{
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    [serviceHandler catalogService:self :@selector(finishedCatalogService:)];
    
    [serviceHandler release];
    
}

-(void) finishedCatalogService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateCatalogModel:data];
    
    BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
    
    self.browseViewController = tempBrowseViewController;
    
    [self.view addSubview:browseViewController.view];
    
    [tempBrowseViewController release];
}

- (void) specialOfferButtonSelected:(id)sender 
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.specialProductsArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    [serviceHandler specialProductsService:self :@selector(finishedSpecialProductsService:)];
    
    [serviceHandler release];
        
}
-(void) finishedSpecialProductsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateSpecialproductsModel:data];
    
    
    SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
    
    [self.view addSubview:tempSpecialOffersViewController.view];
    
    [tempSpecialOffersViewController release];
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

@end
