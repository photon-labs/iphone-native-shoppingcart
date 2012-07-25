//
//  CheckOutViewController.m
//  Phresco
//
//  Created by photon on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckOutViewController.h"
#import "AsyncImageView.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "DTCustomColoredAccessory.h"
#import "CheckOutOVerallViewController.h"
#import "BrowseViewController.h"
#import "ServiceHandler.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"

#define kSavedField 16;
#define kFirstNameField  18;
#define kLastNameField 19;
#define kCompanyField  20;
#define kAddressField 21;
#define kAddressLineField  22;
#define kCityField 23;
#define kStateField  24;
#define kCountryField 26;
#define kPostCodeField  28;
#define kPhoneNumberField 29;



@implementation CheckOutViewController

@synthesize addToBagTable;
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize overallViewController;
@synthesize arraySaved;
@synthesize arrayState;
@synthesize arrayCountry;
@synthesize txtFirst;
@synthesize browseViewController;
@synthesize checkTotalPrice;
@synthesize specialOffersViewController;
@synthesize countryName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
    
    arraySaved = [[NSMutableArray alloc] init];
    [arraySaved addObject:@" Address 1 "];
    [arraySaved addObject:@" Address 2 "];
    [arraySaved addObject:@" Address 3 "];
    [arraySaved addObject:@" Address 4 "];
    [arraySaved addObject:@" Address 5 "];
    
    arrayState = [[NSMutableArray alloc] init];
    
    statesIndia = [[NSMutableArray alloc] init];
    
    arrayCountry = [[NSMutableArray alloc] init];
    [arrayCountry addObject:@"USA"];
    [arrayCountry addObject:@"INDIA"];
    
    countryName = [arrayCountry objectAtIndex:[pickerView selectedRowInComponent:0]];
    
    if([countryName isEqualToString:@"USA"])
    {
        
        [arrayState addObject:@"AL"];
        [arrayState addObject:@"AK"];
        [arrayState addObject:@"AZ"];
        [arrayState addObject:@"AR"];
        [arrayState addObject:@"CA"];
        [arrayState addObject:@"CO"];
        [arrayState addObject:@"CT"];
        [arrayState addObject:@"DE"];
        [arrayState addObject:@"FL"];
        [arrayState addObject:@"GA"];
        [arrayState addObject:@"HI"];
        [arrayState addObject:@"ID"];
        [arrayState addObject:@"IL"];
        [arrayState addObject:@"IN"];
        [arrayState addObject:@"IA"];
        [arrayState addObject:@"KS"];
        [arrayState addObject:@"KY"];
        [arrayState addObject:@"LA"];
        [arrayState addObject:@"ME"];
        [arrayState addObject:@"MD"];
        [arrayState addObject:@"MA"];
        [arrayState addObject:@"MI"];
        [arrayState addObject:@"MN"];
        [arrayState addObject:@"MS"];
        [arrayState addObject:@"MO"];
        [arrayState addObject:@"MT"];
        [arrayState addObject:@"NE"];
        [arrayState addObject:@"NV"];
        [arrayState addObject:@"NH"];
        [arrayState addObject:@"NJ"];
        [arrayState addObject:@"NM"];
        [arrayState addObject:@"NY"];
        [arrayState addObject:@"NC"];
        [arrayState addObject:@"ND"];
        [arrayState addObject:@"OH"];
        [arrayState addObject:@"OK"];
        [arrayState addObject:@"OR"];
        [arrayState addObject:@"PA"];
        [arrayState addObject:@"RI"];
        [arrayState addObject:@"SC"];
        [arrayState addObject:@"SD"];
        [arrayState addObject:@"TN"];
        [arrayState addObject:@"TX"];
        [arrayState addObject:@"UT"];
        [arrayState addObject:@"VT"];
        [arrayState addObject:@"VA"];
        [arrayState addObject:@"WA"];
        [arrayState addObject:@"WV"];
        [arrayState addObject:@"WI"];
        [arrayState addObject:@"WY"];
    }
    else    {
        
        [arrayState addObject:@"Andhra Pradesh"];
        [arrayState addObject:@"Arunachal Pradesh"];
        [arrayState addObject:@"Assam"];
        [arrayState addObject:@"Bihar"];
        [arrayState addObject:@"Chhattisgarh"];
        [arrayState addObject:@"Goa"];
        [arrayState addObject:@"Gujarat"];
        [arrayState addObject:@"Haryana"];
        [arrayState addObject:@"Himachal Pradesh"];
        [arrayState addObject:@"Jammu and Kashmir"];
        [arrayState addObject:@"Jharkhand"];
        [arrayState addObject:@"Karnataka"];
        [arrayState addObject:@"Kerala"];
        [arrayState addObject:@"Madhya Pradesh"];
        [arrayState addObject:@"Maharashtra"];
        [arrayState addObject:@"Manipur"];
        [arrayState addObject:@"Meghalaya"];
        [arrayState addObject:@"Mizoram"];
        [arrayState addObject:@"Nagaland"];
        [arrayState addObject:@"Orissa"];
        [arrayState addObject:@"Punjab"];
        [arrayState addObject:@"Rajasthan"];
        [arrayState addObject:@"Sikkim"];
        [arrayState addObject:@"Tamil Nadu"];
        [arrayState addObject:@"Tripura"];
        [arrayState addObject:@"Uttar Pradesh"];
        [arrayState addObject:@"Uttarakhand"];
        [arrayState addObject:@"West Bengal"];
        [arrayState addObject:@"Andaman and Nicobar Islands"];
        [arrayState addObject:@"Chandigarh"];
        [arrayState addObject:@"Dadra and Nagar Haveli"];
        [arrayState addObject:@"Daman and Diu"];
        [arrayState addObject:@"Lakshadweep"];
        [arrayState addObject:@"Delhi"];
        [arrayState addObject:@"Pondicherry"];
        
        
    }
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        CGRect pickerFrame = CGRectMake(0, 40, 0, 162);
        
        pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        
        [pickerView selectRow:1 inComponent:0 animated:NO];
        
        [actionSheet addSubview:pickerView];
        
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
        closeButton.momentary = YES; 
        closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blackColor];
        [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
        [actionSheet addSubview:closeButton];
        [closeButton release];
    }
    else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        CGRect pickerFrame = CGRectMake(0, 40, 0, 162);
        
        pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        
        [pickerView selectRow:1 inComponent:0 animated:NO];
        
        [actionSheet addSubview:pickerView];
        
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
        closeButton.momentary = YES; 
        closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blackColor];
        [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
        [actionSheet addSubview:closeButton];
        [closeButton release];
    }
    
    strConcat = [[NSMutableString alloc]init];
    
    strInfo = @"Order Information will be sent to your A/C Email list below.Email address:";
    
    strEmail = @"jack@gmail.com";
    
    [strConcat appendString:strInfo];
    [strConcat appendString:strEmail];
    
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
        
        [backButton setFrame:CGRectMake(5, 15, 123, 60)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn-72.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backButton];
        
        [backButton release];
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 92 , 768, 60)];
        
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
            
            if(i==0)
            {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            [button release];       
            
        }
        
        UILabel *myCartView = [[UILabel alloc] initWithFrame:CGRectMake(300, 150 , 180, 40)];
        
        [myCartView setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        myCartView.backgroundColor = [UIColor clearColor];
        [myCartView setText:@"Check Out"];
        [myCartView setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:myCartView];
        
        [myCartView release];
        
        
        
        UIButton *reviewCart = [[UIButton alloc] initWithFrame:CGRectMake(120, 780 , 200, 44)];
        
        [reviewCart setBackgroundImage:[UIImage imageNamed:@"revieworder_btn.png"] forState:UIControlStateNormal];
        
        [reviewCart addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:reviewCart];
        
        reviewCart.accessibilityLabel = @"revieworder btn";   
        
        [reviewCart release];
        
        UIButton *cancelCart = [[UIButton alloc] initWithFrame:CGRectMake(480, 780 , 106, 44)];
        
        [cancelCart setBackgroundImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
        
        [cancelCart addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
        
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
            
            if(i==0)
            {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
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
        
        
        
        UIButton *reviewCart = [[UIButton alloc] initWithFrame:CGRectMake(70, 365 , 108, 31)];
        
        [reviewCart setBackgroundImage:[UIImage imageNamed:@"revieworder_btn.png"] forState:UIControlStateNormal];
        
        [reviewCart addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:reviewCart];
        
        [reviewCart release];
        
        UIButton *cancelCart = [[UIButton alloc] initWithFrame:CGRectMake(180, 365 , 76, 31)];
        
        [cancelCart setBackgroundImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
        
        [cancelCart addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:cancelCart];
        
        [cancelCart release];
    }
    
}

-(void) initializeTableView
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 215, 768, 550) style:UITableViewStylePlain];
    }
    else {
        addToBagTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 320, 250) style:UITableViewStylePlain];
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


-(void)reviewAction:(id)sender
{
	[self.view removeFromSuperview];
}

-(void)cancelAction:(id)sender
{
    
    //     if ((![txtFirst.text length]) || (![txtAdd1.text length]) || (![txtAdd2.text length]) || (![txtCity.text length]) || (![txtState.text length]) || (![txtCountry.text length]) || (![txtPost.text length]) || (![txtOrder.text length])){
    //     
    //         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter all Required Values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //         [alert show];
    //         [alert release];
    //     }
    //     else {
    CheckOutOVerallViewController  *checkOutController = [[CheckOutOVerallViewController alloc] initWithNibName:@"CheckOutOVerallViewController" bundle:nil];
    checkOutController.strFirst = txtFirst.text;
    checkOutController.strLast = txtLast.text;
    checkOutController.strComp = txtComp.text;
    checkOutController.strAddr1 = txtAdd1.text;
    checkOutController.strAddr2 = txtAdd2.text;
    checkOutController.strCity = txtCity.text;
    checkOutController.strState = txtState.text;
    checkOutController.strCountry = txtCountry.text;
    checkOutController.strZip = txtPost.text;
    checkOutController.strPhone = txtPhone.text;
    checkOutController.strOrderComments = txtOrder.text;
    checkOutController.stringTotalPrice = checkTotalPrice;
    checkOutController.strEmailId = [NSString stringWithFormat:@"%@",strEmail];
    self.overallViewController = checkOutController;
    
    [self.view addSubview:overallViewController.view];
    [checkOutController release];
    // }
    
    
    
    
}

-(void) editButtonClicked:(id)sender
{
    viewController_ = [[UIView alloc] init];    
    viewController_.frame = CGRectMake(20, 150, 390, 120);
    
    txtLabel = [[UITextField alloc] init];
    txtLabel.text = strEmail;
    txtLabel.tag = 101;
    txtLabel.frame = CGRectMake(20, 30, 250, 20);
    txtLabel.textColor =[UIColor blackColor];
    txtLabel.backgroundColor = [UIColor whiteColor];
    txtLabel.adjustsFontSizeToFitWidth = YES;
    [txtLabel setDelegate:self];
    txtLabel.font = [UIFont fontWithName:@"Times New Roman-Regular" size:12];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage : 
                                [UIImage imageNamed :@"popup_bg.png"]];
    [viewController_ addSubview:myImageView];
    [viewController_ addSubview:txtLabel];
    [self.view addSubview:viewController_];
    
    UIButton *okButton = [[UIButton alloc] init];
    
    [okButton setFrame:CGRectMake(120, 80, 50, 30)];
    
    [okButton setBackgroundImage:[UIImage imageNamed:@"ok_btn.png"] forState:UIControlStateNormal];
    
    [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewController_ addSubview:okButton];
    
    UIButton *closeButton = [[UIButton alloc] init];
    
    [closeButton setFrame:CGRectMake(260, 0, 30, 30)];
    
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(closeButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewController_ addSubview:closeButton];
    
    [okButton release];   
    [closeButton release];
}

- (void)okButtonSelected:(id)sender
{
    strConcat = [[NSMutableString alloc]init];
    strEmail = txtLabel.text;
    [strConcat appendString:strInfo];
    [strConcat appendString:strEmail];
    [addToBagTable reloadData];
}


- (void)closeButtonSelected:(id)sender
{
    strConcat = [[NSMutableString alloc]init];
    strEmail = txtLabel.text;
    [strConcat appendString:strInfo];
    [strConcat appendString:strEmail];
    [addToBagTable reloadData];
    [viewController_ removeFromSuperview];
    
}

-(void) editIndex:(id)sender
{
    
    [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"checked_bok.png"] forState:UIControlStateNormal];
    txtBillSaved.text = txtSaved.text;
    txtBillFirst.text=txtFirst.text;
    txtBillLast.text = txtLast.text;
    txtBillComp.text=txtComp.text;
    txtBillAdd1.text = txtAdd1.text;
    txtBillAdd2.text=txtAdd2.text;
    txtBillCity.text = txtCity.text;
    txtBillState.text=txtState.text;
    txtBillCountry.text = txtCountry.text;
    txtBillPost.text=txtPost.text;
    txtBillPhone.text = txtPhone.text;
    
}

-(void) chequeIndex:(id)sender
{
    [cheqBtn setBackgroundImage:[UIImage imageNamed:@"radio_btn_checked.png"] forState:UIControlStateNormal];
    [cashBtn setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
}


-(void) cashIndex:(id)sender
{
    [cashBtn setBackgroundImage:[UIImage imageNamed:@"radio_btn_checked.png"] forState:UIControlStateNormal];
    [cheqBtn setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
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

#pragma mark Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case 16:
            txtSaved.text = textField.text;
            break;
        case 18:
            txtFirst.text = textField.text; 
            break;
        case 19:
            txtLast.text = textField.text;
            
            break;
        case 20:
            txtComp.text = textField.text; 
            
            break;
        case 21:
            txtAdd1.text = textField.text;
            
            break;
        case 22:
            txtAdd2.text = textField.text; 
            
            break;
        case 23:
            txtCity.text = textField.text;
            
            break;
        case 24:
            txtState.text = textField.text; 
            
            break;
        case 26:
            txtCountry.text = textField.text;
            
            break;
        case 28:
            txtPost.text = textField.text; 
            
            break;
        case 29:
            txtPhone.text = textField.text;
            
            break;
            
        case 101:
            strEmail = textField.text;
            
            break;
            
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    txtOrder.text = textView.text;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    txtOrder.text = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    txtOrder.text = textView.text;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    txtOrder.text = textView.text;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    txtOrder.text = textView.text;
    return YES;
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    txtOrder.text = textView.text;
}

-(IBAction) savedAction:(id)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        mySelection = 1;
        
        [pickerView reloadAllComponents];
        
        mlabel.text= [arraySaved objectAtIndex:[pickerView selectedRowInComponent:0]]; 
        
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        
        [actionSheet setBounds:CGRectMake(0, 0, 768, 700)];
    }
    else {
        
        mySelection = 1;
        
        [pickerView reloadAllComponents];
        
        mlabel.text= [arraySaved objectAtIndex:[pickerView selectedRowInComponent:0]]; 
        
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        
        [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    }
    
}
-(void) countryAction:(id)sender
{
    mySelection = 2;
    
    [pickerView reloadAllComponents];
    
    mlabel.text = [arrayCountry objectAtIndex:[pickerView selectedRowInComponent:0]]; 
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    
}

-(void)countrySelected
{
    arrayState = [[NSMutableArray alloc] init];
    
    if([countryName isEqualToString:@"USA"])
    {
        
        [arrayState addObject:@"AL"];
        [arrayState addObject:@"AK"];
        [arrayState addObject:@"AZ"];
        [arrayState addObject:@"AR"];
        [arrayState addObject:@"CA"];
        [arrayState addObject:@"CO"];
        [arrayState addObject:@"CT"];
        [arrayState addObject:@"DE"];
        [arrayState addObject:@"FL"];
        [arrayState addObject:@"GA"];
        [arrayState addObject:@"HI"];
        [arrayState addObject:@"ID"];
        [arrayState addObject:@"IL"];
        [arrayState addObject:@"IN"];
        [arrayState addObject:@"IA"];
        [arrayState addObject:@"KS"];
        [arrayState addObject:@"KY"];
        [arrayState addObject:@"LA"];
        [arrayState addObject:@"ME"];
        [arrayState addObject:@"MD"];
        [arrayState addObject:@"MA"];
        [arrayState addObject:@"MI"];
        [arrayState addObject:@"MN"];
        [arrayState addObject:@"MS"];
        [arrayState addObject:@"MO"];
        [arrayState addObject:@"MT"];
        [arrayState addObject:@"NE"];
        [arrayState addObject:@"NV"];
        [arrayState addObject:@"NH"];
        [arrayState addObject:@"NJ"];
        [arrayState addObject:@"NM"];
        [arrayState addObject:@"NY"];
        [arrayState addObject:@"NC"];
        [arrayState addObject:@"ND"];
        [arrayState addObject:@"OH"];
        [arrayState addObject:@"OK"];
        [arrayState addObject:@"OR"];
        [arrayState addObject:@"PA"];
        [arrayState addObject:@"RI"];
        [arrayState addObject:@"SC"];
        [arrayState addObject:@"SD"];
        [arrayState addObject:@"TN"];
        [arrayState addObject:@"TX"];
        [arrayState addObject:@"UT"];
        [arrayState addObject:@"VT"];
        [arrayState addObject:@"VA"];
        [arrayState addObject:@"WA"];
        [arrayState addObject:@"WV"];
        [arrayState addObject:@"WI"];
        [arrayState addObject:@"WY"];
    }
    else    {
        
        [arrayState addObject:@"Andhra Pradesh"];
        [arrayState addObject:@"Arunachal Pradesh"];
        [arrayState addObject:@"Assam"];
        [arrayState addObject:@"Bihar"];
        [arrayState addObject:@"Chhattisgarh"];
        [arrayState addObject:@"Goa"];
        [arrayState addObject:@"Gujarat"];
        [arrayState addObject:@"Haryana"];
        [arrayState addObject:@"Himachal Pradesh"];
        [arrayState addObject:@"Jammu and Kashmir"];
        [arrayState addObject:@"Jharkhand"];
        [arrayState addObject:@"Karnataka"];
        [arrayState addObject:@"Kerala"];
        [arrayState addObject:@"Madhya Pradesh"];
        [arrayState addObject:@"Maharashtra"];
        [arrayState addObject:@"Manipur"];
        [arrayState addObject:@"Meghalaya"];
        [arrayState addObject:@"Mizoram"];
        [arrayState addObject:@"Nagaland"];
        [arrayState addObject:@"Orissa"];
        [arrayState addObject:@"Punjab"];
        [arrayState addObject:@"Rajasthan"];
        [arrayState addObject:@"Sikkim"];
        [arrayState addObject:@"Tamil Nadu"];
        [arrayState addObject:@"Tripura"];
        [arrayState addObject:@"Uttar Pradesh"];
        [arrayState addObject:@"Uttarakhand"];
        [arrayState addObject:@"West Bengal"];
        [arrayState addObject:@"Andaman and Nicobar Islands"];
        [arrayState addObject:@"Chandigarh"];
        [arrayState addObject:@"Dadra and Nagar Haveli"];
        [arrayState addObject:@"Daman and Diu"];
        [arrayState addObject:@"Lakshadweep"];
        [arrayState addObject:@"Delhi"];
        [arrayState addObject:@"Pondicherry"];
        
    }
    
    
}
-(void) stateAction:(id)sender
{
    mySelection = 3;
    
    [pickerView reloadAllComponents];
    
    mlabel.text= [arrayState objectAtIndex:[pickerView selectedRowInComponent:0]]; 
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
}


-(void) dismissActionSheet:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{ 
    if(mySelection == 1) {
        
        txtBillSaved.text = [arraySaved objectAtIndex:row];
        txtSaved.text = [arraySaved objectAtIndex:row];
        
    }
    else if (mySelection == 2) {
        
        txtCountry.text = [arrayCountry objectAtIndex:row];
        txtBillCountry.text = [arrayCountry objectAtIndex:row];
        countryName = txtCountry.text;
        [self countrySelected];
        
    }
    else {
        txtState.text = [arrayState objectAtIndex:row];
        txtBillState.text = [arrayState objectAtIndex:row];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (mySelection == 1) {
        
        return [arraySaved count];
        
    }
    else if (mySelection == 2) {
        
        return [arrayCountry count];
        
    }
    else {
        
        return  [arrayState count];
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    if (mySelection == 1) {
        
        return [arraySaved objectAtIndex:row];
        
    }
    else if (mySelection == 2) {
        return [arrayCountry objectAtIndex:row];
        
    }
    else{
        
        return [arrayState objectAtIndex:row];
        
    }
    
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
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        if (!indexPath.row)
        {
            return 100;
        } 
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            return 220;
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            return 700;
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            return 700;
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            return 400;
        }
        else 
        {
            return 420;
        }
    }
    else {
        
        if (!indexPath.row)
        {
            return 50;
        } 
        else if ((indexPath.section ==0) && (indexPath.row == 1))
        {
            return 110;
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            return 350;
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            return 350;
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            return 200;
        }
        else 
        {
            return 210;
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
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
                cell.textLabel.text = @"Customer Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"CustInfo"; 
                
            } else if (indexPath.section ==1)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
                cell.textLabel.text = @"Delivery Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"DelInfo";
            } else if (indexPath.section ==2)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
                cell.textLabel.text = @"Billing Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"BillInfo";
            } else if (indexPath.section ==3)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
                cell.textLabel.text = @"Payment Methods"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"PaytMethods";
            } else 
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
                cell.textLabel.text = @"Order Comments"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"OrderComm";
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
                
                
                UIImageView *checkoutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 220)];
                checkoutImageView.tag = 1;
                [cell.contentView addSubview:checkoutImageView];
                [checkoutImageView release];
                
                UITextView *indexTemp = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, 600, 100)];
                indexTemp.tag = 2;
                indexTemp.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:160.0/255.0 alpha:1.0];
                indexTemp.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:indexTemp];
                [indexTemp release];
                
                UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(260, 125, 121, 50)];
                btnEdit.tag = 3;
                [btnEdit setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnEdit];
                [btnEdit release];
                
                UIImageView *imgView = (UIImageView *)[cell viewWithTag:1];
                imgView.image = [UIImage imageNamed:@"descriptionblock_bg.png"];
                
                UITextView *lblIndex = (UITextView *)[cell viewWithTag:2];
                [lblIndex setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblIndex.text = @"Order Information will be sent to your A/C Email list below.Email address: jack@gmail.com";
                
                UIButton *editButton = (UIButton *)[cell viewWithTag:3];
                [editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
            }
            
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblBilling = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 460, 40)];
                lblBilling.tag = 4;
                [lblBilling setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblBilling.backgroundColor = [UIColor clearColor];
                lblBilling.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblBilling];
                [lblBilling release];
                
                UILabel *savedAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 200, 40)];
                savedAddress.tag = 5;
                [savedAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                savedAddress.backgroundColor = [UIColor clearColor];
                savedAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:savedAddress];
                [savedAddress release];
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 150, 40)];
                firstName.tag = 6;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                firstName.backgroundColor = [UIColor clearColor];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, 150, 40)];
                lastName.tag = 7;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lastName.backgroundColor = [UIColor clearColor];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 150, 40)];
                companyLabel.tag = 8;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                companyLabel.backgroundColor = [UIColor clearColor];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 265, 150, 40)];
                lblAddress.tag = 9;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblAddress.backgroundColor = [UIColor clearColor];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 150, 40)];
                lblAddrLine.tag = 10;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblAddrLine.backgroundColor = [UIColor clearColor];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 355, 150, 40)];
                cityLabel.tag = 11;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                cityLabel.backgroundColor = [UIColor clearColor];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 190, 40)];
                lblProvince.tag = 12;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblProvince.backgroundColor = [UIColor clearColor];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 445, 190, 40)];
                countryLabel.tag = 13;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                countryLabel.backgroundColor = [UIColor clearColor];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(10, 490, 150, 40)];
                lblZip.tag = 14;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblZip.backgroundColor = [UIColor clearColor];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 535, 150, 40)];
                lblNumber.tag = 15;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblNumber.backgroundColor = [UIColor clearColor];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UITextField *tfSaved = [[UITextField alloc] initWithFrame:CGRectMake(220, 85, 200, 40)];
                tfSaved.tag = kSavedField;
                [tfSaved setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfSaved setDelegate:self];
                tfSaved.backgroundColor = [UIColor whiteColor];
                tfSaved.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfSaved];
                //[tfSaved release];
                
                UIButton *btnDelSaved = [[UIButton alloc] initWithFrame:CGRectMake(420, 85, 33, 56)];
                btnDelSaved.tag = 17;
                [btnDelSaved setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnDelSaved];
                [btnDelSaved release];
                
                UITextField *tfFirstName = [[UITextField alloc] initWithFrame:CGRectMake(220, 130, 250, 40)];
                tfFirstName.tag = kFirstNameField;
                [tfFirstName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfFirstName setDelegate:self];
                tfFirstName.backgroundColor = [UIColor whiteColor];
                tfFirstName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfFirstName];
                //[tfFirstName release];
                
                UITextField *tfLastName = [[UITextField alloc] initWithFrame:CGRectMake(220, 175, 250, 40)];
                tfLastName.tag = kLastNameField;
                [tfLastName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfLastName setDelegate:self];
                tfLastName.backgroundColor = [UIColor whiteColor];
                tfLastName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfLastName];
                //[tfLastName release];
                
                UITextField *tfCompany = [[UITextField alloc] initWithFrame:CGRectMake(220, 220, 250, 40)];
                tfCompany.tag = kCompanyField;
                [tfCompany setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfCompany setDelegate:self];
                tfCompany.backgroundColor = [UIColor whiteColor];
                tfCompany.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCompany];
                //[tfCompany release];
                
                UITextField *tfAddress = [[UITextField alloc] initWithFrame:CGRectMake(220, 265, 250, 40)];
                tfAddress.tag = kAddressField;
                [tfAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfAddress setDelegate:self];
                tfAddress.backgroundColor = [UIColor whiteColor];
                tfAddress.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddress];
                //[tfAddress release];
                
                UITextField *tfAddrLine = [[UITextField alloc] initWithFrame:CGRectMake(220, 310, 250, 40)];
                tfAddrLine.tag = kAddressLineField;
                [tfAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfAddrLine setDelegate:self];
                tfAddrLine.backgroundColor = [UIColor whiteColor];
                tfAddrLine.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddrLine];
                //[tfAddrLine release];
                
                UITextField *tfCity = [[UITextField alloc] initWithFrame:CGRectMake(220, 360, 250, 40)];
                tfCity.tag = kCityField;
                [tfCity setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfCity setDelegate:self];
                tfCity.backgroundColor = [UIColor whiteColor];
                tfCity.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCity];
                //[tfCity release];
                
                UITextField *tfProvince = [[UITextField alloc] initWithFrame:CGRectMake(220, 405, 200, 40)];
                tfProvince.tag = kStateField;
                [tfProvince setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfProvince setDelegate:self];
                tfProvince.backgroundColor = [UIColor whiteColor];
                tfProvince.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfProvince];
                //[tfProvince release];
                
                UIButton *btnProvince = [[UIButton alloc] initWithFrame:CGRectMake(420, 405, 33, 56)];
                btnProvince.tag = 25;
                [btnProvince setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnProvince];
                [btnProvince release];
                
                UITextField *tfCountry = [[UITextField alloc] initWithFrame:CGRectMake(220, 450, 200, 40)];
                tfCountry.tag = kCountryField;
                [tfCountry setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfCountry setDelegate:self];
                tfCountry.backgroundColor = [UIColor whiteColor];
                tfCountry.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCountry];
                //[tfCountry release];
                
                UIButton *btnCountry = [[UIButton alloc] initWithFrame:CGRectMake(420, 450, 33, 56)];
                btnCountry.tag = 27;
                [btnCountry setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnCountry];
                [btnCountry release];
                
                UITextField *tfZip = [[UITextField alloc] initWithFrame:CGRectMake(220, 495, 250, 40)];
                tfZip.tag =kPostCodeField;
                [tfZip setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfZip setDelegate:self];
                tfZip.backgroundColor = [UIColor whiteColor];
                tfZip.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfZip];
                //[tfZip release];
                
                UITextField *tfNumber = [[UITextField alloc] initWithFrame:CGRectMake(220, 540, 250, 40)];
                tfNumber.tag = kPhoneNumberField;
                [tfNumber setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                [tfNumber setDelegate:self];
                tfNumber.backgroundColor = [UIColor whiteColor];
                tfNumber.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfNumber];
                //[tfNumber release];
                
                
                UILabel *billLabel = (UILabel *)[cell viewWithTag:4];
                billLabel.text = @"Enter your Delivery address and Information here";
                
                UILabel *lblSaved = (UILabel *)[cell viewWithTag:5];
                lblSaved.text = @"Saved address";
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:6];
                lblFirst.text = @"first name";
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:7];
                lblLast.text = @"Last name";
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:8];
                lblComp.text = @"company";
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:9];
                lblAdd1.text = @"Address 1";
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:10];
                lblAdd2.text = @"Address 2";
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:11];
                lblCity.text = @"city";
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:12];
                lblCountry.text = @"Country";
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:13];
                lblState.text = @"State/Province";
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:14];
                lblPost.text = @"Postcode";
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:15];
                lblPhone.text = @"Phone Number";
                
                txtSaved = (UITextField *)[cell viewWithTag:16];
                [txtSaved setDelegate:self];
                txtSaved.placeholder = @"Saved address";
                
                
                UIButton *saveBtn = (UIButton *)[cell viewWithTag:17];
                [saveBtn addTarget:self action:@selector(savedAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtFirst = (UITextField *)[cell viewWithTag:18];
                [txtFirst setDelegate:self];
                txtFirst.placeholder = @"first name";
                
                txtLast = (UITextField *)[cell viewWithTag:19];
                [txtLast setDelegate:self];
                txtLast.placeholder = @"Last name";
                
                txtComp = (UITextField *)[cell viewWithTag:20];
                [txtComp setDelegate:self];
                txtComp.placeholder = @"company";
                
                txtAdd1 = (UITextField *)[cell viewWithTag:21];
                [txtAdd1 setDelegate:self];
                txtAdd1.placeholder = @"Address 1";
                
                txtAdd2 = (UITextField *)[cell viewWithTag:22];
                [txtAdd2 setDelegate:self];
                txtAdd2.placeholder = @"Address 2";
                
                txtCity = (UITextField *)[cell viewWithTag:23];
                [txtCity setDelegate:self];
                txtCity.placeholder = @"city";
                
                
                txtCountry = (UITextField *)[cell viewWithTag:24];
                [txtCountry setDelegate:self];
                txtCountry.userInteractionEnabled = NO;
                txtCountry.placeholder = @"Country";
                
                UIButton *countryBtn = (UIButton *)[cell viewWithTag:25];
                [countryBtn addTarget:self action:@selector(countryAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                txtState = (UITextField *)[cell viewWithTag:26];
                [txtState setDelegate:self];
                txtState.userInteractionEnabled = NO;
                txtState.placeholder = @"State/Province";
                
                UIButton *stateBtn = (UIButton *)[cell viewWithTag:27];
                [stateBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtPost = (UITextField *)[cell viewWithTag:28];
                [txtPost setDelegate:self];
                txtPost.placeholder = @"Postcode";
                
                txtPhone = (UITextField *)[cell viewWithTag:29];
                [txtPhone setDelegate:self];
                txtPhone.placeholder = @"Phone Number";
                
                
                
            }
            
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblEnter = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 260, 20)];
                lblEnter.tag = 30;
                [lblEnter setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblEnter.backgroundColor = [UIColor clearColor];
                lblEnter.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblEnter];
                [lblEnter release];
                
                UILabel *lblBilling = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 600, 20)];
                lblBilling.tag = 31;
                [lblBilling setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblBilling.backgroundColor = [UIColor clearColor];
                lblBilling.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblBilling];
                [lblBilling release];
                
                UIButton *btnCheck = [[UIButton alloc] initWithFrame:CGRectMake(630, 30, 31, 32)];
                btnCheck.tag = 32;
                [cell.contentView addSubview:btnCheck];
                [btnCheck release];
                
                UILabel *savedAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 200, 40)];
                savedAddress.tag = 33;
                [savedAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                savedAddress.backgroundColor = [UIColor clearColor];
                savedAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:savedAddress];
                [savedAddress release];
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 150, 40)];
                firstName.tag = 34;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                firstName.backgroundColor = [UIColor clearColor];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, 150, 40)];
                lastName.tag = 35;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lastName.backgroundColor = [UIColor clearColor];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 150, 40)];
                companyLabel.tag = 36;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                companyLabel.backgroundColor = [UIColor clearColor];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 265, 150, 40)];
                lblAddress.tag = 37;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblAddress.backgroundColor = [UIColor clearColor];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 150, 40)];
                lblAddrLine.tag = 38;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblAddrLine.backgroundColor = [UIColor clearColor];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 355, 150, 40)];
                cityLabel.tag = 39;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                cityLabel.backgroundColor = [UIColor clearColor];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 150, 40)];
                lblProvince.tag = 40;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblProvince.backgroundColor = [UIColor clearColor];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 445, 200, 40)];
                countryLabel.tag = 41;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                countryLabel.backgroundColor = [UIColor clearColor];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(10, 490, 150, 40)];
                lblZip.tag = 42;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblZip.backgroundColor = [UIColor clearColor];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 535, 150, 40)];
                lblNumber.tag = 43;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                lblNumber.backgroundColor = [UIColor clearColor];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UITextField *tfSaved = [[UITextField alloc] initWithFrame:CGRectMake(220, 85, 200, 40)];
                tfSaved.tag = 44;
                [tfSaved setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfSaved.backgroundColor = [UIColor whiteColor];
                tfSaved.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfSaved];
                //[tfSaved release];
                
                btnSaved = [[UIButton alloc] initWithFrame:CGRectMake(420, 85, 23, 26)];
                [btnSaved  viewWithTag:45];
                [btnSaved setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [btnSaved addTarget:self action:@selector(savedAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnSaved];
                
                UITextField *tfFirstName = [[UITextField alloc] initWithFrame:CGRectMake(220, 130, 250, 40)];
                tfFirstName.tag = 46;
                [tfFirstName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfFirstName.backgroundColor = [UIColor whiteColor];
                tfFirstName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfFirstName];
                //[tfFirstName release];
                
                UITextField *tfLastName = [[UITextField alloc] initWithFrame:CGRectMake(220, 175, 250, 40)];
                tfLastName.tag = 47;
                [tfLastName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfLastName.backgroundColor = [UIColor whiteColor];
                tfLastName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfLastName];
                //[tfLastName release];
                
                UITextField *tfCompany = [[UITextField alloc] initWithFrame:CGRectMake(220, 220, 250, 40)];
                tfCompany.tag = 48;
                [tfCompany setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfCompany.backgroundColor = [UIColor whiteColor];
                tfCompany.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCompany];
                //[tfCompany release];
                
                UITextField *tfAddress = [[UITextField alloc] initWithFrame:CGRectMake(220, 265, 250, 40)];
                tfAddress.tag = 49;
                [tfAddress setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfAddress.backgroundColor = [UIColor whiteColor];
                tfAddress.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddress];
                //[tfAddress release];
                
                UITextField *tfAddrLine = [[UITextField alloc] initWithFrame:CGRectMake(220, 310, 250, 40)];
                tfAddrLine.tag = 50;
                [tfAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfAddrLine.backgroundColor = [UIColor whiteColor];
                tfAddrLine.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddrLine];
                //[tfAddrLine release];
                
                UITextField *tfCity = [[UITextField alloc] initWithFrame:CGRectMake(220, 355, 250, 40)];
                tfCity.tag = 51;
                [tfCity setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfCity.backgroundColor = [UIColor whiteColor];
                tfCity.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCity];
                //[tfCity release];
                
                UITextField *tfProvince = [[UITextField alloc] initWithFrame:CGRectMake(220, 400, 200, 40)];
                tfProvince.tag = 52;
                [tfProvince setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfProvince.backgroundColor = [UIColor whiteColor];
                tfProvince.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfProvince];
                //[tfProvince release];
                
                UIButton *btnProvince = [[UIButton alloc] initWithFrame:CGRectMake(420, 405, 33, 56)];
                btnProvince.tag = 53;
                [btnProvince setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnProvince];
                [btnProvince release];
                
                UITextField *tfCountry = [[UITextField alloc] initWithFrame:CGRectMake(220, 445, 200, 40)];
                tfCountry.tag = 54;
                [tfCountry setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfCountry.backgroundColor = [UIColor whiteColor];
                tfCountry.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCountry];
                //[tfCountry release];
                
                UIButton *btnCountry = [[UIButton alloc] initWithFrame:CGRectMake(420, 450, 33, 56)];
                btnCountry.tag = 55;
                [btnCountry setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnCountry];
                [btnCountry release];
                
                UITextField *tfZip = [[UITextField alloc] initWithFrame:CGRectMake(220, 500, 250, 40)];
                tfZip.tag =56;
                [tfZip setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfZip.backgroundColor = [UIColor whiteColor];
                tfZip.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfZip];
                //[tfZip release];
                
                UITextField *tfNumber = [[UITextField alloc] initWithFrame:CGRectMake(220, 545, 250, 40)];
                tfNumber.tag = 57;
                [tfNumber setFont:[UIFont fontWithName:@"Helvetica" size:20]];
                tfNumber.backgroundColor = [UIColor whiteColor];
                tfNumber.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfNumber];
                //[tfNumber release];
                
                UILabel *lblInfo = (UILabel *)[cell viewWithTag:30];
                lblInfo.text = @"Enter your Billing address and Information here";
                
                UILabel *billLabel = (UILabel *)[cell viewWithTag:31];
                billLabel.text = @"My Billing information is the same as my delivery information";
                
                chekBoxBtn = (UIButton *)[cell viewWithTag:32];
                chekBoxBtn.accessibilityLabel = @"CheckButton";
                
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"checked_bok.png"] forState:UIControlStateHighlighted];
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"unchecked_bok.png"] forState:UIControlStateNormal];
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"checked_bok.png"] forState:UIControlStateSelected];
                [chekBoxBtn addTarget:self action:@selector(editIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *lblSaved = (UILabel *)[cell viewWithTag:33];
                lblSaved.text = @"Saved address";
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:34];
                lblFirst.text = @"first name";
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:35];
                lblLast.text = @"Last name";
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:36];
                lblComp.text = @"company";
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:37];
                lblAdd1.text = @"Address 1";
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:38];
                lblAdd2.text = @"Address 2";
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:39];
                lblCity.text = @"city";
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:40];
                lblCountry.text = @"Country";
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:41];
                lblState.text = @"State/Province";
                
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:42];
                lblPost.text = @"Postcode";
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:43];
                lblPhone.text = @"Phone Number";
                
                txtBillSaved = (UITextField *)[cell viewWithTag:44];
                [txtBillSaved setDelegate:self];
                txtBillSaved.text = @"Saved address";
                
                txtBillFirst = (UITextField *)[cell viewWithTag:46];
                [txtBillFirst setDelegate:self];
                txtBillFirst.placeholder = @"first name";
                
                txtBillLast = (UITextField *)[cell viewWithTag:47];
                [txtBillLast setDelegate:self];
                txtBillLast.placeholder = @"Last name";
                
                txtBillComp = (UITextField *)[cell viewWithTag:48];
                [txtBillComp setDelegate:self];
                txtBillComp.placeholder = @"company";
                
                txtBillAdd1 = (UITextField *)[cell viewWithTag:49];
                [txtBillAdd1 setDelegate:self];
                txtBillAdd1.placeholder = @"Address 1";
                
                txtBillAdd2 = (UITextField *)[cell viewWithTag:50];
                [txtBillAdd2 setDelegate:self];
                txtBillAdd2.placeholder = @"Address 2";
                
                txtBillCity = (UITextField *)[cell viewWithTag:51];
                [txtBillCity setDelegate:self];
                txtBillCity.placeholder = @"city";
                
                txtBillCountry = (UITextField *)[cell viewWithTag:52];
                [txtBillCountry setDelegate:self];
                txtBillCountry.userInteractionEnabled = NO;
                txtBillCountry.placeholder = @"Country";
                
                UIButton *countryBtn = (UIButton *)[cell viewWithTag:53];
                [countryBtn addTarget:self action:@selector(countryAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtBillState = (UITextField *)[cell viewWithTag:54];
                [txtBillState setDelegate:self];
                txtBillState.userInteractionEnabled = NO;
                txtBillState.placeholder = @"State/Province";
                
                UIButton *stateBtn = (UIButton *)[cell viewWithTag:55];
                [stateBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtBillPost = (UITextField *)[cell viewWithTag:56];
                [txtBillPost setDelegate:self];
                txtBillPost.placeholder = @"Postcode";
                
                txtBillPhone = (UITextField *)[cell viewWithTag:57];
                [txtBillPhone setDelegate:self];
                txtBillPhone.placeholder = @"Phone Number";
                
                
            }
            
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 580, 40)];
                lblComments.tag = 58;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblComments.backgroundColor = [UIColor clearColor];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(70, 50, 31, 30)];
                btnSelect.tag = 59;
                [btnSelect setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnSelect];
                [btnSelect release];
                
                UIButton *btnStatic = [[UIButton alloc] initWithFrame:CGRectMake(70, 120, 31, 30)];
                btnStatic.tag = 60;
                [btnStatic setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnStatic];
                [btnStatic release];
                
                UILabel *lblCash = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 280, 20)];
                lblCash.tag = 61;
                [lblCash setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblCash.backgroundColor = [UIColor clearColor];
                lblCash.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblCash];
                [lblCash release];
                
                UILabel *lblMO = [[UILabel alloc] initWithFrame:CGRectMake(120, 120, 280, 20)];
                lblMO.tag = 62;
                [lblMO setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblMO.backgroundColor = [UIColor clearColor];
                lblMO.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblMO];
                [lblMO release];
                
                UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(120, 160, 200, 40)];
                lblTotal.tag = 63;
                [lblTotal setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblTotal.backgroundColor = [UIColor clearColor];
                lblTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblTotal];
                [lblTotal release];
                
                UILabel *lblOrderTotal = [[UILabel alloc] initWithFrame:CGRectMake(120, 230, 200, 40)];
                lblOrderTotal.tag = 64;
                [lblOrderTotal setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblOrderTotal.backgroundColor = [UIColor clearColor];
                lblOrderTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrderTotal];
                [lblOrderTotal release];
                
                UILabel *lblStatement = [[UILabel alloc] initWithFrame:CGRectMake(80, 290, 560, 20)];
                lblStatement.tag = 65;
                [lblStatement setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblStatement.backgroundColor = [UIColor clearColor];
                lblStatement.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblStatement];
                [lblStatement release];
                
                
                UILabel *lblOne = (UILabel *)[cell viewWithTag:58];
                lblOne.text = @"Select a payment method from the following options";
                
                cheqBtn = (UIButton *)[cell viewWithTag:59];
                cheqBtn.accessibilityLabel = @"ChequeBuuton";
                [cheqBtn addTarget:self action:@selector(chequeIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                cashBtn = (UIButton *)[cell viewWithTag:60];
                cashBtn.accessibilityLabel = @"CashButton";
                [cashBtn addTarget:self action:@selector(cashIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *lblCheque = (UILabel *)[cell viewWithTag:61];
                lblCheque.text = @"Cheque or Money Order";
                
                UILabel *lblOrder = (UILabel *)[cell viewWithTag:62];
                lblOrder.text = @"Cash on delivery";
                
                UILabel *lblSub = (UILabel *)[cell viewWithTag:63];
                lblSub.text = @"Sub Total   :";
                
                UILabel *orderTotal = (UILabel *)[cell viewWithTag:64];
                orderTotal.text = @"Order Total :";
                
                UILabel *stmtLabel = (UILabel *)[cell viewWithTag:65];
                stmtLabel.text = @"Cheque should be made out to Phresco";
            }
            
        }
        else 
        {
            
            if ((cell == nil) ||(cell != nil)) {
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 500, 40)];
                lblComments.tag = 66;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblComments.backgroundColor = [UIColor clearColor];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                UILabel *lblSecond = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 400, 40)];
                lblSecond.tag = 67;
                [lblSecond setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblSecond.backgroundColor = [UIColor clearColor];
                lblSecond.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblSecond];
                [lblSecond release];
                
                UILabel *lblOrder = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 200, 40)];
                lblOrder.tag = 68;
                [lblOrder setFont:[UIFont fontWithName:@"Helvetica" size:24]];
                lblOrder.backgroundColor = [UIColor clearColor];
                lblOrder.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrder];
                [lblOrder release];
                
                UITextView *orderText = [[UITextView alloc] initWithFrame:CGRectMake(20, 180, 500, 200)];
                orderText.tag = 69;
                orderText.backgroundColor = [UIColor whiteColor];
                orderText.textColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:160.0/255.0 alpha:1.0];
                [cell.contentView addSubview:orderText];
                //[orderText release];
                
                UILabel *lblOne = (UILabel *)[cell viewWithTag:66];
                lblOne.text = @"Use this area for special Instructions or ";
                
                UILabel *lblTwo = (UILabel *)[cell viewWithTag:67];
                lblTwo.text = @"Question regards your order ";
                
                UILabel *lblView = (UILabel *)[cell viewWithTag:68];
                lblView.text = @"Order Comments";
                
                txtOrder = (UITextView *)[cell viewWithTag:69];
                [txtOrder setDelegate:self];
                txtOrder.isAccessibilityElement = YES;
                txtOrder.accessibilityLabel = @"OderTextView";
                txtOrder.text = @"Phresco products are nice and cool...";
                txtOrder.accessibilityValue = txtOrder.text; 
            }
        }
        
        return cell;
    }
    else {
        
        if (!indexPath.row)
        {
            if (indexPath.section ==0){
                // first row
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                cell.textLabel.text = @"Customer Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"CustInfo";
            } else if (indexPath.section ==1)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                cell.textLabel.text = @"Delivery Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"DelInfo";
            } else if (indexPath.section ==2)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                cell.textLabel.text = @"Billing Information"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"BillInfo";
            } else if (indexPath.section ==3)
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                cell.textLabel.text = @"Payment Methods"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"PaytMethods";
            } else 
            {
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                cell.textLabel.text = @"Order Comments"; // only top row showing
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessibilityLabel = @"OrderComm";
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
                
                
                UIImageView *checkoutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
                checkoutImageView.tag = 1;
                [cell.contentView addSubview:checkoutImageView];
                [checkoutImageView release];
                
                UITextView *indexTemp = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, 300, 50)];
                indexTemp.tag = 2;
                indexTemp.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:160.0/255.0 alpha:1.0];
                indexTemp.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:indexTemp];
                [indexTemp release];
                
                UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(130, 65, 61, 26)];
                btnEdit.tag = 3;
                [btnEdit setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnEdit];
                [btnEdit release];
                
                UIImageView *imgView = (UIImageView *)[cell viewWithTag:1];
                imgView.image = [UIImage imageNamed:@"descriptionblock_bg.png"];
                
                NSLog(@"strConcat:%@",strConcat);
                UITextView *lblIndex = (UITextView *)[cell viewWithTag:2];
                lblIndex.text = [NSString stringWithFormat:@"%@",strConcat];
                
                UIButton *editView = (UIButton *)[cell viewWithTag:3];
                [editView addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
            }
            
        }
        else if ((indexPath.section ==1) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblBilling = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 280, 20)];
                lblBilling.tag = 4;
                [lblBilling setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblBilling.backgroundColor = [UIColor clearColor];
                lblBilling.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblBilling];
                [lblBilling release];
                
                UILabel *savedAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 90, 20)];
                savedAddress.tag = 5;
                [savedAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                savedAddress.backgroundColor = [UIColor clearColor];
                savedAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:savedAddress];
                [savedAddress release];
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, 50, 20)];
                firstName.tag = 6;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                firstName.backgroundColor = [UIColor clearColor];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 50, 20)];
                lastName.tag = 7;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lastName.backgroundColor = [UIColor clearColor];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 50, 20)];
                companyLabel.tag = 8;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                companyLabel.backgroundColor = [UIColor clearColor];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 80, 20)];
                lblAddress.tag = 9;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblAddress.backgroundColor = [UIColor clearColor];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, 50, 20)];
                lblAddrLine.tag = 10;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblAddrLine.backgroundColor = [UIColor clearColor];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 50, 20)];
                cityLabel.tag = 11;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                cityLabel.backgroundColor = [UIColor clearColor];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 100, 20)];
                lblProvince.tag = 12;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblProvince.backgroundColor = [UIColor clearColor];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 100, 20)];
                countryLabel.tag = 13;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                countryLabel.backgroundColor = [UIColor clearColor];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(10, 295, 50, 20)];
                lblZip.tag = 14;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblZip.backgroundColor = [UIColor clearColor];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 80, 20)];
                lblNumber.tag = 15;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblNumber.backgroundColor = [UIColor clearColor];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UITextField *tfSaved = [[UITextField alloc] initWithFrame:CGRectMake(120, 60, 90, 20)];
                tfSaved.tag = kSavedField;
                [tfSaved setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfSaved setDelegate:self];
                tfSaved.backgroundColor = [UIColor whiteColor];
                tfSaved.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfSaved];
                //[tfSaved release];
                
                UIButton *btnDelSaved = [[UIButton alloc] initWithFrame:CGRectMake(210, 60, 23, 26)];
                btnDelSaved.tag = 17;
                [btnDelSaved setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnDelSaved];
                [btnDelSaved release];
                
                UITextField *tfFirstName = [[UITextField alloc] initWithFrame:CGRectMake(120, 88, 150, 20)];
                tfFirstName.tag = kFirstNameField;
                [tfFirstName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfFirstName setDelegate:self];
                tfFirstName.backgroundColor = [UIColor whiteColor];
                tfFirstName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfFirstName];
                //[tfFirstName release];
                
                UITextField *tfLastName = [[UITextField alloc] initWithFrame:CGRectMake(120, 111, 150, 20)];
                tfLastName.tag = kLastNameField;
                [tfLastName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfLastName setDelegate:self];
                tfLastName.backgroundColor = [UIColor whiteColor];
                tfLastName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfLastName];
                //[tfLastName release];
                
                UITextField *tfCompany = [[UITextField alloc] initWithFrame:CGRectMake(120, 135, 150, 20)];
                tfCompany.tag = kCompanyField;
                [tfCompany setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfCompany setDelegate:self];
                tfCompany.backgroundColor = [UIColor whiteColor];
                tfCompany.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCompany];
                //[tfCompany release];
                
                UITextField *tfAddress = [[UITextField alloc] initWithFrame:CGRectMake(120, 160, 150, 20)];
                tfAddress.tag = kAddressField;
                [tfAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfAddress setDelegate:self];
                tfAddress.backgroundColor = [UIColor whiteColor];
                tfAddress.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddress];
                //[tfAddress release];
                
                UITextField *tfAddrLine = [[UITextField alloc] initWithFrame:CGRectMake(120, 185, 150, 20)];
                tfAddrLine.tag = kAddressLineField;
                [tfAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfAddrLine setDelegate:self];
                tfAddrLine.backgroundColor = [UIColor whiteColor];
                tfAddrLine.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddrLine];
                //[tfAddrLine release];
                
                UITextField *tfCity = [[UITextField alloc] initWithFrame:CGRectMake(120, 210, 150, 20)];
                tfCity.tag = kCityField;
                [tfCity setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfCity setDelegate:self];
                tfCity.backgroundColor = [UIColor whiteColor];
                tfCity.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCity];
                //[tfCity release];
                
                UITextField *tfProvince = [[UITextField alloc] initWithFrame:CGRectMake(120, 235, 90, 20)];
                tfProvince.tag = kStateField;
                [tfProvince setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfProvince setDelegate:self];
                tfProvince.backgroundColor = [UIColor whiteColor];
                tfProvince.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfProvince];
                //[tfProvince release];
                
                UIButton *btnProvince = [[UIButton alloc] initWithFrame:CGRectMake(210, 235, 23, 26)];
                btnProvince.tag = 25;
                [btnProvince setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnProvince];
                [btnProvince release];
                
                UITextField *tfCountry = [[UITextField alloc] initWithFrame:CGRectMake(120, 265, 90, 20)];
                tfCountry.tag = kCountryField;
                [tfCountry setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfCountry setDelegate:self];
                tfCountry.backgroundColor = [UIColor whiteColor];
                tfCountry.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCountry];
                //[tfCountry release];
                
                UIButton *btnCountry = [[UIButton alloc] initWithFrame:CGRectMake(210, 265, 23, 26)];
                btnCountry.tag = 27;
                [btnCountry setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnCountry];
                [btnCountry release];
                
                UITextField *tfZip = [[UITextField alloc] initWithFrame:CGRectMake(120, 295, 150, 20)];
                tfZip.tag =kPostCodeField;
                [tfZip setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfZip setDelegate:self];
                tfZip.backgroundColor = [UIColor whiteColor];
                tfZip.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfZip];
                //[tfZip release];
                
                UITextField *tfNumber = [[UITextField alloc] initWithFrame:CGRectMake(120, 320, 150, 20)];
                tfNumber.tag = kPhoneNumberField;
                [tfNumber setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                [tfNumber setDelegate:self];
                tfNumber.backgroundColor = [UIColor whiteColor];
                tfNumber.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfNumber];
                //[tfNumber release];
                
                
                UILabel *billLabel = (UILabel *)[cell viewWithTag:4];
                billLabel.text = @"Enter your Delivery address and Information here";
                
                UILabel *lblSaved = (UILabel *)[cell viewWithTag:5];
                lblSaved.text = @"Saved address";
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:6];
                lblFirst.text = @"first name";
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:7];
                lblLast.text = @"Last name";
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:8];
                lblComp.text = @"company";
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:9];
                lblAdd1.text = @"Address 1";
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:10];
                lblAdd2.text = @"Address 2";
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:11];
                lblCity.text = @"city";
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:12];
                lblCountry.text = @"Country";
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:13];
                lblState.text = @"State/Province";
                
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:14];
                lblPost.text = @"Postcode";
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:15];
                lblPhone.text = @"Phone Number";
                
                txtSaved = (UITextField *)[cell viewWithTag:16];
                [txtSaved setDelegate:self];
                txtSaved.placeholder = @"Saved address";
                
                
                UIButton *saveBtn = (UIButton *)[cell viewWithTag:17];
                [saveBtn addTarget:self action:@selector(savedAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtFirst = (UITextField *)[cell viewWithTag:18];
                [txtFirst setDelegate:self];
                txtFirst.placeholder = @"first name";
                
                txtLast = (UITextField *)[cell viewWithTag:19];
                [txtLast setDelegate:self];
                txtLast.placeholder = @"Last name";
                
                txtComp = (UITextField *)[cell viewWithTag:20];
                [txtComp setDelegate:self];
                txtComp.placeholder = @"company";
                
                txtAdd1 = (UITextField *)[cell viewWithTag:21];
                [txtAdd1 setDelegate:self];
                txtAdd1.placeholder = @"Address 1";
                
                txtAdd2 = (UITextField *)[cell viewWithTag:22];
                [txtAdd2 setDelegate:self];
                txtAdd2.placeholder = @"Address 2";
                
                txtCity = (UITextField *)[cell viewWithTag:23];
                [txtCity setDelegate:self];
                txtCity.placeholder = @"city";
                
                
                txtCountry = (UITextField *)[cell viewWithTag:24];
                [txtCountry setDelegate:self];
                txtCountry.userInteractionEnabled = NO;
                txtCountry.placeholder = @"Country";
                
                UIButton *countryBtn = (UIButton *)[cell viewWithTag:25];
                [countryBtn addTarget:self action:@selector(countryAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                txtState = (UITextField *)[cell viewWithTag:26];
                [txtState setDelegate:self];
                txtState.userInteractionEnabled = NO;
                txtState.placeholder = @"State/Province";
                
                UIButton *stateBtn = (UIButton *)[cell viewWithTag:27];
                [stateBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
                
                txtPost = (UITextField *)[cell viewWithTag:28];
                [txtPost setDelegate:self];
                txtPost.placeholder = @"Postcode";
                
                txtPhone = (UITextField *)[cell viewWithTag:29];
                [txtPhone setDelegate:self];
                txtPhone.placeholder = @"Phone Number";
                
                
                
            }
            
        }
        else if ((indexPath.section ==2) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblEnter = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 260, 20)];
                lblEnter.tag = 30;
                [lblEnter setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblEnter.backgroundColor = [UIColor clearColor];
                lblEnter.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblEnter];
                [lblEnter release];
                
                UILabel *lblBilling = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 280, 20)];
                lblBilling.tag = 31;
                [lblBilling setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblBilling.backgroundColor = [UIColor clearColor];
                lblBilling.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblBilling];
                [lblBilling release];
                
                UIButton *btnCheck = [[UIButton alloc] initWithFrame:CGRectMake(290, 30, 21, 22)];
                btnCheck.tag = 32;
                [cell.contentView addSubview:btnCheck];
                [btnCheck release];
                
                UILabel *savedAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 90, 20)];
                savedAddress.tag = 33;
                [savedAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                savedAddress.backgroundColor = [UIColor clearColor];
                savedAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:savedAddress];
                [savedAddress release];
                
                UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, 50, 20)];
                firstName.tag = 34;
                [firstName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                firstName.backgroundColor = [UIColor clearColor];
                firstName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:firstName];
                [firstName release];
                
                UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 50, 20)];
                lastName.tag = 35;
                [lastName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lastName.backgroundColor = [UIColor clearColor];
                lastName.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lastName];
                [lastName release];
                
                UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 50, 20)];
                companyLabel.tag = 36;
                [companyLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                companyLabel.backgroundColor = [UIColor clearColor];
                companyLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:companyLabel];
                [companyLabel release];
                
                UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 80, 20)];
                lblAddress.tag = 37;
                [lblAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblAddress.backgroundColor = [UIColor clearColor];
                lblAddress.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddress];
                [lblAddress release];
                
                UILabel *lblAddrLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, 50, 20)];
                lblAddrLine.tag = 38;
                [lblAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblAddrLine.backgroundColor = [UIColor clearColor];
                lblAddrLine.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblAddrLine];
                [lblAddrLine release];
                
                UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 50, 20)];
                cityLabel.tag = 39;
                [cityLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                cityLabel.backgroundColor = [UIColor clearColor];
                cityLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:cityLabel];
                [cityLabel release];
                
                UILabel *lblProvince = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 100, 20)];
                lblProvince.tag = 40;
                [lblProvince setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblProvince.backgroundColor = [UIColor clearColor];
                lblProvince.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblProvince];
                [lblProvince release];
                
                UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 100, 20)];
                countryLabel.tag = 41;
                [countryLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                countryLabel.backgroundColor = [UIColor clearColor];
                countryLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:countryLabel];
                [countryLabel release];
                
                UILabel *lblZip = [[UILabel alloc] initWithFrame:CGRectMake(10, 295, 50, 20)];
                lblZip.tag = 42;
                [lblZip setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblZip.backgroundColor = [UIColor clearColor];
                lblZip.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblZip];
                [lblZip release];
                
                UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 80, 20)];
                lblNumber.tag = 43;
                [lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                lblNumber.backgroundColor = [UIColor clearColor];
                lblNumber.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblNumber];
                [lblNumber release];
                
                UITextField *tfSaved = [[UITextField alloc] initWithFrame:CGRectMake(120, 60, 90, 20)];
                tfSaved.tag = 44;
                [tfSaved setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfSaved.backgroundColor = [UIColor whiteColor];
                tfSaved.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfSaved];
                [tfSaved release];
                
                btnSaved = [[UIButton alloc] initWithFrame:CGRectMake(210, 60, 23, 26)];
                [btnSaved  viewWithTag:45];
                [btnSaved setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [btnSaved addTarget:self action:@selector(savedAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnSaved];
                
                
                UITextField *tfFirstName = [[UITextField alloc] initWithFrame:CGRectMake(120, 88, 150, 20)];
                tfFirstName.tag = 46;
                [tfFirstName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfFirstName.backgroundColor = [UIColor whiteColor];
                tfFirstName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfFirstName];
                //[tfFirstName release];
                
                UITextField *tfLastName = [[UITextField alloc] initWithFrame:CGRectMake(120, 111, 150, 20)];
                tfLastName.tag = 47;
                [tfLastName setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfLastName.backgroundColor = [UIColor whiteColor];
                tfLastName.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfLastName];
                //[tfLastName release];
                
                UITextField *tfCompany = [[UITextField alloc] initWithFrame:CGRectMake(120, 135, 150, 20)];
                tfCompany.tag = 48;
                [tfCompany setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfCompany.backgroundColor = [UIColor whiteColor];
                tfCompany.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCompany];
                //[tfCompany release];
                
                UITextField *tfAddress = [[UITextField alloc] initWithFrame:CGRectMake(120, 160, 150, 20)];
                tfAddress.tag = 49;
                [tfAddress setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfAddress.backgroundColor = [UIColor whiteColor];
                tfAddress.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddress];
                //[tfAddress release];
                
                UITextField *tfAddrLine = [[UITextField alloc] initWithFrame:CGRectMake(120, 185, 150, 20)];
                tfAddrLine.tag = 50;
                [tfAddrLine setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfAddrLine.backgroundColor = [UIColor whiteColor];
                tfAddrLine.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfAddrLine];
                //[tfAddrLine release];
                
                UITextField *tfCity = [[UITextField alloc] initWithFrame:CGRectMake(120, 210, 150, 20)];
                tfCity.tag = 51;
                [tfCity setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfCity.backgroundColor = [UIColor whiteColor];
                tfCity.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCity];
                //[tfCity release];
                
                UITextField *tfProvince = [[UITextField alloc] initWithFrame:CGRectMake(120, 235, 90, 20)];
                tfProvince.tag = 52;
                [tfProvince setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfProvince.backgroundColor = [UIColor whiteColor];
                tfProvince.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfProvince];
                //[tfProvince release];
                
                UIButton *btnProvince = [[UIButton alloc] initWithFrame:CGRectMake(210, 235, 23, 26)];
                btnProvince.tag = 53;
                [btnProvince setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnProvince];
                [btnProvince release];
                
                UITextField *tfCountry = [[UITextField alloc] initWithFrame:CGRectMake(120, 265, 90, 20)];
                tfCountry.tag = 54;
                [tfCountry setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfCountry.backgroundColor = [UIColor whiteColor];
                tfCountry.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfCountry];
                //[tfCountry release];
                
                UIButton *btnCountry = [[UIButton alloc] initWithFrame:CGRectMake(210, 265, 23, 26)];
                btnCountry.tag = 55;
                [btnCountry setBackgroundImage:[UIImage imageNamed:@"jump_btn.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnCountry];
                [btnCountry release];
                
                UITextField *tfZip = [[UITextField alloc] initWithFrame:CGRectMake(120, 295, 150, 20)];
                tfZip.tag =56;
                [tfZip setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfZip.backgroundColor = [UIColor whiteColor];
                tfZip.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfZip];
                //[tfZip release];
                
                UITextField *tfNumber = [[UITextField alloc] initWithFrame:CGRectMake(120, 320, 150, 20)];
                tfNumber.tag = 57;
                [tfNumber setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                tfNumber.backgroundColor = [UIColor whiteColor];
                tfNumber.textColor = [UIColor blackColor];
                [cell.contentView addSubview:tfNumber];
                //[tfNumber release];
                
                UILabel *lblInfo = (UILabel *)[cell viewWithTag:30];
                lblInfo.text = @"Enter your Billing address and Information here";
                
                UILabel *billLabel = (UILabel *)[cell viewWithTag:31];
                billLabel.text = @"My Billing information is the same as my delivery information";
                
                chekBoxBtn = (UIButton *)[cell viewWithTag:32];
                chekBoxBtn.accessibilityLabel = @"CheckButton";
                
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"checked_bok.png"] forState:UIControlStateHighlighted];
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"unchecked_bok.png"] forState:UIControlStateNormal];
                [chekBoxBtn setBackgroundImage:[UIImage imageNamed:@"checked_bok.png"] forState:UIControlStateSelected];
                [chekBoxBtn addTarget:self action:@selector(editIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *lblSaved = (UILabel *)[cell viewWithTag:33];
                lblSaved.text = @"Saved address";
                
                UILabel *lblFirst = (UILabel *)[cell viewWithTag:34];
                lblFirst.text = @"first name";
                
                UILabel *lblLast = (UILabel *)[cell viewWithTag:35];
                lblLast.text = @"Last name";
                
                UILabel *lblComp = (UILabel *)[cell viewWithTag:36];
                lblComp.text = @"company";
                
                UILabel *lblAdd1 = (UILabel *)[cell viewWithTag:37];
                lblAdd1.text = @"Address 1";
                
                UILabel *lblAdd2 = (UILabel *)[cell viewWithTag:38];
                lblAdd2.text = @"Address 2";
                
                UILabel *lblCity = (UILabel *)[cell viewWithTag:39];
                lblCity.text = @"city";
                
                UILabel *lblCountry = (UILabel *)[cell viewWithTag:40];
                lblCountry.text = @"Country";
                
                UILabel *lblState = (UILabel *)[cell viewWithTag:41];
                lblState.text = @"State/Province";
                
                
                UILabel *lblPost = (UILabel *)[cell viewWithTag:42];
                lblPost.text = @"Postcode";
                
                UILabel *lblPhone = (UILabel *)[cell viewWithTag:43];
                lblPhone.text = @"Phone Number";
                
                txtBillSaved = (UITextField *)[cell viewWithTag:44];
                [txtBillSaved setDelegate:self];
                txtBillSaved.text = @"Saved address";
                
                txtBillFirst = (UITextField *)[cell viewWithTag:46];
                [txtBillFirst setDelegate:self];
                txtBillFirst.placeholder = @"first name";
                
                txtBillLast = (UITextField *)[cell viewWithTag:47];
                [txtBillLast setDelegate:self];
                txtBillLast.placeholder = @"Last name";
                
                txtBillComp = (UITextField *)[cell viewWithTag:48];
                [txtBillComp setDelegate:self];
                txtBillComp.placeholder = @"company";
                
                txtBillAdd1 = (UITextField *)[cell viewWithTag:49];
                [txtBillAdd1 setDelegate:self];
                txtBillAdd1.placeholder = @"Address 1";
                
                txtBillAdd2 = (UITextField *)[cell viewWithTag:50];
                [txtBillAdd2 setDelegate:self];
                txtBillAdd2.placeholder = @"Address 2";
                
                txtBillCity = (UITextField *)[cell viewWithTag:51];
                [txtBillCity setDelegate:self];
                txtBillCity.placeholder = @"city";
                
                
                txtBillCountry = (UITextField *)[cell viewWithTag:52];
                [txtBillCountry setDelegate:self];
                txtBillCountry.userInteractionEnabled = NO;
                txtBillCountry.placeholder = @"Country";
                
                UIButton *countryBtn = (UIButton *)[cell viewWithTag:53];
                [countryBtn addTarget:self action:@selector(countryAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                txtBillState = (UITextField *)[cell viewWithTag:54];
                [txtBillState setDelegate:self];
                txtBillState.userInteractionEnabled = NO;
                txtBillState.placeholder = @"State/Province";
                
                UIButton *stateBtn = (UIButton *)[cell viewWithTag:55];
                [stateBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                txtBillPost = (UITextField *)[cell viewWithTag:56];
                [txtBillPost setDelegate:self];
                txtBillPost.placeholder = @"Postcode";
                
                txtBillPhone = (UITextField *)[cell viewWithTag:57];
                [txtBillPhone setDelegate:self];
                txtBillPhone.placeholder = @"Phone Number";
                
                
            }
            
        }
        else if ((indexPath.section ==3) && (indexPath.row == 1))
        {
            if ((cell == nil) ||(cell != nil)) {
                
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)];
                lblComments.tag = 58;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblComments.backgroundColor = [UIColor clearColor];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(40, 50, 21, 20)];
                btnSelect.tag = 59;
                [btnSelect setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnSelect];
                [btnSelect release];
                
                UIButton *btnStatic = [[UIButton alloc] initWithFrame:CGRectMake(40, 80, 21, 20)];
                btnStatic.tag = 60;
                [btnStatic setBackgroundImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:btnStatic];
                [btnStatic release];
                
                UILabel *lblCash = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 180, 20)];
                lblCash.tag = 61;
                [lblCash setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblCash.backgroundColor = [UIColor clearColor];
                lblCash.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblCash];
                [lblCash release];
                
                UILabel *lblMO = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, 180, 20)];
                lblMO.tag = 62;
                [lblMO setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblMO.backgroundColor = [UIColor clearColor];
                lblMO.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblMO];
                [lblMO release];
                
                UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, 100, 20)];
                lblTotal.tag = 63;
                [lblTotal setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblTotal.backgroundColor = [UIColor clearColor];
                lblTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblTotal];
                [lblTotal release];
                
                UILabel *lblOrderTotal = [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 100, 20)];
                lblOrderTotal.tag = 64;
                [lblOrderTotal setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblOrderTotal.backgroundColor = [UIColor clearColor];
                lblOrderTotal.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrderTotal];
                [lblOrderTotal release];
                
                UILabel *lblStatement = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, 220, 20)];
                lblStatement.tag = 65;
                [lblStatement setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblStatement.backgroundColor = [UIColor clearColor];
                lblStatement.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblStatement];
                [lblStatement release];
                
                
                UILabel *lblOne = (UILabel *)[cell viewWithTag:58];
                lblOne.text = @"Select a payment method from the following options";
                
                cheqBtn = (UIButton *)[cell viewWithTag:59];
                cheqBtn.accessibilityLabel = @"ChequeBuuton";
                [cheqBtn addTarget:self action:@selector(chequeIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                cashBtn = (UIButton *)[cell viewWithTag:60];
                cashBtn.accessibilityLabel = @"CashButton";
                [cashBtn addTarget:self action:@selector(cashIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *lblCheque = (UILabel *)[cell viewWithTag:61];
                lblCheque.text = @"Cheque or Money Order";
                
                UILabel *lblOrder = (UILabel *)[cell viewWithTag:62];
                lblOrder.text = @"Cash on delivery";
                
                UILabel *lblSub = (UILabel *)[cell viewWithTag:63];
                lblSub.text = @"Sub Total   :";
                
                UILabel *orderTotal = (UILabel *)[cell viewWithTag:64];
                orderTotal.text = @"Order Total :";
                
                UILabel *stmtLabel = (UILabel *)[cell viewWithTag:65];
                stmtLabel.text = @"Cheque should be made out to Phresco";
            }
            
        }
        else 
        {
            
            if ((cell == nil) ||(cell != nil)) {
                
                UILabel *lblComments = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 300, 20)];
                lblComments.tag = 66;
                [lblComments setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblComments.backgroundColor = [UIColor clearColor];
                lblComments.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblComments];
                [lblComments release];
                
                UILabel *lblSecond = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 200, 20)];
                lblSecond.tag = 67;
                [lblSecond setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblSecond.backgroundColor = [UIColor clearColor];
                lblSecond.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblSecond];
                [lblSecond release];
                
                UILabel *lblOrder = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
                lblOrder.tag = 68;
                [lblOrder setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                lblOrder.backgroundColor = [UIColor clearColor];
                lblOrder.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:lblOrder];
                [lblOrder release];
                
                UITextView *orderText = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, 300, 100)];
                orderText.tag = 69;
                orderText.backgroundColor = [UIColor whiteColor];
                orderText.textColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:160.0/255.0 alpha:1.0];
                [cell.contentView addSubview:orderText];
                //[orderText release];
                
                UILabel *lblOne = (UILabel *)[cell viewWithTag:66];
                lblOne.text = @"Use this area for special Instructions or ";
                
                UILabel *lblTwo = (UILabel *)[cell viewWithTag:67];
                lblTwo.text = @"Question regards your order ";
                
                UILabel *lblView = (UILabel *)[cell viewWithTag:68];
                lblView.text = @"Order Comments";
                
                txtOrder = (UITextView *)[cell viewWithTag:69];
                txtOrder.isAccessibilityElement = YES;
                txtOrder.accessibilityLabel = @"OderTextView";
                [txtOrder setDelegate:self];
                txtOrder.text = @"Phresco products are nice and cool...";
                txtOrder.accessibilityValue = txtOrder.text;
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
    
    [arrayCountry release];
    
    [arraySaved release];
    
    [arrayState release];
    
    [productImageArray release];
    
    
}



@end
