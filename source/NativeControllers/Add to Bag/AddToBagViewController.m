//
//  AddToBagViewController.m
//  Phresco
//
//  Created by photon on 11/25/11.
//  Copyright 2011 EWR. All rights reserved.
//

#define LEAGELNUM @"0123456789"

#import "AddToBagViewController.h"
#import "ViewCartController.h"

#import "AsyncImageView.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "ProductDetailsViewController.h"
#import "CheckOutViewController.h"
#import "BrowseViewController.h"
#import "SpecialOffersViewController.h"
#import "ServiceHandler.h"
#import "Tabbar.h"


@implementation AddToBagViewController

@synthesize scrollView;
@synthesize viewCartController;
@synthesize addToBagTable;
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize checkCartController;
@synthesize cartCount;
@synthesize browseViewController;
@synthesize specialOffersViewController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"AddtoBagViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"AddToBagViewController" bundle:nil];
        
    }
    
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    inputTexts = [[NSMutableArray alloc] init];
    
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
}

-(void) loadNavigationBar
{
	//add scroll view
    NSLog(@"Add to cart....");
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
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        [searchBarView release];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal-72.png"], [UIImage imageNamed:@"specialoffers_btn_normal-72.png"], [UIImage imageNamed:@"mycart_btn_highlighted-72.png"], 
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
            
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release];
            
        }
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        if ([assetsData.arrayAddtoCart count] == 0) {
        }
        else{
            
            myCartView = [[UILabel alloc] initWithFrame:CGRectMake(320, 151 , 140, 40)];
            
            [myCartView setFont:[UIFont fontWithName:@"Helvetica" size:24]];
            myCartView.backgroundColor = [UIColor clearColor];
            [myCartView setText:@"My Cart"];
            [myCartView setTextColor:[UIColor whiteColor]];
            
            [self.view addSubview:myCartView];
            
            [myCartView release];
            
            viewMyCart = [[UIButton alloc] initWithFrame:CGRectMake(460, 800 , 150, 60)];
            
            [viewMyCart setBackgroundImage:[UIImage imageNamed:@"viewmycart_btn.png"] forState:UIControlStateNormal];
            
            [viewMyCart addTarget:self action:@selector(viewMyCart:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:viewMyCart];
            
            [viewMyCart release];
            
            updateCart = [[UIButton alloc] initWithFrame:CGRectMake(140, 800 , 150, 60)];
            
            [updateCart setBackgroundImage:[UIImage imageNamed:@"updatecart_btn.png"] forState:UIControlStateNormal];
            
            [updateCart addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:updateCart];
            
            [updateCart release];
        }
        
        UIImageView    *subTotalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 690, 768, 80)];
        
        [subTotalView setImage:[UIImage imageNamed:@"subtotal_bg.png"]];
        
        [self.view addSubview:subTotalView];
        
        [subTotalView release];
        
        int price;
        
        purchase=0;
        
        
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            cartCount=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"];
            [inputTexts addObject:cartCount];
            //txtQty.text = cartCount;
            price = [cartPrice intValue];
            NSLog(@"price Total: %d",price);
            
            theInteger = [cartCount intValue];
            NSLog(@"cartCount Total: %@",cartCount);
            NSLog(@"purchase: %d",([cartPrice intValue] * theInteger));
            purchase = purchase + ([cartPrice intValue] * theInteger);
            
            NSLog(@"Total: %d",purchase);
        }
        
        
        lblSubtotal = [[UILabel alloc] initWithFrame:CGRectMake(510, 710 , 240, 40)];
        
        [lblSubtotal setFont:[UIFont fontWithName:@"Helvetica" size:26]];
        lblSubtotal.backgroundColor = [UIColor clearColor];
        [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %d",purchase]];
        [lblSubtotal setTextColor:[UIColor blueColor]];
        
        [self.view addSubview:lblSubtotal];
        
        
        
        
        
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_normal.png"], [UIImage imageNamed:@"mycart_btn_highlighted.png"], 
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
            
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release];
            
        }
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        if ([assetsData.arrayAddtoCart count] == 0) {
        }
        else{
            
            myCartView = [[UILabel alloc] initWithFrame:CGRectMake(120, 80 , 80, 20)];
            
            [myCartView setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            myCartView.backgroundColor = [UIColor clearColor];
            [myCartView setText:@"My Cart"];
            [myCartView setTextColor:[UIColor whiteColor]];
            
            [self.view addSubview:myCartView];
            
            [myCartView release];
            
            viewMyCart = [[UIButton alloc] initWithFrame:CGRectMake(180, 350 , 90, 30)];
            
            [viewMyCart setBackgroundImage:[UIImage imageNamed:@"viewmycart_btn.png"] forState:UIControlStateNormal];
            
            [viewMyCart addTarget:self action:@selector(viewMyCart:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:viewMyCart];
            
            [viewMyCart release];
            
            updateCart = [[UIButton alloc] initWithFrame:CGRectMake(70, 350 , 90, 30)];
            
            [updateCart setBackgroundImage:[UIImage imageNamed:@"updatecart_btn.png"] forState:UIControlStateNormal];
            
            [updateCart addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:updateCart];
            
            [updateCart release];
        }
        
        
        
        UIImageView    *subTotalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 296, 320, 40)];
        
        [subTotalView setImage:[UIImage imageNamed:@"subtotal_bg.png"]];
        
        [self.view addSubview:subTotalView];
        
        [subTotalView release];
        
        int price;
        
        purchase=0;
        
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            cartCount=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"];
            [inputTexts addObject:cartCount];
            
            price = [cartPrice intValue];
            
            theInteger = [cartCount intValue];
            
            purchase = purchase + ([cartPrice intValue] * theInteger);
            
        }
        
        
        lblSubtotal = [[UILabel alloc] initWithFrame:CGRectMake(210, 300 , 120, 20)];
        
        [lblSubtotal setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        lblSubtotal.backgroundColor = [UIColor clearColor];
        [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %d",purchase]];
        [lblSubtotal setTextColor:[UIColor blueColor]];
        
        [self.view addSubview:lblSubtotal];
    }
    
}

-(void) initializeTableView
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if ([assetsData.arrayAddtoCart count] == 0) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            UILabel *lblNoCart = [[UILabel alloc]initWithFrame:CGRectMake(90, 320, 560, 100)];
            lblNoCart.text = @"No items in your cart";
            lblNoCart.backgroundColor = [UIColor clearColor];
            lblNoCart.textColor = [UIColor whiteColor];
            lblNoCart.textAlignment = UITextAlignmentCenter;
            [self.view addSubview:lblNoCart];
        }
        else {
            UILabel *lblNoCart = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 280, 50)];
            lblNoCart.text = @"No items in your cart";
            lblNoCart.backgroundColor = [UIColor clearColor];
            lblNoCart.textColor = [UIColor whiteColor];
            lblNoCart.textAlignment = UITextAlignmentCenter;
            [self.view addSubview:lblNoCart];
        }
    } 
    else {
        
        float heightTable;
        float iPadHeightTable;
        
        if ([assetsData.arrayAddtoCart count] == 1)
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                iPadHeightTable = 200;
            }
            else {
                heightTable = 100;
            }
        } else {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                iPadHeightTable = 380;
            }
            else {
                heightTable = 190;
            }
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 205, 768, iPadHeightTable) style:UITableViewStylePlain];
        }
        else {
            addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 320, heightTable) style:UITableViewStylePlain];
        }
        
        addToBagTable.dataSource = self;
        addToBagTable.delegate = self;
        addToBagTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        
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
}

-(void)goBack:(id)sender
{
	[self.view removeFromSuperview];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:LEAGELNUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]     componentsJoinedByString:@""];
    NSLog(@"filtered:%@",filtered);
    BOOL basicTest = [string isEqualToString:filtered];
    return basicTest;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    theInteger = [textField.text intValue];
    [textField resignFirstResponder];
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [inputTexts replaceObjectAtIndex:insVal withObject:textField.text];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    
    NSDictionary *oldDict = (NSDictionary *)[assetsData.arrayAddtoCart objectAtIndex:[textField tag]];
    
    [newDict addEntriesFromDictionary:oldDict];
    
    [newDict setObject:textField.text forKey:@"Count"];
    
    [assetsData.arrayAddtoCart replaceObjectAtIndex:[textField tag] withObject:newDict];
    
    [newDict release];
    
    return YES;
}


#pragma mark Button Actions

- (void) browseButtonSelected:(id)sender 
{
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    assetsData.catalogArray = [[NSMutableArray alloc]init];
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
    
    self.specialOffersViewController = tempSpecialOffersViewController;
    
    [self.view addSubview:specialOffersViewController.view];
    
    [tempSpecialOffersViewController release];
}

-(void)updateAction:(id)sender
{
    
    if (![txtQty.text length]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else
    {
        int price;
        
        purchase=0;
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            
            price = [cartPrice intValue];
            
            theInteger = [[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"] intValue];
            purchase = purchase + (price * theInteger);
            
            [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %d",purchase]];
            
            if([lblSubtotal.text length] > 17) 
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                    lblSubtotal.frame = CGRectMake(480, 710 , 300, 40);
                    [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %d",purchase]];
                    
                }
                else {
                    lblSubtotal.frame = CGRectMake(180, 300, 180, 20);
                    [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %d",purchase]];
                }
            }
            
        }
    }
}

-(void)viewAction:(id)sender
{
	
    CheckOutViewController  *checkViewCartController = [[CheckOutViewController alloc] initWithNibName:@"ViewCartController" bundle:nil];
    
    self.checkCartController = checkViewCartController;
    
    [self.view addSubview:checkCartController.view];
    
    [checkViewCartController release];
    
}


-(void)viewMyCart:(id)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        ViewCartController  *tempViewCartController = [[ViewCartController alloc] initWithNibName:@"ViewCartController-iPad" bundle:nil];
        
        tempViewCartController.cartPurchaseTotal = [NSString stringWithFormat:@"%d",purchase];
        
        tempViewCartController.cartQuantity = [NSString stringWithFormat:@"%@",cartCount];
        
        self.viewCartController = tempViewCartController;
        
        [self.view addSubview:viewCartController.view];
        
        [tempViewCartController release];
    }
    else {
        ViewCartController  *tempViewCartController = [[ViewCartController alloc] initWithNibName:@"ViewCartController" bundle:nil];
        
        tempViewCartController.cartPurchaseTotal = [NSString stringWithFormat:@"%d",purchase];
        
        tempViewCartController.cartQuantity = [NSString stringWithFormat:@"%@",cartCount];
        
        self.viewCartController = tempViewCartController;
        
        [self.view addSubview:viewCartController.view];
        
        [tempViewCartController release];
    }
}

-(void)removeIndex:(id)sender
{
    [addToBagTable reloadData];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if ([assetsData.arrayAddtoCart count]==1) {
        [assetsData.arrayAddtoCart removeObjectAtIndex:[sender tag]];
        [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$0"]];
        
        assetsData.arrayAddtoCart = [[NSMutableArray alloc]init];
        txtQty = [[UITextField alloc]init];
        myCartView.hidden = YES;
        viewMyCart.hidden = YES;
        updateCart.hidden = YES;
        [addToBagTable reloadData];
        
    }
    else {
        [assetsData.arrayAddtoCart removeObjectAtIndex:[sender tag]];
        
        int price;
        purchase=0;
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            
            price = [cartPrice intValue];
            
            theInteger = [[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"] intValue];
            purchase = purchase + (price * theInteger);
            
            [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$%d",purchase]];
            
            cartCount=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"];
            [inputTexts addObject:cartCount];
        }
        
        
        [addToBagTable reloadData];
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Product removed Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if ([assetsData.arrayAddtoCart count] == 0) {
        
        return 1;
    } 
    else {
        
        return [assetsData.arrayAddtoCart count];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 200;
    }
    else {
        return 100;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"AddToBagCell";
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	if ((cell == nil) ||(cell != nil)) {
        if ([assetsData.arrayAddtoCart count] == 0) {
            
        }
        else
        {
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                UIImageView *productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 17, 60, 80)];
                productImageView.tag=1;
                
                UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 17, 300, 60)];
                [productLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                productLabel.tag=2;
                productLabel.backgroundColor = [UIColor clearColor];
                productLabel.numberOfLines = 2;
                [productLabel setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:productLabel];
                [productLabel release];
                
                UILabel *Quantity = [[UILabel alloc] initWithFrame:CGRectMake(130, 80, 300, 60)];
                [Quantity setFont:[UIFont fontWithName:@"Helvetica" size:28]];
                Quantity.tag=3;
                Quantity.backgroundColor = [UIColor clearColor];
                [Quantity setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:Quantity];
                [Quantity release];
                
                
                UITextField *quantityTextView = [[UITextField alloc] initWithFrame:CGRectMake(270 , 90, 80, 40)];
                [quantityTextView setBackgroundColor:[UIColor whiteColor]];
                quantityTextView.tag=4;
                [quantityTextView setDelegate:self];
                quantityTextView.keyboardType = UIKeyboardTypeDefault;
                quantityTextView.returnKeyType = UIReturnKeyDone;
                [quantityTextView setEnabled: YES];
                [cell.contentView addSubview:quantityTextView];
                [quantityTextView release];
                
                UIButton *btnRemove = [[UIButton alloc] initWithFrame:CGRectMake(618 , 100, 102, 40)];
                btnRemove.tag=5;
                [btnRemove setBackgroundImage:[UIImage imageNamed:@"remove_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnRemove];
                [btnRemove release];
                
                UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 130 ,100, 60)];
                [priceLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                priceLabel.tag=600;
                priceLabel.backgroundColor = [UIColor clearColor];
                [priceLabel setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:priceLabel];
                [priceLabel release];
                
                UILabel *priceValue = [[UILabel alloc] initWithFrame:CGRectMake(240, 130 , 100, 60)];
                [priceValue setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                priceValue.tag=700;
                priceValue.backgroundColor = [UIColor clearColor];
                [priceValue setTextColor:[UIColor yellowColor]];
                [cell.contentView addSubview:priceValue];
                [priceValue release];
                
                UILabel *productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(330, 17, 80, 60)];
                [productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                productCountLabel.tag=800;
                productCountLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:productCountLabel];
                [productCountLabel release];
                
                NSString *strPrice=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"ListPrice"];
                int total = [strPrice intValue];
                
                int subtotal;
                
                subtotal = (theInteger * total);
                
                CGRect frame;
                frame.size.width=100; 
                frame.size.height=100;
                frame.origin.x=20; 
                frame.origin.y=17;
                
                AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                               initWithFrame:frame] ;
                
                // TODO: Add Code for getting Coupons Image URL
                NSURL	*url = nil;
                
                url = [NSURL URLWithString:[[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Image"]];
                
                [tasyncImage loadImageFromURL:url];
                
                [cell.contentView addSubview:tasyncImage];
                [tasyncImage release];
                
                UILabel *billLabel = (UILabel *)[cell viewWithTag:2];
                billLabel.text = [[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Name"];
                
                UILabel *lblSaved = (UILabel *)[cell viewWithTag:3];
                [lblSaved setText:@"Quantity: "];
                
                txtQty = (UITextField *)[cell viewWithTag:4];
                txtQty.text = [[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Count"];
                [txtQty setTag:indexPath.row];
                
                UIButton *saveBtn = (UIButton *)[cell viewWithTag:5];
                [saveBtn setTag:indexPath.row];
                [saveBtn addTarget:self action:@selector(removeIndex:) forControlEvents:UIControlEventTouchUpInside];
                pathDelete = indexPath;
                
                UILabel *lblValue = (UILabel *)[cell viewWithTag:600];
                [lblValue setText:@"Price: "];
                
                UILabel *lblPrice = (UILabel *)[cell viewWithTag:700];
                lblPrice.text = [NSString stringWithFormat:@"$%@",strPrice];
                
                UILabel *lblCount = (UILabel *)[cell viewWithTag:800];
                lblCount.backgroundColor = [UIColor clearColor];
                
                
            }
            else 
            {
                UIImageView *productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 40)];
                productImageView.tag=1;
                
                UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 7, 150, 30)];
                [productLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                productLabel.tag=2;
                productLabel.backgroundColor = [UIColor clearColor];
                productLabel.numberOfLines = 2;
                [productLabel setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:productLabel];
                [productLabel release];
                
                UILabel *Quantity = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 30)];
                [Quantity setFont:[UIFont fontWithName:@"Helvetica" size:14]];
                Quantity.tag=3;
                Quantity.backgroundColor = [UIColor clearColor];
                [Quantity setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:Quantity];
                [Quantity release];
                
                
                UITextField *quantityTextView = [[UITextField alloc] initWithFrame:CGRectMake(150 , 45, 40, 20)];
                [quantityTextView setBackgroundColor:[UIColor whiteColor]];
                quantityTextView.tag=4;
                [quantityTextView setDelegate:self];
                quantityTextView.keyboardType = UIKeyboardTypeDefault;
                quantityTextView.returnKeyType = UIReturnKeyDone;
                [quantityTextView setEnabled: YES];
                
                //        NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
                //        [numberFormatter setFormat:@"$#, ##0.00"];
                
                [cell.contentView addSubview:quantityTextView];
                [quantityTextView release];
                
                UIButton *btnRemove = [[UIButton alloc] initWithFrame:CGRectMake(248 , 45, 62, 20)];
                btnRemove.tag=5;
                [btnRemove setBackgroundImage:[UIImage imageNamed:@"remove_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnRemove];
                [btnRemove release];
                
                UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 60 ,50, 30)];
                [priceLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                priceLabel.tag=600;
                priceLabel.backgroundColor = [UIColor clearColor];
                [priceLabel setTextColor:[UIColor whiteColor]];
                [cell.contentView addSubview:priceLabel];
                [priceLabel release];
                
                UILabel *priceValue = [[UILabel alloc] initWithFrame:CGRectMake(120,60 , 50, 30)];
                [priceValue setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                priceValue.tag=700;
                priceValue.backgroundColor = [UIColor clearColor];
                [priceValue setTextColor:[UIColor yellowColor]];
                [cell.contentView addSubview:priceValue];
                [priceValue release];
                
                UILabel *productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 7, 40, 30)];
                [productCountLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                productCountLabel.tag=800;
                productCountLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:productCountLabel];
                [productCountLabel release];
                
                NSString *strPrice=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"ListPrice"];
                int total = [strPrice intValue];
                
                int subtotal;
                
                subtotal = (theInteger * total);
                
                CGRect frame;
                frame.size.width=60; 
                frame.size.height=60;
                frame.origin.x=10; 
                frame.origin.y=7;
                
                AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                               initWithFrame:frame] ;
                
                if([assetsData.arrayAddtoCart count] ==0)
                {
                    
                }
                else
                {
                    // TODO: Add Code for getting Coupons Image URL
                    NSURL	*url = nil;
                    
                    url = [NSURL URLWithString:[[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Image"]];
                    
                    [tasyncImage loadImageFromURL:url];
                    
                    [cell.contentView addSubview:tasyncImage];
                    [tasyncImage release];
                    
                    UILabel *billLabel = (UILabel *)[cell viewWithTag:2];
                    billLabel.text = [[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Name"];
                    
                    UILabel *lblSaved = (UILabel *)[cell viewWithTag:3];
                    [lblSaved setText:@"Quantity: "];
                    
                    txtQty = (UITextField *)[cell viewWithTag:4];
                    txtQty.text = [[assetsData.arrayAddtoCart objectAtIndex:indexPath.row]objectForKey:@"Count"];
                    [txtQty setTag:indexPath.row];
                    
                    UIButton *saveBtn = (UIButton *)[cell viewWithTag:5];
                    [saveBtn setTag:indexPath.row];
                    [saveBtn addTarget:self action:@selector(removeIndex:) forControlEvents:UIControlEventTouchUpInside];
                    pathDelete = indexPath;
                    
                    UILabel *lblValue = (UILabel *)[cell viewWithTag:600];
                    [lblValue setText:@"Price: "];
                    
                    UILabel *lblPrice = (UILabel *)[cell viewWithTag:700];
                    lblPrice.text = [NSString stringWithFormat:@"$%@",strPrice];
                    
                    UILabel *lblCount = (UILabel *)[cell viewWithTag:800];
                    lblCount.backgroundColor = [UIColor clearColor];
                } 
            }
            
        }
        
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // NSLog(@"... Delete : %d",indexPath.row);
    [tableView delete:indexPath];
    
    [tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
	
	[scrollView release];
    
    [viewCartController release];
    [super dealloc];
}


@end
