//
//  SpecialOffersViewController.m
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "SpecialOffersViewController.h"
#import "ServiceHandler.h"
#import "DataModelEntities.h"
#import "SpecialOfferCustomCell.h"
#import "Constants.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ReviewViewController.h"
#import "HomeViewController.h"
#import "AddToBagViewController.h"
#import "BrowseViewController.h"
#import "ProductDetailsViewController.h"
#import "Tabbar.h"


@implementation SpecialOffersViewController
@synthesize specialProductTable;
@synthesize reviewViewController;
@synthesize productNameArray;
@synthesize productImageArray;
@synthesize priceArray;
@synthesize review;
@synthesize addToBagViewController;
@synthesize browseViewController;
@synthesize productDetailsViewController;
@synthesize activityIndicator;
@synthesize loginChk;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"SpecialOffersViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"SpecialOffersViewController" bundle:nil];
        
    }
    return self;
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
    
    [tabbar setSelectedIndex:3 fromSender:nil];
    
    [self loadNavigationBar];
	
	[self initializeProductResults];
    
    
}


-(void) loadNavigationBar
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *navBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 90)];
        
        [navBarView setImage:[UIImage imageNamed:@"header_logo-72.png"]];
        
        [self.view addSubview:navBarView];
        
        [navBarView release];
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91, 768, 800)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
        [bgView release];
        
        UIButton *backButton = [[UIButton alloc] init];
        
        [backButton setFrame:CGRectMake(5, 15, 123, 60)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn-72.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        [backButton release];
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        [searchBarView release];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_highlighted.png"], [UIImage imageNamed:@"mycart_btn_normal.png"], 
                                       nil];
        
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
            if(i==2)
            {
                [button addTarget:self action:@selector(myCartButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release];
            
        }
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_highlighted.png"], [UIImage imageNamed:@"mycart_btn_normal.png"], 
                                       nil];
        
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
                [button addTarget:self action:@selector(myCartButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release];
            
        }
    }
	
	
}
-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.specialProductsArray =[[NSMutableArray alloc] init];
	[self.view removeFromSuperview];
}

-(void) initializeProductResults
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		specialProductTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 151, 768, 785)];
	}
    else {
        
        specialProductTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 81, 320, 330)];
    }
	
	specialProductTable.dataSource = self;
	specialProductTable.delegate = self;
	specialProductTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
	[self.view addSubview:specialProductTable];
	
    
    if(nil == productNameArray)
    {
        productNameArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
        
        [productNameArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductName]];
        
    }
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductImageUrl]];
    }
    
    if(nil == priceArray)
    {
        priceArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
               
        [priceArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductPrice]];
        
    }
    
}

#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AssetsDataEntity *assestsDataOne = [SharedObjects sharedInstance].assetsDataEntity;
    
    return [assestsDataOne.specialProductsArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 240;
    }
    else {
        return 150;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"SpecialOfferCell";
	
	SpecialOfferCustomCell *cell = (SpecialOfferCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if ((cell == nil) ||(cell != nil)) {
        cell = [[[SpecialOfferCustomCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
				autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 2;
        
        
        [[cell reviewsButton] addTarget:self action:@selector(reviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [[cell reviewsButton] setTag:[indexPath row]];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    CGRect frame;
    
     AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
     NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductRatingView]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame.size.width=90; 
        frame.size.height=90;
        frame.origin.x=20; 
        frame.origin.y=10;
        
        float x = 145;
        
        float  y =  172;
        
        float  width = 25;
        
        float height = 25;
        
        NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(x,y,width,height);
            [ratingsView setImage:[UIImage imageNamed:@"white_star.png"]];
            x = x + 25;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesWhiteArray addObject:ratingsView];
        }
        
        float xBlue = 145;
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<[string intValue];i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(xBlue,y,width,height);
            [ratingsView setImage:[UIImage imageNamed:@"blue_star.png"]];
            xBlue = xBlue + 25;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesArray addObject:ratingsView];
        }
        
         [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow-72.png"]];
    }
    else {
        frame.size.width=60; 
        frame.size.height=60;
        frame.origin.x=10; 
        frame.origin.y=7;
        
        float x = 85;
        
        float  y =  117;
        
        float  width = 15;
        
        float height = 15;
        
        
        NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(x,y,width,height);
            [ratingsView setImage:[UIImage imageNamed:@"white_star.png"]];
            x = x + 15;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesWhiteArray addObject:ratingsView];
        }
        
        float xBlue = 85;
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<[string intValue];i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(xBlue,y,width,height);
            [ratingsView setImage:[UIImage imageNamed:@"blue_star.png"]];
            xBlue = xBlue + 15;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesArray addObject:ratingsView];
        }
        
         [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow.png"]];
    }
	
    
    AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                   initWithFrame:frame] ;
    
    
    // TODO: Add Code for getting Coupons Image URL
	NSURL	*url = nil;
	
	if([productImageArray count] > 0 && indexPath.row < [productImageArray count])
	{
		url = [NSURL URLWithString:[productImageArray objectAtIndex:indexPath.row]];
		
		[tasyncImage loadImageFromURL:url];
		
		[cell.contentView addSubview:tasyncImage];
                                           
        [tasyncImage release];
		
    }
   
    
    [[cell productName] setText:[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductName]];
    
    [[cell productPrice] setText: [NSString stringWithFormat:@"$ %@",[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductPrice]]];
        
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    service.strId = [[assetsData.specialProductsArray objectAtIndex:indexPath.row] specialProductId];
    
    [service    productService:self:@selector(finishedProductDetialsService:)];
    
    [service release];
}

-(void) finishedProductDetialsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductDetailsModel:data];
    
    ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
	
	self.productDetailsViewController = tempProductDetailsViewController;
	
	[self.view addSubview:productDetailsViewController.view];
	
	[tempProductDetailsViewController release];
}


-(void)reviewButtonSelected :(id)sender
{
    ServiceHandler* service = [[ServiceHandler alloc]init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
     int rowOfButton = [sender tag];

    service.strId = [[assetsData.specialProductsArray objectAtIndex:rowOfButton] specialProductId];
    
    index = rowOfButton;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 250, 50, 40);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    [service productReviewService:self :@selector(finishedProductReviewService:)];
    
    [service release];
    
}


- (void) finishedProductReviewService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
        
    if(loginChk ==  YES) {
    
    ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
    
    self.reviewViewController = tempReviewViewController;
    reviewViewController.isSpecialOffer = YES;
    reviewViewController.loginChk = YES;
    reviewViewController.reviewProductId = index;
    [self.view addSubview:reviewViewController.view];
    
    [tempReviewViewController release];
        
    }
    else 
    {
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
        
        self.reviewViewController = tempReviewViewController;
        reviewViewController.isSpecialOffer = YES;
        reviewViewController.reviewProductId = index;
        [self.view addSubview:reviewViewController.view];
        [tempReviewViewController release];
        
    }
    
}

#pragma mark navigation button Actions
- (void) browseButtonSelected:(id)sender 
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    assetsData.catalogArray = [[NSMutableArray alloc]init];
    assetsData.productReviewArray = [[NSMutableArray alloc] init];

    
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


- (void) myCartButtonSelected:(id)sender
{
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
	[tempResultViewController release];
}


#pragma mark UIInterfaceOrientationPortrait

 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 
-(void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:YES];
    [specialProductTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
	
	[specialProductTable release];
	[productImageArray release];
    [productNameArray release];
    [priceArray release];
	
	[super dealloc];
}


@end
