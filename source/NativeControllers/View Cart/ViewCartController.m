//
//  ViewCartController.m
//  Phresco
//
//  Created by photon on 11/25/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "ViewCartController.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "CheckOutViewController.h"
#import "BrowseViewController.h"
#import "CheckOutOVerallViewController.h"
#import "ServiceHandler.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"

@implementation ViewCartController

@synthesize viewCartTable;
@synthesize Quantity;
@synthesize Product;
@synthesize Price;
@synthesize PriceLabel;
@synthesize checkCartController;
@synthesize browseViewController;
@synthesize cartPurchaseTotal;
@synthesize cartQuantity;
@synthesize specialOffersViewController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"ViewCartController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"ViewCartController" bundle:nil];
        
    }
    return self;
}



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
    
    [self.view addSubview:viewCartTable];
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
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(300,161,250,45)];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"View My Cart"];
        [self.view addSubview:titleLabel];
        
        int price;
        int cart;
        int purchase=0;
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            NSString *cartCount=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"];
            
            price = [cartPrice intValue];
            
            cart = [cartCount intValue];
            
            purchase = purchase + ([cartPrice intValue] * [cartCount intValue]);
            
            
        }
        
        UIImageView    *subTotalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 706, 768, 80)];
        
        [subTotalView setImage:[UIImage imageNamed:@"subtotal_bg.png"]];
        
        [self.view addSubview:subTotalView];
        
        [subTotalView release];
        lblSubtotal = [[UILabel alloc] initWithFrame:CGRectMake(510, 720 , 220, 40)];
        [lblSubtotal setFont:[UIFont fontWithName:@"Helvetica" size:26]];
        lblSubtotal.backgroundColor = [UIColor clearColor];
        [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %@",cartPurchaseTotal]];
        [lblSubtotal setTextColor:[UIColor blueColor]];
        
        [self.view addSubview:lblSubtotal];
        
        UIButton *checkout = [[UIButton alloc] initWithFrame:CGRectMake(310, 830 , 180, 60)];
        
        [checkout setBackgroundImage:[UIImage imageNamed:@"checkout_btn.png"] forState:UIControlStateNormal];
        
        [checkout addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:checkout];
        
        [checkout release];
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
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,80,320,25)];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"View My Cart"];
        [self.view addSubview:titleLabel];
        
        int price;
        int cart;
        int purchase=0;
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        for (int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
            
            NSString *cartPrice=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"ListPrice"];
            NSString *cartCount=[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"];
            
            price = [cartPrice intValue];
            
            cart = [cartCount intValue];
            
            purchase = purchase + ([cartPrice intValue] * [cartCount intValue]);
            
            
        }
        
        UIImageView    *subTotalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 296, 320, 40)];
        
        [subTotalView setImage:[UIImage imageNamed:@"subtotal_bg.png"]];
        
        [self.view addSubview:subTotalView];
        
        [subTotalView release];
        lblSubtotal = [[UILabel alloc] initWithFrame:CGRectMake(210, 310 , 120, 20)];
        [lblSubtotal setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        lblSubtotal.backgroundColor = [UIColor clearColor];
        [lblSubtotal setText:[NSString stringWithFormat:@"Subtotal:$ %@",cartPurchaseTotal]];
        [lblSubtotal setTextColor:[UIColor blueColor]];
        
        [self.view addSubview:lblSubtotal];
        
        UIButton *checkout = [[UIButton alloc] initWithFrame:CGRectMake(110, 350 , 90, 30)];
        
        [checkout setBackgroundImage:[UIImage imageNamed:@"checkout_btn.png"] forState:UIControlStateNormal];
        
        [checkout addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:checkout];
        
        [checkout release];
    }
	
    
}


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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [viewCartTable reloadData];
}
-(void)viewAction:()sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        CheckOutViewController  *checkViewCartController = [[CheckOutViewController alloc] initWithNibName:@"ViewCartController-iPad" bundle:nil];
        checkViewCartController.checkTotalPrice =[NSString stringWithFormat:@"%@",cartPurchaseTotal];
        self.checkCartController = checkViewCartController;
        
        [self.view addSubview:checkCartController.view];
        
        [checkViewCartController release];
    }
    else {
        
        CheckOutViewController  *checkViewCartController = [[CheckOutViewController alloc] initWithNibName:@"ViewCartController" bundle:nil];
        checkViewCartController.checkTotalPrice =[NSString stringWithFormat:@"%@",cartPurchaseTotal];
        self.checkCartController = checkViewCartController;
        
        [self.view addSubview:checkCartController.view];
        
        [checkViewCartController release];
    }
    

    
}
-(void)goBack:(id)sender
{
    [self.view removeFromSuperview];
}
-(void) initializeTableView
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    float heightTable;
    float iPadHeightTable;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        if ([assetsData.arrayAddtoCart count] == 1)
        {
            
            iPadHeightTable = 200;
        }
            else {
                iPadHeightTable = 380;
            }
        viewCartTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, 768, iPadHeightTable) style:UITableViewStyleGrouped];
        viewCartTable.dataSource = self;
        viewCartTable.delegate = self;
        viewCartTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [self.view addSubview:viewCartTable];
    }
    else {
        if ([assetsData.arrayAddtoCart count] == 1)
        {
            
            heightTable = 100;
        }
        else {
            heightTable = 190;
        }
        viewCartTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 320, heightTable) style:UITableViewStyleGrouped];
        viewCartTable.dataSource = self;
        viewCartTable.delegate = self;
        viewCartTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [self.view addSubview:viewCartTable];
    }
	
    
}
#pragma mark TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    return [assetsData.arrayAddtoCart count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        return 50;
    }
    else {
        
        return 25;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;       
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"ViewCell";
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
    if ((cell == nil) ||(cell != nil)) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        Quantity=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 250, 30)];
        [Quantity setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        Quantity.backgroundColor = [UIColor clearColor];
        [Quantity setTextColor:[UIColor whiteColor]];
        
        
        Product=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 620, 30)];
        [Product setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        Product.backgroundColor = [UIColor clearColor];
        [Product setTextColor:[UIColor whiteColor]];
        
        PriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 110, 30)];
        [PriceLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        PriceLabel.backgroundColor = [UIColor clearColor];
        [PriceLabel setTextColor:[UIColor whiteColor]];
        [PriceLabel setText:@"\tPrice      :"];
        
        Price=[[UILabel alloc]initWithFrame:CGRectMake(PriceLabel.frame.size.width , 10, 240, 30)];
        [Price setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        Price.backgroundColor = [UIColor clearColor];
        [Price setTextColor:[UIColor yellowColor]];
        
    }
        if(indexPath.row == 0) {
            
            Product.text = [NSString stringWithFormat:@"\tProduct  : %@",[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Name"]];
            [cell.contentView addSubview:Product];
            
        }
        if(indexPath.row == 1) {
            
            Quantity.text =[NSString stringWithFormat: @"\tQuantity : %@",[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Count"]];
            [cell.contentView addSubview:Quantity];
            
        }
        if(indexPath.row == 2) {
            
            NSString *strPrice=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"ListPrice"];
            NSString *strCount=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Count"];
            int total = [strPrice intValue];
            int sum =  [strCount intValue];
            int subtotal;
            
            subtotal = (sum * total);
            
            Price.text = [NSString stringWithFormat:@" $%@",strPrice];
            [cell.contentView addSubview:Price];
            [cell.contentView addSubview:PriceLabel];
        }
        
    return  cell;
    }
    else {
        
        if ((cell == nil) ||(cell != nil)) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            Quantity=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 150, 20)];
            [Quantity setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            Quantity.backgroundColor = [UIColor clearColor];
            [Quantity setTextColor:[UIColor whiteColor]];
            
            
            Product=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 310, 20)];
            [Product setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            Product.backgroundColor = [UIColor clearColor];
            [Product setTextColor:[UIColor whiteColor]];
            
            PriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 60, 20)];
            [PriceLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            PriceLabel.backgroundColor = [UIColor clearColor];
            [PriceLabel setTextColor:[UIColor whiteColor]];
            [PriceLabel setText:@"\tPrice      :"];
            
            Price=[[UILabel alloc]initWithFrame:CGRectMake(PriceLabel.frame.size.width , 5, 150, 20)];
            [Price setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            Price.backgroundColor = [UIColor clearColor];
            [Price setTextColor:[UIColor yellowColor]];
            
        }
        if(indexPath.row == 0) {
            
            Product.text = [NSString stringWithFormat:@"\tProduct  : %@",[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Name"]];
            [cell.contentView addSubview:Product];
            
        }
        if(indexPath.row == 1) {
            
            Quantity.text =[NSString stringWithFormat: @"\tQuantity : %@",[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Count"]];
            [cell.contentView addSubview:Quantity];
            
        }
        if(indexPath.row == 2) {
            
            NSString *strPrice=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"ListPrice"];
            NSString *strCount=[[assetsData.arrayAddtoCart objectAtIndex:indexPath.section]objectForKey:@"Count"];
            int total = [strPrice intValue];
            int sum =  [strCount intValue];
            int subtotal;
            
            subtotal = (sum * total);
            
            Price.text = [NSString stringWithFormat:@" $%@",strPrice];
            [cell.contentView addSubview:Price];
            [cell.contentView addSubview:PriceLabel];
        }
        
        return  cell;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
}


- (void)dealloc {
    [super dealloc];
    [viewCartTable release];
    [Quantity release];
    [Price release];
    [Product release];
    [PriceLabel release];
    [checkCartController release];
    
}


@end
