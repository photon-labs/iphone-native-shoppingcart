//
//  CheckOutOVerallViewController.m
//  Phresco
//
//  Created by photon on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckOutOVerallViewController.h"
#import "AsyncImageView.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "DTCustomColoredAccessory.h"
#import "OrderStatusViewController.h"
#import "CheckOutViewController.h"
#import "BrowseViewController.h"
#import "SBJsonWriter.h"
#import "NSString+SBJSON.h"
#import "SBJsonParser.h"
#import "ServiceHandler.h"
#import "Constants.h"
#import "ViewCartController.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"
#import "ConfigurationReader.h"


@implementation CheckOutOVerallViewController

@synthesize addToBagTable;
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize orderStatusViewController;
@synthesize strFirst;
@synthesize strLast;
@synthesize strComp;
@synthesize strAddr1;
@synthesize strAddr2;
@synthesize strCity;
@synthesize strState;
@synthesize strCountry;
@synthesize strZip;
@synthesize strPhone;
@synthesize browseViewController;
@synthesize strOrderComments;
@synthesize stringTotalPrice;
@synthesize specialOffersViewController;
@synthesize strEmailId;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"CheckoutOverallViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"CheckOutOVerallViewController" bundle:nil];
        
    }
    return self;
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
    
    [tabbar setSelectedIndex:2 fromSender:nil];
    
    [self loadNavigationBar];
    
    [self initializeTableView];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
}


-(void) loadNavigationBar
{
	//add scroll view
	
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"],  [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_highlighted.png"], 
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
            
            if(i==0)
            {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release]; 
            
        }
        
        UILabel *myCartView = [[UILabel alloc] initWithFrame:CGRectMake(240, 150 , 160, 40)];
        
        [myCartView setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        myCartView.backgroundColor = [UIColor clearColor];
        [myCartView setText:@"Check Out"];
        [myCartView setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:myCartView];
        
        [myCartView release];
        
        
        
        UIButton *reviewCart = [[UIButton alloc] initWithFrame:CGRectMake(140, 730 , 106, 48)];
        
        [reviewCart setBackgroundImage:[UIImage imageNamed:@"back_btn2.png"] forState:UIControlStateNormal];
        
        [reviewCart addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:reviewCart];
        
        [reviewCart release];
        
        UIButton *cancelCart = [[UIButton alloc] initWithFrame:CGRectMake(450, 730 , 179, 48)];
        
        [cancelCart setBackgroundImage:[UIImage imageNamed:@"submitorder_btn.png"] forState:UIControlStateNormal];
        
        [cancelCart addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cancelCart.accessibilityLabel = @"Submit";
        
        [self.view addSubview:cancelCart];
        
        [cancelCart release];
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"],  [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_highlighted.png"], 
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
            
            if(i==0)
            {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release]; 
            
        }
        
        UILabel *myCartView = [[UILabel alloc] initWithFrame:CGRectMake(120, 80 , 80, 20)];
        
        [myCartView setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        myCartView.backgroundColor = [UIColor clearColor];
        [myCartView setText:@"Check Out"];
        [myCartView setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:myCartView];
        
        [myCartView release];
        
        
        
        UIButton *reviewCart = [[UIButton alloc] initWithFrame:CGRectMake(70, 330 , 76, 31)];
        
        [reviewCart setBackgroundImage:[UIImage imageNamed:@"back_btn2.png"] forState:UIControlStateNormal];
        
        [reviewCart addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:reviewCart];
        
        [reviewCart release];
        
        UIButton *cancelCart = [[UIButton alloc] initWithFrame:CGRectMake(180, 330 , 109, 31)];
        
        [cancelCart setBackgroundImage:[UIImage imageNamed:@"submitorder_btn.png"] forState:UIControlStateNormal];
        
        [cancelCart addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
        
         cancelCart.accessibilityLabel = @"Submit";
        
        [self.view addSubview:cancelCart];
        
        [cancelCart release];
        
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        [self.view addSubview:activityIndicator];
    }
	
    
}

-(void) initializeTableView
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 195, 768, 420) style:UITableViewStylePlain];
    }
    else {
        
        addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 320, 210) style:UITableViewStylePlain];
    }
    
   
	addToBagTable.dataSource = self;
	addToBagTable.delegate = self;
	addToBagTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
	addToBagTable.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"split_line.png"]];
	[self.view addSubview:addToBagTable];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i<[assetsData.productDetailArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.productDetailArray objectAtIndex:i] productDetailImageUrl]];
    }
}

-(void)goBack:(id)sender
{
	[self.view removeFromSuperview];
}

#pragma mark Button Actions

- (void) browseButtonSelected:(id)sender 
{
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
        
        
        [button release];
		
	}
    
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    [serviceHandler catalogService:self :@selector(finishedCatalogService:)];
    
    [serviceHandler release];
    
    
}

-(void) finishedCatalogService:(id) dataVar
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateCatalogModel:dataVar];
    
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
-(void) finishedSpecialProductsService:(id) dataVar
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateSpecialproductsModel:dataVar];
    
    
    SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
    
    self.specialOffersViewController = tempSpecialOffersViewController;
    
    [self.view addSubview:specialOffersViewController.view];
    
    [tempSpecialOffersViewController release];
}


-(void)reviewAction:(id)sender
{
    [activityIndicator startAnimating];
    
	NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    NSMutableArray *catalogResponse =  [[NSMutableArray alloc]init];
    
    
    NSString *strId=[[NSString alloc]init];
    NSString *strName=[[NSString alloc]init];
    NSString *strQty=[[NSString alloc]init];
    NSString *strPrice=[[NSString alloc]init];
    NSString *strImage=[[NSString alloc]init];
    NSString *strDetail=[[NSString alloc]init];
    NSString *strTotal=[[NSString alloc]init];
    
    
    strId = @"3";
    strName = @"LED3DTV4686 46' Class 3D LED TV w/ 2  Glasses";
    strQty = @"2";
    strPrice = @"1050";
    strImage = @"http://172.16.23.65:8880/images/web/product";
    strDetail = @"http://172.16.23.65:8880/images/web/product/details/coby_tv_3.png";
    strTotal = @"2100.00";
    
    
    [dictCat setObject:strId forKey:@"productId"];
    [dictCat setObject:strName forKey:@"name"];
    [dictCat setObject:strQty forKey:@"quantity"];
    [dictCat setObject:strPrice forKey:@"price"];
    [dictCat setObject:strImage forKey:@"imageURL"];
    [dictCat setObject:strDetail forKey:@"detailImageURL"];
    [dictCat setObject:strTotal forKey:@"totalPrice"];
    [catalogResponse addObject:[dictCat copy]];
    
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionaryWithObject:catalogResponse forKey:@"products"];
    
    NSString *strPay=[[NSString alloc]init];
    
    strPay = @"Cash on Delivery";
    
    [jsonDictionary setObject:strPay forKey:@"paymentMethod"];
    
    NSMutableDictionary *dictCustomer = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dictBilling = [[NSMutableDictionary alloc]init];
    
    NSString *strEmail=[[NSString alloc]init];
    
    strEmail = @"arunkumar.klnmca@gmail.com";
    
    [dictBilling setObject:strEmail forKey:@"emailID"];
    
    
    [dictCustomer setObject:strFirst forKey:kfirstname];
    [dictCustomer setObject:strLast forKey:klastname];
    [dictCustomer setObject:strComp forKey:kcompany];
    [dictCustomer setObject:strAddr1 forKey:kaddress1];
    [dictCustomer setObject:strAddr2 forKey:kaddress2];
    [dictCustomer setObject:strState forKey:kstate];
    [dictCustomer setObject:strCountry forKey:kcountry];
    [dictCustomer setObject:strZip forKey:kzip];
    [dictCustomer setObject:strPhone forKey:kphone];
    
    [dictBilling setObject:dictCustomer forKey:@"deliveryAddress"];

    [dictCustomer setObject:strFirst forKey:kfirstname];
    [dictCustomer setObject:strLast forKey:klastname];
    [dictCustomer setObject:strComp forKey:kcompany];
    [dictCustomer setObject:strAddr1 forKey:kaddress1];
    [dictCustomer setObject:strAddr2 forKey:kaddress2];
    [dictCustomer setObject:strState forKey:kstate];
    [dictCustomer setObject:strCountry forKey:kcountry];
    [dictCustomer setObject:strZip forKey:kzip];
    [dictCustomer setObject:strPhone forKey:kphone];
    
    [dictBilling setObject:dictCustomer forKey:@"billingAddress"];
    
    [jsonDictionary setObject:dictBilling forKey:@"customerInfo"];
    
    [jsonDictionary setObject:stringTotalPrice forKey:@"totalPrice"];
    
    [jsonDictionary setObject:strOrderComments forKey:@"comments"];
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    NSString *urlString;
    
    /* if(filePath)
     {*/
    
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]]; 
    
    urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,korderproduct,kpost,korderdetail];
    
    NSLog(@"urlString %@",urlString);
    // }
    
    SBJsonWriter *jsonWriter = [SBJsonWriter new];
    
    //Just for error tracing
    jsonWriter.humanReadable = YES;
    NSString *json = [jsonWriter stringWithObject:jsonDictionary];
   
    if (!json){
    
        NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
    }
    
    [jsonWriter release];
    
    NSData *postData = [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; 
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
	[request setURL:[NSURL URLWithString:urlString]]; 
	[request setHTTPMethod:@"POST"]; 
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
	[request setHTTPBody:postData]; 
    
	NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self]; 
	NSData* receivedData1 = [[NSMutableData data] retain]; 
    
	if (conn) 
		receivedData1 = [[NSMutableData data] retain]; 
	else 
	{ 
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:  @"Error while updating data on network."  
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
		[alert show]; 
		[alert release]; 
	} 
	
	/*...NSURLResponse...*/
	
	response = nil; 
	error = nil; 
	data = nil; 
	
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	    
    NSDictionary* responseDict = [responseString JSONValue];
    //NSLog(@"response :%@", responseDict);
    
    NSMutableString* strMsg = [[NSMutableString alloc] init];
    strMsg = [responseDict objectForKey:@"message"];
    
    NSMutableString* successMsg = [[NSMutableString alloc] init];
    successMsg = [responseDict objectForKey:@"successMessage"];
    
    if([successMsg isEqualToString:@"Success"]) {
        [activityIndicator stopAnimating];
        OrderStatusViewController  *checkViewCartController = [[OrderStatusViewController alloc] initWithNibName:@"OrderStatusViewController" bundle:nil];
        
        self.orderStatusViewController = checkViewCartController;
        
        [self.view addSubview:orderStatusViewController.view];
        
        [checkViewCartController release];
    }
    else {
        [activityIndicator stopAnimating];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:  @"Order cannot be placed. Please try again"  
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
		[alert show]; 
		[alert release];   
    }
    
    
}

-(void)cancelAction:(id)sender
{
	[self.view removeFromSuperview];
    
    
}


- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>0) return YES;
    
    return NO;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

#pragma mark TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if ([expandedSections containsIndex:section])
    {
        return 2; // return rows when expanded
    }
    
       
    // Return the number of rows in the section.
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        if (!indexPath.row)
        {
            return 70;
        } 
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            return 60;
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            return 480;
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            return 480;
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            return 200;
        }
        else 
        {
            return 80;
        }
    }
    else {
        
        if (!indexPath.row)
        {
            return 35;
        } 
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            return 30;
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            return 240;
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            return 240;
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            return 100;
        }
        else 
        {
            return 40;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        if (!indexPath.row)
        {
            if (indexPath.section ==0){
                // first row
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cell.textLabel.text = @"Customer Informations"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==1)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cell.textLabel.text = @"Delivery Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==2)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cell.textLabel.text = @"Billing Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==3)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cell.textLabel.text = @"Payment Methods"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else 
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cell.textLabel.text = @"Order Comments"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            }
            
                        
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *indexTemp = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 629, 40)];
                indexTemp.tag = 2;
                indexTemp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top-72.png"]];
                [indexTemp setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                indexTemp.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:indexTemp];
                [indexTemp release];
                
                UILabel *lblIndex = (UILabel *)[cell viewWithTag:2];
                lblIndex.text = strEmailId;
                
                         
            }
            
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(5, 10,  629, 40)];
                firstName.tag = 6;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                firstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top-72.png"]];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(5, 52, 629, 40)];
                lastName.tag = 7;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 94, 629, 40)];
                companyLabel.tag = 8;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                companyLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(5, 136, 629, 40)];
                lblAddress.tag = 9;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblAddress.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 178, 629, 40)];
                lblAddrLine.tag = 10;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblAddrLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 629, 40)];
                cityLabel.tag = 11;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cityLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(5, 262, 629, 40)];
                lblProvince.tag = 12;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblProvince.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 304, 629, 40)];
                countryLabel.tag = 13;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                countryLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(5, 346, 629, 40)];
                lblZip.tag = 14;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblZip.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(5, 388, 629, 62)];
                lblNumber.tag = 15;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom-72.png"]];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:6];
                [lblFirst setText:[NSString stringWithFormat: @"\tFirst name*         : %@",strFirst]];
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:7];
                lblLast.text = [NSString stringWithFormat: @"\tLast name          : %@",strLast];
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:8];
                lblComp.text = [NSString stringWithFormat: @"\tCompany           : %@",strComp];
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:9];
                lblAdd1.text = [NSString stringWithFormat: @"\tAddress1*          : %@",strAddr1];
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:10];
                lblAdd2.text = [NSString stringWithFormat: @"\tAddress2*          : %@",strAddr2];
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:11];
                lblCity.text = [NSString stringWithFormat: @"\tCity*                   : %@",strCity];
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:12];
                lblState.text = [NSString stringWithFormat: @"\tState/Province*  : %@",strState];
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:13];
                lblCountry.text = [NSString stringWithFormat: @"\tCountry*            : %@",strCountry];
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:14];
                lblPost.text = [NSString stringWithFormat: @"\tPostcode*          : %@",strZip];
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:15];
                lblPhone.text = [NSString stringWithFormat: @"\tPhone Number   : %@",strPhone];
                
                
            }
            
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 629, 40)];
                firstName.tag = 34;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                firstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top-72.png"]];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(5, 52, 629, 40)];
                lastName.tag = 35;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 94, 629, 40)];
                companyLabel.tag = 36;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                companyLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(5, 136, 629, 40)];
                lblAddress.tag = 37;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblAddress.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 178, 629, 40)];
                lblAddrLine.tag = 38;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblAddrLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 629, 40)];
                cityLabel.tag = 39;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                cityLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(5, 262, 629, 40)];
                lblProvince.tag = 40;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblProvince.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 304, 629, 40)];
                countryLabel.tag = 41;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                countryLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(5, 346, 629, 40)];
                lblZip.tag = 42;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblZip.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(5, 388, 629, 62)];
                lblNumber.tag = 43;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom-72.png"]];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:34];
                [lblFirst setText:[NSString stringWithFormat: @"\tFirst name*         : %@",strFirst]];
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:35];
                lblLast.text =  [NSString stringWithFormat: @"\tLast name          : %@",strLast];
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:36];
                lblComp.text = [NSString stringWithFormat: @"\tCompany           : %@",strComp];
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:37];
                lblAdd1.text = [NSString stringWithFormat: @"\tAddress1*          : %@",strAddr1];
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:38];
                lblAdd2.text = [NSString stringWithFormat: @"\tAddress2*          : %@",strAddr2];
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:39];
                lblCity.text = [NSString stringWithFormat: @"\tCity*                   : %@",strCity];
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:40];
                lblState.text = [NSString stringWithFormat: @"\tState/Province*  : %@",strState];
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:41];
                lblCountry.text = [NSString stringWithFormat: @"\tCountry*            : %@",strCountry];
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:42];
                lblPost.text = [NSString stringWithFormat: @"\tPostcode*          : %@",strZip];
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:43];
                lblPhone.text = [NSString stringWithFormat: @"\tPhone Number   : %@",strPhone];
                
            }
            
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblMO = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 629, 40)];
                lblMO.tag = 62;
                [lblMO setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblMO.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top-72.png"]];
                lblMO.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblMO];
                [lblMO release];
                
                UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(5, 52, 629, 40)];
                lblTotal.tag = 63;
                [lblTotal setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblTotal.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblTotal];
                [lblTotal release];
                
                UILabel *lblOrderTotal = [[UILabel alloc] initWithFrame:CGRectMake(5, 94, 629, 40)];
                lblOrderTotal.tag = 64;
                [lblOrderTotal setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblOrderTotal.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblOrderTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrderTotal];
                [lblOrderTotal release];
                
                UILabel *lblStatement = [[UILabel alloc] initWithFrame:CGRectMake(5, 136, 629, 62)];
                lblStatement.tag = 65;
                [lblStatement setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblStatement.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom-72.png"]];
                lblStatement.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblStatement];
                [lblStatement release];
                
                UILabel *lblOrder = (UILabel *)[cell viewWithTag:62];
                lblOrder.text = @"\tSubTotal       : $3750";
                
                UILabel *lblSub = (UILabel *)[cell viewWithTag:63];
                lblSub.text = @"\tOrderTotal     : $3750";
                
                UILabel *orderTotal = (UILabel *)[cell viewWithTag:64];
                orderTotal.text = @"\tPayment by   : Cheque";
                
                UILabel *stmtLabel = (UILabel *)[cell viewWithTag:65];
                stmtLabel.text = @"\tMail to           : Phresco";
            }
            
        }
        else 
        {
            if ((cell == nil) ||(cell != nil)) {
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 629, 40)];
                lblComments.tag = 66;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblComments.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle-72.png"]];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                
                UILabel *lblView = (UILabel *)[cell viewWithTag:66];
                lblView.text = [NSString stringWithFormat:@"\t %@",strOrderComments];
                
            }
        }
        
        return cell;
    }
    else {
        if (!indexPath.row)
        {
            if (indexPath.section ==0){
                // first row
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cell.textLabel.text = @"Customer Informations"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==1)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cell.textLabel.text = @"Delivery Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==2)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cell.textLabel.text = @"Billing Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else if (indexPath.section ==3)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cell.textLabel.text = @"Payment Methods"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            } else 
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cell.textLabel.text = @"Order Comments"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
            }
            
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *indexTemp = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 314, 20)];
                indexTemp.tag = 2;
                indexTemp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top.png"]];
                [indexTemp setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                indexTemp.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:indexTemp];
                [indexTemp release];
                
                UILabel *lblIndex = (UILabel *)[cell viewWithTag:2];
                lblIndex.text = strEmailId;
                
                
            }
            
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(3, 05,  314, 20)];
                firstName.tag = 6;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                firstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top.png"]];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(3, 26, 314, 20)];
                lastName.tag = 7;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 47, 314, 20)];
                companyLabel.tag = 8;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                companyLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(3, 68, 314, 20)];
                lblAddress.tag = 9;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblAddress.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(3, 89, 314, 20)];
                lblAddrLine.tag = 10;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblAddrLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 110, 314, 20)];
                cityLabel.tag = 11;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cityLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(3, 131, 314, 20)];
                lblProvince.tag = 12;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblProvince.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 152, 314, 20)];
                countryLabel.tag = 13;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                countryLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(3, 173, 314, 20)];
                lblZip.tag = 14;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblZip.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(3, 194, 314, 31)];
                lblNumber.tag = 15;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom.png"]];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:6];
                [lblFirst setText:[NSString stringWithFormat: @"\tFirst name*         : %@",strFirst]];
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:7];
                lblLast.text = [NSString stringWithFormat: @"\tLast name          : %@",strLast];
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:8];
                lblComp.text = [NSString stringWithFormat: @"\tCompany           : %@",strComp];
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:9];
                lblAdd1.text = [NSString stringWithFormat: @"\tAddress1*          : %@",strAddr1];
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:10];
                lblAdd2.text = [NSString stringWithFormat: @"\tAddress2*          : %@",strAddr2];
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:11];
                lblCity.text = [NSString stringWithFormat: @"\tCity*                   : %@",strCity];
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:12];
                lblState.text = [NSString stringWithFormat: @"\tState/Province*  : %@",strState];
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:13];
                lblCountry.text = [NSString stringWithFormat: @"\tCountry*            : %@",strCountry];
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:14];
                lblPost.text = [NSString stringWithFormat: @"\tPostcode*          : %@",strZip];
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:15];
                lblPhone.text = [NSString stringWithFormat: @"\tPhone Number   : %@",strPhone];
                
                
            }
            
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(3, 05, 314, 20)];
                firstName.tag = 34;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                firstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top.png"]];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(3, 26, 314, 20)];
                lastName.tag = 35;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 47, 314, 20)];
                companyLabel.tag = 36;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                companyLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(3, 68, 314, 20)];
                lblAddress.tag = 37;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblAddress.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(3, 89, 314, 20)];
                lblAddrLine.tag = 38;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblAddrLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 110, 314, 20)];
                cityLabel.tag = 39;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                cityLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(3, 131, 314, 20)];
                lblProvince.tag = 40;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblProvince.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 152, 314, 20)];
                countryLabel.tag = 41;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                countryLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(3, 173, 314, 20)];
                lblZip.tag = 42;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblZip.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(3, 194, 314, 31)];
                lblNumber.tag = 43;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom.png"]];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:34];
                [lblFirst setText:[NSString stringWithFormat: @"\tFirst name*         : %@",strFirst]];
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:35];
                lblLast.text =  [NSString stringWithFormat: @"\tLast name          : %@",strLast];
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:36];
                lblComp.text = [NSString stringWithFormat: @"\tCompany           : %@",strComp];
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:37];
                lblAdd1.text = [NSString stringWithFormat: @"\tAddress1*          : %@",strAddr1];
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:38];
                lblAdd2.text = [NSString stringWithFormat: @"\tAddress2*          : %@",strAddr2];
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:39];
                lblCity.text = [NSString stringWithFormat: @"\tCity*                   : %@",strCity];
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:40];
                lblState.text = [NSString stringWithFormat: @"\tState/Province*  : %@",strState];
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:41];
                lblCountry.text = [NSString stringWithFormat: @"\tCountry*            : %@",strCountry];
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:42];
                lblPost.text = [NSString stringWithFormat: @"\tPostcode*          : %@",strZip];
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:43];
                lblPhone.text = [NSString stringWithFormat: @"\tPhone Number   : %@",strPhone];
                
            }
            
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblMO = [[UILabel alloc] initWithFrame:CGRectMake(3, 05, 314, 20)];
                lblMO.tag = 62;
                [lblMO setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblMO.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_top.png"]];
                lblMO.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblMO];
                [lblMO release];
                
                UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(3, 26, 314, 20)];
                lblTotal.tag = 63;
                [lblTotal setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblTotal.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblTotal];
                [lblTotal release];
                
                UILabel *lblOrderTotal = [[UILabel alloc] initWithFrame:CGRectMake(3, 47, 314, 20)];
                lblOrderTotal.tag = 64;
                [lblOrderTotal setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblOrderTotal.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblOrderTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrderTotal];
                [lblOrderTotal release];
                
                UILabel *lblStatement = [[UILabel alloc] initWithFrame:CGRectMake(3, 68, 314, 31)];
                lblStatement.tag = 65;
                [lblStatement setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblStatement.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_bottom.png"]];
                lblStatement.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblStatement];
                [lblStatement release];
                
                
                UILabel *lblOrder = (UILabel *)[cell viewWithTag:62];
                lblOrder.text = @"\tSubTotal       : $3750";
                
                UILabel *lblSub = (UILabel *)[cell viewWithTag:63];
                lblSub.text = @"\tOrderTotal     : $3750";
                
                UILabel *orderTotal = (UILabel *)[cell viewWithTag:64];
                orderTotal.text = @"\tPayment by   : Cheque";
                
                UILabel *stmtLabel = (UILabel *)[cell viewWithTag:65];
                stmtLabel.text = @"\tMail to           : Phresco";
            }
            
        }
        else 
        {
            
            if ((cell == nil) ||(cell != nil)) {
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(3, 05, 314, 20)];
                lblComments.tag = 66;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblComments.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_viewlist_middle.png"]];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                
                UILabel *lblView = (UILabel *)[cell viewWithTag:66];
                lblView.text = [NSString stringWithFormat:@"\t %@",strOrderComments];
                
            }
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if (!indexPath.row)
    {
        // only first row toggles exapand/collapse
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSInteger section = indexPath.section;
        BOOL currentlyExpanded = [expandedSections containsIndex:section];
        NSInteger rows;
        
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        if (currentlyExpanded)
        {
            rows = [self tableView:tableView numberOfRowsInSection:section];
            [expandedSections removeIndex:section];
            
        }
        else
        {
            [expandedSections addIndex:section];
            rows = [self tableView:tableView numberOfRowsInSection:section];
        }
        
        
        for (int i=1; i<rows; i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i 
                                                           inSection:section];
            [tmpArray addObject:tmpIndexPath];
        }
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (currentlyExpanded)
        {
            [tableView deleteRowsAtIndexPaths:tmpArray 
                             withRowAnimation:UITableViewRowAnimationTop];
            
            cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            
        }
        else
        {
            [tableView insertRowsAtIndexPaths:tmpArray 
                             withRowAnimation:UITableViewRowAnimationTop];
            cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
            
        }
    }
  
    
}

-(void)dealloc
{
    [super dealloc];
    
    [productImageArray release];
    [expandedSections release];
    [tabbar release];
    [orderStatusViewController release];
    [browseViewController release];
    [specialOffersViewController release];
}



@end
