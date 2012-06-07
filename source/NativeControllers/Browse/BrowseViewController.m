//
//  BrowseViewController.m
//  Phresco
//
//  Created by photon on 11/9/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "BrowseViewController.h"
#import "BrowseViewCustomCell.h"
#import "ResultViewController.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "AddToBagViewController.h"
#import "ProductDetailsViewController.h"
#import "AddtoBagCustomCell.h"
#import "HomeViewController.h"
#import "specialOffersViewController.h"
#import "Tabbar.h"
#import "LoginViewController.h"


@implementation BrowseViewController
@synthesize searchBar;
@synthesize productTable;
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize resultViewController;
@synthesize addToBagViewController;
@synthesize specialOffersViewController;
@synthesize productCountArray;
@synthesize loginViewController;
@synthesize activityIndicator;
@synthesize loginChk;
@synthesize array_;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"BrowseViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"BrowseViewController" bundle:nil];
        
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
	
	[self addSearchBar];
	
	[self initializeTableView];
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
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 60)];
        
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
            
            if(i==0) {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
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
        
        if(i==0) {
            [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
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

-(void) addSearchBar
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 153 , 768, 90)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(15, 162 , 680, 60)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        txtBar = [[UITextField alloc]initWithFrame:CGRectMake(35, 168, 665, 56)];
        txtBar.delegate = self;
        txtBar.backgroundColor = [UIColor clearColor];
        txtBar.textColor = [UIColor blackColor];
        [self.view addSubview:txtBar];
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(705, 163, 60, 60)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        
        [searchBarView release];
        
        UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 290, 768, 60)];
        
        [descriptionBlock setImage:[UIImage imageNamed:@"categorylist_top_row.png"]];
        
        [self.view addSubview:descriptionBlock];
        
        [descriptionBlock release];
        
        UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(200, 270, 320, 60)];
        
        [descriptionHeader setImage:[UIImage imageNamed:@"categorylist_header-72.png"]];
        
        [self.view addSubview:descriptionHeader];
        
        [descriptionHeader release];
    }
    else {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81 , 320, 40)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(8, 84 , 275, 30)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        txtBar = [[UITextField alloc]initWithFrame:CGRectMake(25, 86, 245, 24)];
        txtBar.delegate = self;
        txtBar.backgroundColor = [UIColor clearColor];
        txtBar.textColor = [UIColor blackColor];
        [self.view addSubview:txtBar];
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(285, 84, 30, 32)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        
        [searchBarView release];
        
        UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 320, 30)];
        
        [descriptionBlock setImage:[UIImage imageNamed:@"categorylist_top_row.png"]];
        
        [self.view addSubview:descriptionBlock];
        
        [descriptionBlock release];
        
        UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(90, 120, 150, 30)];
        
        [descriptionHeader setImage:[UIImage imageNamed:@"categorylist_header.png"]];
        
        [self.view addSubview:descriptionHeader];
        
        [descriptionHeader release];
    }
	
    
}

#pragma mark Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textFieldui {
	[txtBar becomeFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textFieldui {
	
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textFieldui {
    [txtBar resignFirstResponder];
    [textFieldui resignFirstResponder];
    if([textFieldui.text length] > 0 ){
        [self searchButtonSelected:0];
    }
    else
    { 
        [textFieldui resignFirstResponder];
        
    }
    return YES;
}

#pragma mark searchButtonSelected
- (void)searchButtonSelected:(id)sender
{
    [txtBar resignFirstResponder];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 150, 50, 40);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    if([txtBar.text length] > 0)
    {
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        
        service.productName = txtBar.text;
        
        [service    searchProductsService:self:@selector(finishedProductDetialsService:)];
        
    }
    else
    { 
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Search Product" message:@"Enter a product name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}

-(void) initializeTableView
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		productTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 330, 768, 420) style:UITableViewStylePlain];
        productTable.dataSource = self;
        productTable.delegate = self;
        productTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [self.view addSubview:productTable];
	}
    else {
        
        productTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 320, 260) style:UITableViewStylePlain];
        productTable.dataSource = self;
        productTable.delegate = self;
        productTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        
        [self.view addSubview:productTable];
    }
	
	
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
           
    if(nil == productCountArray) 
    {
        
        productCountArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.catalogArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.catalogArray objectAtIndex:i] productImageUrl]];
               
    }
    
    if(nil == productNameArray)
	{
		productNameArray = [[NSMutableArray alloc] initWithObjects:@"Apparels", @"Computer & Electronics", @"Mobiles", @"TV & Video", nil];
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
    
    [activityIndicator stopAnimating];
    
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

#pragma mark tableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    return [assetsData.catalogArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 82;
    }
    else {
        
        return 48;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
	static NSString *CellIdentifier = @"ProductsCell";
		
	BrowseViewCustomCell *cell = (BrowseViewCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if ((cell == nil) ||(cell != nil)){
        cell = [[[BrowseViewCustomCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
				autorelease];
        [cell setFrame:CGRectZero];
    } 
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow-72.png"]];
    }
    else {
        
        [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow.png"]];
    }
    
   
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [[cell productLabel] setText:[[assetsData.catalogArray objectAtIndex:indexPath.row] productName]];
        
    [[cell productCountLabel] setText: [NSString stringWithFormat:@"%@",[[assetsData.catalogArray objectAtIndex:indexPath.row] productCount]]];
    
    [[cell countImage] setImage:[UIImage imageNamed:@"itemscount_bg-72.png"]];
                    
                    
    CGRect frame;
        
        frame.size.width=60; 
        frame.size.height=60;
        frame.origin.x=20; 
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
		
	}
    [tasyncImage release];
	
	return cell;
    }
    else {
        
        static NSString *CellIdentifier = @"ProductsCell";
		
        BrowseViewCustomCell *cell = (BrowseViewCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if ((cell == nil) ||(cell != nil)) {
            cell = [[[BrowseViewCustomCell alloc]
                     initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
                    autorelease];
            [cell setFrame:CGRectZero];
        } 
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow-72.png"]];
        }
        else {
            
            [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow.png"]];
        }
        
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [[cell productLabel] setText:[[assetsData.catalogArray objectAtIndex:indexPath.row] productName]];
        
        [[cell productCountLabel] setText: [NSString stringWithFormat:@"%@",[[assetsData.catalogArray objectAtIndex:indexPath.row] productCount]]];
        
        [[cell countImage] setImage:[UIImage imageNamed:@"itemscount_bg-72.png"]];
        
        
        CGRect frame;
        
            frame.size.width=30; 
            frame.size.height=40;
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
            
        }
        [tasyncImage release];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
             
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    service.strId = [[assetsData.catalogArray objectAtIndex:indexPath.row] productId];
    [service    productDetailsService:self:@selector(finishedProductDetialsService:)];
    [service release];
     }
     else {
         
         activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
         activityIndicator.frame = CGRectMake(130, 250, 50, 40);
         [self.view addSubview:activityIndicator];
         
         [activityIndicator startAnimating];
         
         ServiceHandler* service = [[ServiceHandler alloc]init];
         AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
         
         service.strId = [[assetsData.catalogArray objectAtIndex:indexPath.row] productId];
         [service    productDetailsService:self:@selector(finishedProductDetialsService:)];
         [service release];
     }
}


-(void) finishedProductDetialsService:(id) data
{
    [activityIndicator stopAnimating];

    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductModel:data];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultsViewController-iPAd" bundle:nil];
        
        self.resultViewController = tempResultViewController;
        
        [self.view addSubview:resultViewController.view];
        
        [tempResultViewController release];
        
    }
    else {
        
        
        if(loginChk == YES) {
            
            ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            
            self.resultViewController = tempResultViewController;
            
            tempResultViewController.loginChk = YES;
            
            resultViewController.array_ = array_;
            
            [self.view addSubview:resultViewController.view];
            
            [tempResultViewController release];
        }
        
        else {
            
            ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            
            self.resultViewController = tempResultViewController;
            
            [self.view addSubview:resultViewController.view];
            
            [tempResultViewController release];
        }
    }
}


-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.catalogArray = [[NSMutableArray alloc]init];
	[self.view removeFromSuperview];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[productImageArray release];
	
	[productTable release];
	
	[resultViewController release];
    
    [productCountArray release];
	
    [super dealloc];
}


@end
