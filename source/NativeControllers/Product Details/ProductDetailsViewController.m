//
//  ProductDetailsViewController.m
//  Phresco
//
//  Created by photon on 11/11/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "Constants.h"
#import "AddToBagViewController.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "AddtoBagCustomCell.h"
#import "ReviewViewController.h"
#import "Tabbar.h"

#define NUMBER_OF_RATINGS	5

@implementation ProductDetailsViewController

@synthesize scrollView;
@synthesize addToBagController;
@synthesize reviewViewController;
@synthesize loginChk;
@synthesize index;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"ProductDetailsViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"ProductDetailsViewController" bundle:nil];
        
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
	
	[self initializeProductImageView];
	
	[self initializeProductDescription];
	
	[self setProductDetail];
}

-(void) loadNavigationBar
{
	//add scroll view
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 935)];
        scrollView.pagingEnabled = YES;
        
        scrollView.contentSize = CGSizeMake(768, 1200);
        
        [self.view addSubview:scrollView];
        
        UIImageView *navBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 90)];
        
        [navBarView setImage:[UIImage imageNamed:@"header_logo-72.png"]];
        
        [scrollView addSubview:navBarView];
        
        [navBarView release];
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91, 768, 935)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [scrollView addSubview:bgView];
        
        [bgView release];
        
        UIButton *backButton = [[UIButton alloc] init];
        
        [backButton setFrame:CGRectMake(5, 15, 123, 60)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn-72.png"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:backButton];
        
        [backButton release];
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91 , 768, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [scrollView addSubview:searchBarView];
        
        [searchBarView release];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        UILabel *productTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 93, 550, 60)];
        
        productTitle.text = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productDetailName]];
        
        productTitle.backgroundColor = kColorClear;
        
        productTitle.textColor = kColorWhiteColor;
        
        productTitle.font = [UIFont fontWithName:@"Helvetica" size:24];
        
        [scrollView addSubview:productTitle];
        
        [productTitle release];
	}
    else {
        
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 415)];
	
	scrollView.pagingEnabled = YES;
	
	scrollView.contentSize = CGSizeMake(320, 600);
	
	[self.view addSubview:scrollView];
	
	UIImageView *navBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	
	[navBarView setImage:[UIImage imageNamed:@"header_logo.png"]];
	
	[scrollView addSubview:navBarView];
	
	[navBarView release];
    
    UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 320, 600)];
    
    [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
    
    [scrollView addSubview:bgView];
    
    [bgView release];
	
	UIButton *backButton = [[UIButton alloc] init];
	
	[backButton setFrame:CGRectMake(5, 5, 60, 30)];
	
	[backButton setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
	
	[backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
	
	[scrollView addSubview:backButton];
	
	[backButton release];
    
    UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 , 320, 40)];
	
	[searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
	
	[scrollView addSubview:searchBarView];
	
	[searchBarView release];
    
     AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
	UILabel *productTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 43, 200, 30)];
	
	productTitle.text = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productDetailName]];
	
	productTitle.backgroundColor = kColorClear;
	
	productTitle.textColor = kColorWhiteColor;
	
	productTitle.font = kFontHelvetica;
	
	[scrollView addSubview:productTitle];
	
	[productTitle release];
    }
}

-(void) initializeProductImageView
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *productBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 154, 768, 280)];
        
        productBgView.image = [UIImage imageNamed:@"Productdetail_bg.png"];
        
        [scrollView addSubview:productBgView];
        
        [productBgView release];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        NSURL *url = [NSURL URLWithString:[[assetsData.productDetailArray objectAtIndex:0] productDetailImageUrl]];
        
        UIImageView *productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 165, 230, 180)];
        
        productImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        [scrollView addSubview:productImageView];
        
        [productImageView release];
        
        
        int x = productImageView.frame.origin.x + productImageView.frame.size.width + 125;
        
        int y = productImageView.frame.origin.y + 25;
        
        int width = 25;
        
        int height = 25;
        
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(x,y,width,height);
            [ratingsView setImage:[UIImage imageNamed:@"white_star-72.png"]];
            x = x + 25;
            [ratingsView setTag:i];
            [scrollView  addSubview:ratingsView];
            [imageFramesArray addObject:ratingsView];
        }
        
        int xStar = productImageView.frame.origin.x + productImageView.frame.size.width + 125;
        
        NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productRatingView]];
        
        for (int i =0;i<[string intValue];i++) {
            
            starImage = [[[UIImageView alloc] initWithFrame:CGRectMake(xStar,y,width, height)] autorelease];
            
            starImage.image  = [UIImage imageNamed:@"blue_star-72.png"];
            
            [scrollView addSubview:starImage];	
            
            xStar = xStar + 25;
        }
        
        UIButton *reviewButton = [[UIButton alloc] initWithFrame:CGRectMake( 480, 155, 220, 100)];
        
       [reviewButton setImage:[UIImage imageNamed:@"review_btn-72.png"] forState:UIControlStateNormal];
       
        [scrollView addSubview:reviewButton];
        
        [reviewButton addTarget:self action:@selector(reviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside];;
        
        [reviewButton release];
        
        //add price label and price
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productImageView.frame.origin.x + productImageView.frame.size.width + 125, productImageView.frame.origin.y + 60, 140, 60)];
        
        [priceLabel setText:@"Price:"];
        
        [priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
        
        priceLabel.textColor = [UIColor colorWithHue:31.0/255.0 saturation:95.0/255.0 brightness:141.0/255.0 alpha:1.0];
        
        priceLabel.backgroundColor = kColorClear;
        
        [scrollView addSubview:priceLabel];
        
        [priceLabel release];
        
        //add price to the scroll view
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width, priceLabel.frame.origin.y, 
                                                                   180, priceLabel.frame.size.height)];
        price.text = [NSString stringWithFormat:@"$%@",[[assetsData.productDetailArray objectAtIndex:0] productDetailsPrice]];
        
        [price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
        
        price.textColor = [UIColor colorWithHue:31.0/255.0 saturation:95.0/255.0 brightness:141.0/255.0 alpha:1.0];
        
        price.backgroundColor = kColorClear;
        
        [scrollView addSubview:price];
        
        [price release];
        
        //add addtocart button to scroll view
        
        UIButton *addToCart = [[UIButton alloc] initWithFrame:CGRectMake(360, 265, 290, 100)];
        
        [addToCart setImage:[UIImage imageNamed:@"addtocart_btn-72.png"] forState:UIControlStateNormal];
        
        [addToCart addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:addToCart];
        
        [addToCart release];
    }
    else {
        
	UIImageView *productBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81, 320, 150)];
	
	productBgView.image = [UIImage imageNamed:@"Productdetail_bg.png"];
	
	[scrollView addSubview:productBgView];
	
	[productBgView release];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
    NSURL *url = [NSURL URLWithString:[[assetsData.productDetailArray objectAtIndex:0] productDetailImageUrl]];
	
	UIImageView *productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 100, 90)];
	
	productImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
	
	[scrollView addSubview:productImageView];
	
	[productImageView release];
	
	//add ratings to the view
	//Note: This logic has to be changed when integrating with the services
	
	int x = productImageView.frame.origin.x + productImageView.frame.size.width + 25;
	
	int y = productImageView.frame.origin.y + 5;
	
	int width = 15;
	
	int height = 13;
    
    NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
    for(int i = 0; i<5;i++)
    {
        UIImageView *ratingsView = [[UIImageView alloc]init];
        ratingsView.frame = CGRectMake(x,y,width,height);
        [ratingsView setImage:[UIImage imageNamed:@"white_star.png"]];
        x = x + 15;
        [ratingsView setTag:i];
        [scrollView  addSubview:ratingsView];
        [imageFramesArray addObject:ratingsView];
    }
    
    int xStar = productImageView.frame.origin.x + productImageView.frame.size.width + 25;

    NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productRatingView]];
	
     for (int i =0;i<[string intValue];i++) {
         
    starImage = [[[UIImageView alloc] initWithFrame:CGRectMake(xStar,y,width, height)] autorelease];
    
    starImage.image  = [UIImage imageNamed:@"blue_star.png"];
    
    [scrollView addSubview:starImage];	
         
    xStar = xStar + 15;
    }
    
	UIButton *reviewButton = [[UIButton alloc] initWithFrame:CGRectMake(productImageView.frame.origin.x + 200, 
																		productImageView.frame.origin.y, 60, 30)];
	
	[reviewButton setImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
	
	[scrollView addSubview:reviewButton];
    
    [reviewButton addTarget:self action:@selector(reviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside]; 
    
	[reviewButton release];
	
	//add price label and price
	UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productImageView.frame.origin.x + productImageView.frame.size.width + 25, productImageView.frame.origin.y + 25, 70, 40)];
	
	[priceLabel setText:@"Price:"];
	
	[priceLabel setFont:kFontHelveticaBoldBigger];
	
	priceLabel.textColor = [UIColor colorWithHue:31.0/255.0 saturation:95.0/255.0 brightness:141.0/255.0 alpha:1.0];
	
	priceLabel.backgroundColor = kColorClear;
	
	[scrollView addSubview:priceLabel];
	
	[priceLabel release];
	
	//add price to the scroll view
	
	UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width, priceLabel.frame.origin.y, 
																	70, priceLabel.frame.size.height)];
	price.text = [NSString stringWithFormat:@"$%@",[[assetsData.productDetailArray objectAtIndex:0] productDetailsPrice]];
	
	[price setFont:kFontHelveticaBoldBigger];
	
	price.textColor = [UIColor colorWithHue:31.0/255.0 saturation:95.0/255.0 brightness:141.0/255.0 alpha:1.0];
	
	price.backgroundColor = kColorClear;
	
	[scrollView addSubview:price];
	
	[price release];
	
	//add addtocart button to scroll view
	
	UIButton *addToCart = [[UIButton alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x, priceLabel.frame.origin.y + priceLabel.frame.size.height,
																	 priceLabel.frame.size.width + price.frame.size.width, priceLabel.frame.size.height)];
	
	[addToCart setImage:[UIImage imageNamed:@"addtocart_btn.png"] forState:UIControlStateNormal];
	
    [addToCart addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
        
    addToCart.accessibilityLabel=@"AddToCart";
	
	[self.scrollView addSubview:addToCart];
	
	[addToCart release];
    }
}

-(void) initializeProductDescription
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
	//add description background
	UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 434, 768, 230)];
	
	[descriptionBlock setImage:[UIImage imageNamed:@"descriptionblock_bg-72.png"]];
	
	[self.scrollView addSubview:descriptionBlock];
	
	[descriptionBlock release];
	
	//add description header to scroll view
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
	UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(230, 414, 260, 60)];

	[descriptionHeader setImage:[UIImage imageNamed:@"description_header-72.png"]];
	
	[self.scrollView addSubview:descriptionHeader];
	
	[descriptionHeader release];
	
	//add the description to the scroll view
	
	UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 474, 680, 150)];
	
	descriptionLabel.text = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productDescription]];
	
	descriptionLabel.numberOfLines = 5;
	
	descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
	
	descriptionLabel.backgroundColor = kColorClear;
	
	descriptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
	
	descriptionLabel.textColor = kColorWhiteColor;
	
	[self.scrollView addSubview:descriptionLabel];
	
	[descriptionLabel release];
    }
    else {
        
        UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 230, 320, 90)];
        
        [descriptionBlock setImage:[UIImage imageNamed:@"descriptionblock_bg.png"]];
        
        [self.scrollView addSubview:descriptionBlock];
        
        [descriptionBlock release];
        
        //add description header to scroll view
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(110, 220, 110, 30)];
        
        [descriptionHeader setImage:[UIImage imageNamed:@"description_header.png"]];
        
        [self.scrollView addSubview:descriptionHeader];
        
        [descriptionHeader release];
        
        //add the description to the scroll view
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 280, 60)];
        
        descriptionLabel.text = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:0] productDescription]];
        
        descriptionLabel.numberOfLines = 5;
        
        descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        descriptionLabel.backgroundColor = kColorClear;
        
        descriptionLabel.font = kFontHelveticaSmallBold;
        
        descriptionLabel.textColor = kColorWhiteColor;
        
        [self.scrollView addSubview:descriptionLabel];
        
        [descriptionLabel release];
    }
	
}


-(void) setProductDetail
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *productDetailBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 660, 768, 450)];
        
        [productDetailBg setImage:[UIImage imageNamed:@"detailblock_bg-72.png"]];
        
        [self.scrollView addSubview:productDetailBg];
        
        [productDetailBg release];
        
        //add the detail header to scroll view
        
        UIImageView *productDetailHeader = [[UIImageView alloc] initWithFrame:CGRectMake(270, 640, 210, 60)];
        
        [productDetailHeader setImage:[UIImage imageNamed:@"detail_header-72.png"]];
        
        [self.scrollView addSubview:productDetailHeader];
        
        [productDetailHeader release];
        
        //add the product detail BG with contents to scroll view
        
        UIImageView *productDetailBgContent = [[UIImageView alloc] initWithFrame:CGRectMake(10, productDetailBg.frame.origin.y + 65, 740, productDetailBg.frame.size.height)];
        
        [productDetailBgContent setImage:[UIImage imageNamed:@"Productdetail_bg2-72.png"]];
        
        [self.scrollView addSubview:productDetailBgContent];
        
        [productDetailBgContent release];
        
        //add the product description to scroll view
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        NSString *strType = [NSString stringWithFormat:@"TV TYPE:%@",[[assetsData.productDetailArray objectAtIndex:0] productTVType]];
        
        NSString *strScreen = [NSString stringWithFormat:@"Screen Size:%@",[[assetsData.productDetailArray objectAtIndex:0] productScreen]];
        
        NSString *strRatio = [NSString stringWithFormat:@"Screen Ratio:%@",[[assetsData.productDetailArray objectAtIndex:0] productRatio]];
        
        NSString *strDef = [NSString stringWithFormat:@"TV definition:%@",[[assetsData.productDetailArray objectAtIndex:0] productDefinition]];
        
        
        
        NSMutableArray *productDesc = [[NSMutableArray alloc] initWithObjects:strType, strScreen,
                                       strRatio, strDef, nil];
        
        int x = 160;
        
        int y = productDetailBg.frame.origin.y + 100;
        
        int width = 330;
        
        int height = 60;
        
        for(int i=0;i <[productDesc count];i++)
        {
            UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            [descLabel setText:[productDesc objectAtIndex:i]];
            
            descLabel.backgroundColor = kColorClear;
            
            descLabel.textColor = kColorWhiteColor;
            
            descLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
            
            [self.scrollView addSubview:descLabel];
            
            y = y + 120;
            
            [descLabel release];
        }
    }
    else {
        
        UIImageView *productDetailBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 320, 320, 200)];
        
        [productDetailBg setImage:[UIImage imageNamed:@"detailblock_bg.png"]];
        
        [self.scrollView addSubview:productDetailBg];
        
        [productDetailBg release];
        
        //add the detail header to scroll view
        
        UIImageView *productDetailHeader = [[UIImageView alloc] initWithFrame:CGRectMake(110, 310, 110, 30)];
        
        [productDetailHeader setImage:[UIImage imageNamed:@"detail_header.png"]];
        
        [self.scrollView addSubview:productDetailHeader];
        
        [productDetailHeader release];
        
        //add the product detail BG with contents to scroll view
        
        UIImageView *productDetailBgContent = [[UIImageView alloc] initWithFrame:CGRectMake(15, productDetailBg.frame.origin.y + 25, 290, productDetailBg.frame.size.height - 30)];
        
        [productDetailBgContent setImage:[UIImage imageNamed:@"Productdetail_bg2.png"]];
        
        [self.scrollView addSubview:productDetailBgContent];
        
        [productDetailBgContent release];
        
        //add the product description to scroll view
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        NSString *strType = [NSString stringWithFormat:@"TV TYPE:%@",[[assetsData.productDetailArray objectAtIndex:0] productTVType]];
        
        NSString *strScreen = [NSString stringWithFormat:@"Screen Size:%@",[[assetsData.productDetailArray objectAtIndex:0] productScreen]];
        
        NSString *strRatio = [NSString stringWithFormat:@"Screen Ratio:%@",[[assetsData.productDetailArray objectAtIndex:0] productRatio]];
        
        NSString *strDef = [NSString stringWithFormat:@"TV definition:%@",[[assetsData.productDetailArray objectAtIndex:0] productDefinition]];
        
        
        
        NSMutableArray *productDesc = [[NSMutableArray alloc] initWithObjects:strType, strScreen,
                                       strRatio, strDef, nil];
        
        int x = 100;
        
        int y = productDetailBg.frame.origin.y + 40;
        
        int width = 150;
        
        int height = 30;
        
        for(int i=0;i <[productDesc count];i++)
        {
            UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            [descLabel setText:[productDesc objectAtIndex:i]];
            
            descLabel.backgroundColor = kColorClear;
            
            descLabel.textColor = kColorWhiteColor;
            
            descLabel.font = kFontHelveticaSmallBold;
            
            [self.scrollView addSubview:descLabel];
            
            y = y + 40;
            
            [descLabel release];
        }
    }
	
}
-(void) finishedProductReviewService:(id) data
{
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
    
    ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController-iPAd" bundle:nil];
   
    self.reviewViewController = tempReviewViewController;
    
    [self.view addSubview:reviewViewController.view];
    
    [tempReviewViewController release];
    }
    else {
        
        
        if(loginChk == YES) { //When the user is logged in
        
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
       
        self.reviewViewController = tempReviewViewController;
        
         reviewViewController.loginChk = YES;
            
         reviewViewController.reviewProductId =  index;
            
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
    ServiceHandler* service = [[ServiceHandler alloc]init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    service.strId = [[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailId];
    
    [service productReviewService:self :@selector(finishedProductReviewService:)];
    
    [service release]; 
    
}

-(void) addToCart:(id) sender
{
    
if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        BOOL isCount = FALSE;
        int indexVal=0;
    
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
        AddtoBagCustomCell *cusCell = [[AddtoBagCustomCell alloc]init];
    
        NSString *strPrice = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailsPrice]];
    
        NSString *strImg = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailImageUrl]];
     
        NSString *strName = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailName]];
    
        NSString *strId = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailId]];
    
        NSString *strCount = [[NSString alloc] init];
    
            for(int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
        
                    if([strId isEqualToString:[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Id"]])
                    {
            
                        NSString *strInt = [NSString stringWithFormat:@"%@",[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"]];
                        indexVal = [strInt intValue];
                        
                        indexVal = indexVal + 1;
                        isCount = TRUE;
                        
                        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                        
                        NSDictionary *oldDict = (NSDictionary *)[assetsData.arrayAddtoCart objectAtIndex:i];
                        
                        [newDict addEntriesFromDictionary:oldDict];
                        
                        [newDict setObject:[NSString stringWithFormat:@"%d", indexVal] forKey:@"Count"];
                        
                        [assetsData.arrayAddtoCart replaceObjectAtIndex:i withObject:newDict];
                        [newDict release];
                        cusCell.delObj = [NSString stringWithFormat:@"%d", i];
                        break;
          
                        } 
                        else
                        {
                            isCount =  FALSE;
                            strCount = @"1";
          
                        }
                    }
    
                    if (isCount == TRUE) {
         
                    }
                    else {
                            int x=1;
                            strCount = [NSString stringWithFormat:@"%d",x];
                            [assetsData.dictCart setObject:strPrice forKey:@"ListPrice"];
    
                            [assetsData.dictCart setObject:strImg forKey:@"Image"];
    
                            [assetsData.dictCart setObject:strName forKey:@"Name"];
    
                            [assetsData.dictCart setObject:strId forKey:@"Id"]; 
    
                            [assetsData.dictCart setObject:strCount forKey:@"Count"];
                            NSLog(@"strCount:%@ ",strCount);
                            [assetsData.arrayAddtoCart addObject:[assetsData.dictCart copy]];
                    }
            
        AddToBagViewController *tempController = [[AddToBagViewController alloc] initWithNibName:@"AddtoBagViewController-iPAd" bundle:nil];
        self.addToBagController = tempController;
        
        [self.view addSubview:addToBagController.view];
        
        [tempController release];
    }
    else {
        BOOL isCount = FALSE;
        int indexVal=0;
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        AddtoBagCustomCell *cusCell = [[AddtoBagCustomCell alloc]init];
        
        NSString *strPrice = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailsPrice]];
        
        NSString *strImg = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailImageUrl]];
        
        NSString *strName = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailName]];
        
        NSString *strId = [NSString stringWithFormat:@"%@",[[assetsData.productDetailArray objectAtIndex:[sender tag]] productDetailId]];
        NSString *strCount = [[NSString alloc] init];
        
        for(int i=0; i<[assetsData.arrayAddtoCart count]; i++) {
           
            if([strId isEqualToString:[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Id"]])
            {
                NSString *strInt = [NSString stringWithFormat:@"%@",[[assetsData.arrayAddtoCart objectAtIndex:i]objectForKey:@"Count"]];
                indexVal = [strInt intValue];
                
                indexVal = indexVal + 1;
                isCount = TRUE;
                
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                
                NSDictionary *oldDict = (NSDictionary *)[assetsData.arrayAddtoCart objectAtIndex:i];
                
                [newDict addEntriesFromDictionary:oldDict];
                
                [newDict setObject:[NSString stringWithFormat:@"%d", indexVal] forKey:@"Count"];
                
                [assetsData.arrayAddtoCart replaceObjectAtIndex:i withObject:newDict];
                [newDict release];
                cusCell.delObj = [NSString stringWithFormat:@"%d", i];
                break;
                
            } else
            {
                isCount =  FALSE;
                strCount = @"1";
                
            }
        }
        
        if (isCount == TRUE) {
            
        }
        else {
            int x=1;
            strCount = [NSString stringWithFormat:@"%d",x];
            [assetsData.dictCart setObject:strPrice forKey:@"ListPrice"];
            
            [assetsData.dictCart setObject:strImg forKey:@"Image"];
            
            [assetsData.dictCart setObject:strName forKey:@"Name"];
            
            [assetsData.dictCart setObject:strId forKey:@"Id"]; 
            
            [assetsData.dictCart setObject:strCount forKey:@"Count"];
            [assetsData.arrayAddtoCart addObject:[assetsData.dictCart copy]];
        }
        
        AddToBagViewController *tempController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
        self.addToBagController = tempController;
        
        [self.view addSubview:addToBagController.view];
        
        [tempController release];
    }
    
}


-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    assetsData.productDetailArray = [[NSMutableArray alloc] init];
    
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
	
	[addToBagController release];
	
    [super dealloc];
}


@end
