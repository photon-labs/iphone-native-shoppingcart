//
//  ResultViewController.m
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultViewCustomCell.h"
#import "ProductDetailsViewController.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "ReviewViewController.h"
#import "AddToBagViewController.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"
#import "LoginViewController.h"
@implementation ResultViewController

@synthesize productImageArray;
@synthesize productNameArray;
@synthesize resultTable;
@synthesize priceArray;
@synthesize productDetailsViewController;
@synthesize reviewViewController;
@synthesize addToBagViewController;
@synthesize specialOffersViewController;
@synthesize activityIndicator;
@synthesize loginViewController;
@synthesize loginChk;
@synthesize array_;;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"ResultsViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"ResultViewController" bundle:nil];
        
    }

    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
    }
    else {
        
        tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
    }
    array_ =[[NSMutableArray alloc] init];
    
    NSMutableArray *names = [NSMutableArray array];
    
    
    int startIndex = 0;
    
    int lastIndex = 4;
    
    for(int i = startIndex; i <= lastIndex; i++) {
        [names addObject:[assetsData.featureLayout objectAtIndex:i]];
    }
    
    //create tabbar with given features
    [tabbar initWithInfo:names];
    
    [self.view addSubview:(UIView*)tabbar];
    
    [tabbar setSelectedIndex:1 fromSender:nil];
    
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
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 320, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        [searchBarView release];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_highlighted-72.png"], [UIImage imageNamed:@"specialoffers_btn_normal-72.png"], [UIImage imageNamed:@"mycart_btn_normal-72.png"], 
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_highlighted.png"], [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_normal.png"], 
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
            
            if(i==1) {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
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
    assetsData.productArray = [[NSMutableArray alloc]init];
	[self.view removeFromSuperview];
}

-(void) initializeProductResults
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 152, 768, 800)];
	}
    else {
        
        resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 81, 320, 330)];
    }
	
	resultTable.dataSource = self;
	resultTable.delegate = self;
	resultTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
    //resultTable.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"split_line.png"]];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
   
	[self.view addSubview:resultTable];
	
    
    if(nil == productNameArray)
    {
        productNameArray = [[NSMutableArray alloc] init];
    }
 
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        
        [productNameArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailName]];

    }
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailImageUrl]];
    }
   
    if(nil == priceArray)
    {
        priceArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        [priceArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailsPrice]];
        
    }
    
}

#pragma mark navigation button Actions


-(void)specialOfferButtonSelected :(id)sender 
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
    
    self.specialOffersViewController = tempSpecialOffersViewController;
    
    [self.view addSubview:specialOffersViewController.view];
    
    [tempSpecialOffersViewController release];
}

- (void) myCartButtonSelected:(id)sender
{
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
	[tempResultViewController release];
}

#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AssetsDataEntity *assestsDataOne = [SharedObjects sharedInstance].assetsDataEntity;
    
    if([assestsDataOne.productArray count]==0)
    {
        
        UIAlertView *alertProduct = [[UIAlertView alloc] initWithTitle:@"Search Product" message:@"Products not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertProduct show];
        [alertProduct release];
    }
    else {
        
        return [assestsDataOne.productArray count];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 230;
    }
    else {
        
        return 110;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
	static NSString *CellIdentifier = @"ProductsCell";
	
	ResultViewCustomCell *cell = (ResultViewCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if ((cell == nil) ||(cell != nil)) {
        cell = [[[ResultViewCustomCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
				autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 2;

        [[cell reviewsButton] addTarget:self
                                 action:@selector(reviewButtonSelected:)
                       forControlEvents:UIControlEventTouchUpInside];
    }
	 [[cell reviewsButton] setTag:[indexPath row]];
    
        
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	//cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow-72.png"]];
        
    
    CGRect frame;
        
        frame.size.width=90; 
        frame.size.height=90;
        frame.origin.x=20; 
        frame.origin.y=15;
    
    
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
    
    
    AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [[cell productName] setText:[[assestsData.productArray objectAtIndex:indexPath.row] productDetailName]];
   
   
    [[cell productPrice] setText: [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productDetailsPrice]]];
// [[cell reviewsButton] addTarget:self action:@selector(reviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
   
    
    NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productRatingView]];
    //NSInteger rateValue = [string intValue];
   
    index = indexPath.row;
         
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
    
         
        return cell;
    }
    else {
        
        static NSString *CellIdentifier = @"ProductsCell";
        
        ResultViewCustomCell *cell = (ResultViewCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if ((cell == nil) ||(cell != nil)) {
            cell = [[[ResultViewCustomCell alloc]
                     initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
                    autorelease];
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 2;
            
            [[cell reviewsButton] addTarget:self
                                     action:@selector(reviewButtonSelected:)
                           forControlEvents:UIControlEventTouchUpInside];
        }
        [[cell reviewsButton] setTag:[indexPath row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow.png"]];
        
        
        CGRect frame;
        
            frame.size.width=60; 
            frame.size.height=60;
            frame.origin.x=10; 
            frame.origin.y=7;
        
        
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
        
        AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [[cell productName] setText:[[assestsData.productArray objectAtIndex:indexPath.row] productDetailName]];
        
        
        [[cell productPrice] setText: [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productDetailsPrice]]];
           
        NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productRatingView]];
        
        index = indexPath.row;
        
            
            float x = 85;
            
            float  y =  65;
            
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
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    service.strId = [[assetsData.productArray objectAtIndex:indexPath.row] productDetailId];
    
    index = [indexPath row];
    
    [service    productService:self:@selector(finishedProductDetialsService:)];
    
    [service release];
}

-(void) finishedProductDetialsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductDetailsModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController-iPAd" bundle:nil];
        
        self.productDetailsViewController = tempProductDetailsViewController;
        
        [self.view addSubview:productDetailsViewController.view];
        
        [tempProductDetailsViewController release];
    }
    else {
        
        if(loginChk == YES) {
            
            ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
	
            self.productDetailsViewController = tempProductDetailsViewController;
	        productDetailsViewController.loginChk = YES;
            productDetailsViewController.index = index ;
            [self.view addSubview:productDetailsViewController.view];
	
            [tempProductDetailsViewController release];
        }
        else {
            
            ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
            
            self.productDetailsViewController = tempProductDetailsViewController;
            
            [self.view addSubview:productDetailsViewController.view];
            
            [tempProductDetailsViewController release];
        }
    }
}
-(void) finishedProductReviewService:(id) data
{
    
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController-iPAd" bundle:nil];
        
        self.reviewViewController = tempReviewViewController;
        
        [self.view addSubview:reviewViewController.view];
        
        [tempReviewViewController release];
    }
    else {
        
        if(loginChk == YES) {
            
          ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
        
            self.reviewViewController = tempReviewViewController;
            reviewViewController.loginChk = YES;
            reviewViewController.reviewProductId = index;
            reviewViewController.array_ = array_;
            [self.view addSubview:reviewViewController.view];
        
            [tempReviewViewController release];
            
        }
        
        else {
            
            ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
            self.reviewViewController = tempReviewViewController;
            [self.view addSubview:reviewViewController.view];
            [tempReviewViewController release];
            
        }
    }
}

-(void)reviewButtonSelected :(id)sender
{
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 250, 50, 40);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    ServiceHandler* service = [[ServiceHandler alloc]init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;

     int rowOfButton = [sender tag];
    
    index= rowOfButton;
    
    service.strId = [[assetsData.productArray objectAtIndex:rowOfButton] productDetailId];
    [service productReviewService:self :@selector(finishedProductReviewService:)];
    
    [service release];
    
}

-(void)viewWillAppear:(BOOL)animated 
{
    
    [super viewWillAppear:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
	
	[productImageArray release];
    
	[productNameArray release];
    
	[resultTable release];
	
	[productDetailsViewController release];
	
	[super dealloc];
}


@end
