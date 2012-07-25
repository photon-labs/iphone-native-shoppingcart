//
//  HomeViewController.m
//  Phresco
//
//  Created by photon on 11/2/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "BrowseViewController.h"
#import "ServiceHandler.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "Tabbar.h"
#import "RootViewController.h"
#import "SpecialOffersViewController.h"
#import "ResultViewController.h"
#import "Tabbar.h"
#import "SubmitReviewViewController.h"

@implementation HomeViewController

@synthesize loginViewController;
@synthesize registrationViewController;
@synthesize browseViewController;
@synthesize specialOffersViewController;
@synthesize resultViewController;
@synthesize searchTextField;
@synthesize activityIndicator;
@synthesize submitReviewViewController;
@synthesize array_;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"HomeViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"HomeViewController" bundle:nil];
        
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
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
    
    [tabbar setSelectedIndex:0 fromSender:nil];
    
	[self loadNavigationBar];
	
	[self addSearchBar];
    
    [self addHomePageIcons];
	
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
    }
	
}

-(void) addSearchBar
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 120)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(12, 116 , 670, 65)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        
        searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 130, 620, 50)];
        searchTextField.delegate = self;
        searchTextField.backgroundColor = [UIColor clearColor];
        searchTextField.font = [UIFont systemFontOfSize:17.0];
        searchTextField.textColor = [UIColor blackColor];
        [self.view addSubview:searchTextField];
        
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(695, 115, 60, 60)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        btnSearchIcon.accessibilityLabel = @"Searchbutton";
        
        [searchBarView release];
    }
    else {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41 , 320, 40)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(8, 44 , 275, 30)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        
        searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 48, 245, 24)];
        searchTextField.delegate = self;
        searchTextField.backgroundColor = [UIColor clearColor];
        searchTextField.textColor = [UIColor blackColor];
        [self.view addSubview:searchTextField];
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(285, 43, 30, 32)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        btnSearchIcon.accessibilityLabel = @"Searchbutton";
        
        [searchBarView release];
        
    }
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString* str = textField.text;
    
    if([str length] > 0 ){
        
        
        [self searchButtonSelected];
    }
    else
    { 
        [textField resignFirstResponder];
        
    }
    
    return YES;
}

#pragma mark searchButtonSelected
- (void)searchButtonSelected
{
    [searchTextField resignFirstResponder];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 150, 50, 40);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    if([searchTextField.text length] > 0)
    {
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        
        service.productName = searchTextField.text;
        
        [service   searchProductsService:self:@selector(finishedProductDetialsService:)];
        
    }
    else
    { 
        [activityIndicator stopAnimating];
        
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


-(void) finishedProductDetialsService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductModel:data];
    
    if([assetsData.productArray count] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Product not found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else {
        
        ResultViewController	*tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        
        self.resultViewController = tempResultViewController;
        
        [self.view addSubview:tempResultViewController.view];
        
        [tempResultViewController release];
    }
}

-(void) addHomePageIcons
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *iconBgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 230, 728, 580)];
        
        [iconBgView setImage:[UIImage imageNamed:@"icons_bg-72.png"]];
        
        [self.view addSubview:iconBgView];
        
        [iconBgView release];
        
        //create a grid of home page icons
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_icon-72.png"], [UIImage imageNamed:@"specialoffer_icon-72.png"], [UIImage imageNamed:@"login_icon-72.png"], [UIImage imageNamed:@"register_icon-72.png"], nil];
        
        NSMutableArray *titleLabel = [[NSMutableArray alloc] initWithObjects:@"Browse", @"Offer", @"Login", @"Register", nil];
        
        int x = 140;
        
        int y = 290;
        
        int width = 129;
        
        int height = 162;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            button.titleLabel.text = [titleLabel objectAtIndex:i];
            
            [self.view addSubview:button];
            
            x = x + 350;
            
            if([self checkIfOdd:i])
            {
                y = y + 290;
                
                x = 140;
            }
        }
        
        [buttonArray release];
        
        [titleLabel release];
    }
    else {
        
        UIImageView *iconBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 300, 300)];
        
        [iconBgView setImage:[UIImage imageNamed:@"icons_bg.png"]];
        
        [self.view addSubview:iconBgView];
        
        [iconBgView release];
        
        //create a grid of home page icons
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_icon.png"], [UIImage imageNamed:@"specialoffer_icon.png"], [UIImage imageNamed:@"login_icon.png"], [UIImage imageNamed:@"register_icon.png"], nil];
        
        NSMutableArray *titleLabel = [[NSMutableArray alloc] initWithObjects:@"Browse", @"Offer", @"Login", @"Register", nil];
        
        int x = 60;
        
        int y = 140;
        
        int width = 66;
        
        int height = 82;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            button.titleLabel.text = [titleLabel objectAtIndex:i];
            
            [self.view addSubview:button];
            
            if(i==0) {
                
                button.accessibilityLabel = @"Browse";
            }
            if(i==1) {
                
                button.accessibilityLabel = @"Offer";
            }
            if(i==2) {
                
                button.accessibilityLabel = @"Login";
            }
            if(i==3) {
                
                button.accessibilityLabel = @"Register";
            }
            
            x = x + 120;
            
            if([self checkIfOdd:i])
            {
                y = y + 120;
                
                x = 60;
            }
        }
        
        [buttonArray release];
        
        [titleLabel release];
    }
	
}

-(BOOL) checkIfOdd:(int) num
{
    BOOL isOdd = NO;
    
    if(num % 2 != 0)
    {
        isOdd = YES;
    }
    
    else
    {
        isOdd = NO;
    }
    
    return isOdd;
}


-(void) buttonAction:(id) sender
{
	UIButton *button = (UIButton*) sender;
    //	 activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
	if([button.titleLabel.text isEqualToString:@"Login"])
	{
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            LoginViewController *tempLoginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController-iPad" bundle:nil];
            
            self.loginViewController = tempLoginViewController;
            
            [self.view addSubview:loginViewController.view];
            
            [tempLoginViewController release];
        }
        else {
            
            LoginViewController *tempLoginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            self.loginViewController = tempLoginViewController;
            
            [self.view addSubview:loginViewController.view];
            
            [tempLoginViewController release];
        }
		
	}
    
    else if([button.titleLabel.text isEqualToString:@"Register"])
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            RegistrationViewController *tempRegistrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController-iPAd" bundle:nil];
            
            self.registrationViewController = tempRegistrationViewController;
            
            [self.view addSubview:registrationViewController.view];
            
            [tempRegistrationViewController release];
        }
        else {
            
            
            RegistrationViewController *tempRegistrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
            
            self.registrationViewController = tempRegistrationViewController;
            
            [self.view addSubview:registrationViewController.view];
            
            [tempRegistrationViewController release];
        }
        
    }
	else if([button.titleLabel.text isEqualToString:@"Browse"])
	{
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        [serviceHandler catalogService:self :@selector(finishedCatalogService:)];
        
        [serviceHandler release];
        
	}
    
    else if([button.titleLabel.text isEqualToString:@"Offer"])
    {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        [serviceHandler specialProductsService:self :@selector(finishedSpecialProductsService:)];
        
        [serviceHandler release];
        
    }
	
}

-(void) finishedCatalogService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateCatalogModel:data];
    
    [activityIndicator stopAnimating];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController-iPad" bundle:nil];
        
        self.browseViewController = tempBrowseViewController;
        
        [self.view addSubview:browseViewController.view];
        
        [tempBrowseViewController release];
    }
    else {
        if(loginViewController.isLogin == YES) {
            
            BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
            
            self.browseViewController = tempBrowseViewController;
            browseViewController.loginChk  = YES;
            tempBrowseViewController.array_ = array;
            [self.view addSubview:browseViewController.view];
            
            [tempBrowseViewController release];
        }
        
        else {
            BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
            
            self.browseViewController = tempBrowseViewController;
            
            [self.view addSubview:browseViewController.view];
            
            [tempBrowseViewController release];
        }
    }
    
}

-(void) finishedSpecialProductsService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateSpecialproductsModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController-iPad" bundle:nil];
        
        self.specialOffersViewController = tempSpecialOffersViewController;
        
        [self.view addSubview:specialOffersViewController.view];
        
        [tempSpecialOffersViewController release];
    }
    else {
        
        if(loginViewController.isLogin == YES) {
            
            SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
            
            self.specialOffersViewController = tempSpecialOffersViewController;
            
            specialOffersViewController.loginChk = YES;
            
            [self.view addSubview:specialOffersViewController.view];
            
            [tempSpecialOffersViewController release];
            
        }
        
        else {
            
            
            SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
            
            self.specialOffersViewController = tempSpecialOffersViewController;
            
            [self.view addSubview:specialOffersViewController.view];
            
            [tempSpecialOffersViewController release];
            
        }
        
    }
    
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
	
	[searchTextField release];
	
	[loginViewController release];
    
    [registrationViewController release];
	
	[browseViewController release];
    
    [activityIndicator release];
	
    [super dealloc];
}


@end
