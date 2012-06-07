//
//  ReviewViewController.m
//  Phresco
//
//  Created by bharat kumar on 27/12/11.
//  Copyright (c) 2011 bharatkumar.r@gmail.com. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewCustomCell.h"
#import "AsyncImageView.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "AddToBagViewController.h"
#import "SubmitReviewViewController.h"
#import "ServiceHandler.h"
#import "SpecialOffersViewController.h"
#import "ReviewCommentsViewController.h"
#import "ProductDetailsViewController.h"
#import "Tabbar.h"
#import "LoginViewController.h"
@implementation ReviewViewController

@synthesize addToBagViewController;
@synthesize submitReviewViewController;
@synthesize specialOffersViewController;
@synthesize reviewCommentsViewController;


@synthesize reviewTableView;
@synthesize reviewTextview;
@synthesize commentArray;
@synthesize averageArray;

@synthesize oneStar;
@synthesize twoStar;
@synthesize threeStar;
@synthesize fourStar;
@synthesize fiveStar;
@synthesize average;
@synthesize submitReview;
@synthesize loginViewController;

@synthesize isSpecialOffer;
@synthesize loginChk;
@synthesize reviewProductId;
@synthesize array_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"ReviewViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"ReviewViewController" bundle:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"CustomerReview";
   
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    stringAverage = [[assetsData.productReviewArray objectAtIndex:([assetsData.productReviewArray count]-1)]averageCustomerReview];
    [assetsData.productReviewArray removeObjectAtIndex:([assetsData.productReviewArray count]-1)];
    NSLog(@"pdtDetailView:%d",[assetsData.productReviewArray  count]);
    
    array_ = [[NSMutableArray alloc] init];
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
    
    [self initializeTableView];
        
}

#pragma mark 
#pragma mark Navigation methods

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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_highlighted-72.png"], [UIImage imageNamed:@"specialoffers_btn_normal-72.png"],
                                       [UIImage imageNamed:@"mycart_btn_normal-72.png"], 
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
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            if(i==2)
            {
                [button addTarget:self action:@selector(myCartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_highlighted.png"], [UIImage imageNamed:@"offers_btn_normal.png"],
                                       [UIImage imageNamed:@"mycart_btn_normal.png"], 
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
            if(i==1)
            {
                [button addTarget:self action:@selector(specialOfferButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            if(i==2)
            {
                [button addTarget:self action:@selector(myCartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button release];
            
        }
    }
	
   	
}

-(void) initializeTableView
{
  
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;

		reviewTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 500, 768, 200) style:UITableViewStylePlain];
        reviewTableView.dataSource = self;
        reviewTableView.delegate = self;
        reviewTableView.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [self.view addSubview:reviewTableView];
        
        
        submitReview = [[UIButton alloc] init];
        submitReview =[UIButton buttonWithType:UIButtonTypeCustom];
        submitReview.frame = CGRectMake(250,785, 180,50);
        [submitReview addTarget:self action:@selector(submitReviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [submitReview setBackgroundImage:[UIImage imageNamed:@"submitreview_btn.png"] forState:UIControlStateNormal];
        
        
        [self.view addSubview:submitReview];
        
       
        for(int i = 0;i<[assetsData.productReviewArray count]; i++)
        {
            
            NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productReviewArray objectAtIndex:i] averageCustomerReview]];
//            NSLog(@"rating averageCustomerReview..... :%@",string);
            [averageArray addObject:[[assetsData.productReviewArray objectAtIndex:i] averageCustomerReview]];
        }
        
        
        reviewTextview = [[UITextView alloc] initWithFrame:CGRectMake(0, 201, 768, 290)];
        reviewTextview.delegate = self;
        reviewTextview.editable = NO;
        reviewTextview.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:reviewTextview];
        
        UILabel  *customerLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 155, 768, 50)];
        [customerLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ProductList_top-72.png"]]];
        [customerLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        [customerLabel setText:@" Customer Review"];
        customerLabel.textAlignment=UITextAlignmentCenter;
        [customerLabel setTextColor:[UIColor whiteColor]];
        [self.view addSubview:customerLabel];
        
        average = [[UILabel alloc] initWithFrame:CGRectMake(0,0,768,45)];
        [average setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        [average setTextColor:[UIColor colorWithRed:85/255 green:85/255 blue:75/255 alpha:1.0]];

        [average setText:[NSString stringWithFormat:@"  Average customer review  \t(%@)",stringAverage]];

        average.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"customerreview_subheader.png"]];
        [reviewTextview  addSubview:average];
        
        oneStar = [[UILabel alloc] initWithFrame:CGRectMake(20,200,50,30)];
        [oneStar setText:@"1 star:"];
        [oneStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:30]];
        [oneStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:oneStar];
        
        twoStar = [[UILabel alloc] initWithFrame:CGRectMake(20,165,50,30)];
        [twoStar setText:@"2 star:"];
        [twoStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:30]];
        [twoStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:twoStar];
        
        threeStar = [[UILabel alloc] initWithFrame:CGRectMake(20,130,50,30)];
        [threeStar setText:@"3 star:"];
        [threeStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:30]];
        [threeStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:threeStar];
        
        
        fourStar = [[UILabel alloc] initWithFrame:CGRectMake(20,95,50,30)];
        [fourStar setText:@"4 star:"];
        [fourStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:30]];
        [fourStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:fourStar];
        
        fiveStar = [[UILabel alloc] initWithFrame:CGRectMake(20,60,50,30)];
        [fiveStar setText:@"5 star:"];
        [fiveStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:30]];
        [fiveStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:fiveStar];
        
        
        
        float x = 110;
        
        float  y =  60;
        
        float  width = 400;
        
        float height = 25;
        NSMutableArray *imageUnPoll = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *noRatings = [[UIImageView alloc]init];
            noRatings.frame = CGRectMake(x,y,width,height);
            [noRatings setImage:[UIImage imageNamed:@"unpoll_rating.png"]];
            y = y + 35;
            [noRatings setTag:i];
            [reviewTextview  addSubview:noRatings];
            [imageUnPoll addObject:noRatings];
        }
        
        float yRate = 200;
        int yWidth;
        NSMutableArray *imagePoll = [[NSMutableArray alloc]init];
        for(int i = 0; i<[assetsData.keyValueArray  count];i++)
        {
            NSString *strValue = [[assetsData.keyValueArray objectAtIndex:i]objectForKey:@"value"];
            NSLog(@"strValue:%d",[strValue intValue]);
            yWidth = [strValue intValue]*20;
            UIImageView *myRatings = [[UIImageView alloc]init];
            myRatings.frame = CGRectMake(x,yRate,yWidth,height);
            [myRatings setImage:[UIImage imageNamed:@"poll_rating.png"]];
            yRate = yRate - 35;
            [myRatings setTag:i];
            [reviewTextview  addSubview:myRatings];
            [imagePoll addObject:myRatings];
        }

        
	}
    else {
        reviewTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 271, 320, 100) style:UITableViewStylePlain];
        reviewTableView.dataSource = self;
        reviewTableView.delegate = self;
        reviewTableView.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
        [self.view addSubview:reviewTableView];
        
        
        submitReview = [[UIButton alloc] init];
        submitReview =[UIButton buttonWithType:UIButtonTypeCustom];
        submitReview.frame = CGRectMake(110,reviewTableView.frame.origin.y + reviewTableView.frame.size.height + 5, 100,30);
        [submitReview addTarget:self action:@selector(submitReviewButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [submitReview setBackgroundImage:[UIImage imageNamed:@"submitreview_btn.png"] forState:UIControlStateNormal];
        [self.view addSubview:submitReview];
        
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        for(int i = 0;i<[assetsData.productReviewArray count]; i++)
        {
            
            NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productReviewArray objectAtIndex:i] averageCustomerReview]];
//            NSLog(@"rating averageCustomerReview..... :%@",string);
            [averageArray addObject:[[assetsData.productReviewArray objectAtIndex:i] averageCustomerReview]];
        }
        
        
        reviewTextview = [[UITextView alloc] initWithFrame:CGRectMake(0, 110, 320, 160)];
        reviewTextview.delegate = self;
        reviewTextview.editable = NO;
        reviewTextview.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:reviewTextview];
        
        UILabel* customerLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,80,320,31)];
        [customerLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"customerreview_header.png"]]];
        [customerLabel setTextColor:[UIColor whiteColor]];
        [self.view addSubview:customerLabel];
        
        average = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,25)];
        [average setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [average setTextColor:[UIColor colorWithRed:85/255 green:85/255 blue:75/255 alpha:1.0]];
        [average setText:[NSString stringWithFormat:@"  Average customer review  \t(%@)",stringAverage]];
        
        average.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"customerreview_subheader.png"]];
        [reviewTextview  addSubview:average];
        
        oneStar = [[UILabel alloc] initWithFrame:CGRectMake(10,130,50,20)];
        [oneStar setText:@"1 star:"];
        [oneStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [oneStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:oneStar];
        
        twoStar = [[UILabel alloc] initWithFrame:CGRectMake(10,105,50,20)];
        [twoStar setText:@"2 star:"];
        [twoStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [twoStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:twoStar];
        
        threeStar = [[UILabel alloc] initWithFrame:CGRectMake(10,80,50,20)];
        [threeStar setText:@"3 star:"];
        [threeStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [threeStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:threeStar];
        
        
        fourStar = [[UILabel alloc] initWithFrame:CGRectMake(10,55,50,20)];
        [fourStar setText:@"4 star:"];
        [fourStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [fourStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:fourStar];
        
        fiveStar = [[UILabel alloc] initWithFrame:CGRectMake(10,30,50,20)];
        [fiveStar setText:@"5 star:"];
        [fiveStar setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:15]];
        [fiveStar setTextColor:[UIColor blackColor]];
        [reviewTextview addSubview:fiveStar];
        
        
        float x = 70;
        
        float  y =  30;
        
        float  width = 200;
        
        float height = 15;
        NSMutableArray *imageUnPoll = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *noRatings = [[UIImageView alloc]init];
            noRatings.frame = CGRectMake(x,y,width,height);
            [noRatings setImage:[UIImage imageNamed:@"unpoll_rating.png"]];
            y = y + 25;
            [noRatings setTag:i];
            [reviewTextview  addSubview:noRatings];
            [imageUnPoll addObject:noRatings];
        }
        
        float yRate = 130;
        int yWidth; 
        NSMutableArray *imagePoll = [[NSMutableArray alloc]init];
        for(int i = 0; i<[assetsData.keyValueArray  count];i++)
        {
            NSString *strValue = [[assetsData.keyValueArray objectAtIndex:i]objectForKey:@"value"];
            yWidth = [strValue intValue]*10;
            UIImageView *myRatings = [[UIImageView alloc]init];
            myRatings.frame = CGRectMake(x,yRate,yWidth,height);
            [myRatings setImage:[UIImage imageNamed:@"poll_rating.png"]];
            yRate = yRate - 25;
            [myRatings setTag:i];
            [reviewTextview  addSubview:myRatings];
            [imagePoll addObject:myRatings];
        }


        
    }
   
 }



#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AssetsDataEntity *assestsDataOne = [SharedObjects sharedInstance].assetsDataEntity;
    return [assestsDataOne.productReviewArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        return 260;
    }
    else {
        return 130;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"ReviewCell";
    AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;

	
	ReviewCustomCell *cell = (ReviewCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
        cell = [[[ReviewCustomCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
				autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 2;
        
    }
    
    
   	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	       
    [[cell commentsLabel] setText:[[assestsData.productReviewArray objectAtIndex:indexPath.row]userComments]];
    [[cell disImage] setImage:[UIImage imageNamed:@"nav_arrow.png"]];
   
    
    NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.productReviewArray objectAtIndex:indexPath.row] productRatingView]];
    
    NSString* averageValue = [NSString stringWithFormat:@"  Average customer review  (%@)",[[assestsData.productReviewArray objectAtIndex:indexPath.row] averageCustomerReview]];
   
    
    NSString* user = [[[assestsData.productReviewArray objectAtIndex:indexPath.row] userName]description];
    
        [[cell userNameLabel] setText:user];
    
    
    NSString* date = [NSString stringWithFormat:@"%@",[[assestsData.productReviewArray objectAtIndex:indexPath.row] commentedDate]];
    
    [[cell dateLabel] setText:date];
    
    
    
    NSInteger tagValue = (NSInteger)[[assestsData.productReviewArray objectAtIndex:indexPath.row] productDetailId];
    [submitReview setTag:tagValue];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        float x = 20;
        
        float  y =  5;
        
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
        
        float xBlue = 20;
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
    }
    else {
        float x = 10;
        
        float  y =  2;
        
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
        
        float xBlue = 10;
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
    }
   
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
      
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        
        ReviewCommentsViewController *tempReviewCommentsViewController = [[ReviewCommentsViewController alloc] initWithNibName:@"ReviewCommentsViewController-iPad" bundle:nil];
        
        self.reviewCommentsViewController = tempReviewCommentsViewController;
        
        [self.view addSubview:reviewCommentsViewController.view];
        
        
        tempReviewCommentsViewController.ratingCount =[[NSString alloc] init];
        
        [tempReviewCommentsViewController.dateLabel setText:[[assetsData.productReviewArray objectAtIndex:[indexPath row]]commentedDate]];
        
        [tempReviewCommentsViewController.commentsLabel setText:[[assetsData.productReviewArray objectAtIndex:[indexPath row]]userComments]];
        
        NSString* user = [[[assetsData.productReviewArray objectAtIndex:indexPath.row] userName]description];
        [tempReviewCommentsViewController.userNameLabel setText:user];
        
        NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productReviewArray objectAtIndex:indexPath.row] productRatingView]];
        
        float xBlue = 20;
        
        float  y =  200;
        
        float  width = 40;
        
        float height = 40;
        
        
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        
        for(int i = 0; i<[string intValue];i++)
        {
            tempReviewCommentsViewController.ratingImage = [[UIImageView alloc]init];
            tempReviewCommentsViewController.ratingImage.frame = CGRectMake(xBlue,y,width,height);
            [tempReviewCommentsViewController.ratingImage setImage:[UIImage imageNamed:@"blue_star.png"]];
            xBlue = xBlue + 40;
            [tempReviewCommentsViewController.ratingImage setTag:i];
            [tempReviewCommentsViewController.view  addSubview:tempReviewCommentsViewController.ratingImage];
            [imageFramesArray addObject:tempReviewCommentsViewController.ratingImage];
        }
        
        [tempReviewCommentsViewController release];

    }
    else {
        
        
        ReviewCommentsViewController *tempReviewCommentsViewController = [[ReviewCommentsViewController alloc] initWithNibName:@"ReviewCommentsViewController" bundle:nil];
        
        self.reviewCommentsViewController = tempReviewCommentsViewController;
        
        [self.view addSubview:reviewCommentsViewController.view];
        
        tempReviewCommentsViewController.ratingCount =[[NSString alloc] init];
        
        [tempReviewCommentsViewController.dateLabel setText:[[assetsData.productReviewArray objectAtIndex:[indexPath row]]commentedDate]];
        
        [tempReviewCommentsViewController.commentsLabel setText:[[assetsData.productReviewArray objectAtIndex:[indexPath row]]userComments]];
        
        NSString* user = [[[assetsData.productReviewArray objectAtIndex:indexPath.row] userName]description];
        [tempReviewCommentsViewController.userNameLabel setText:user];
        
        NSString* string = [NSString stringWithFormat:@"%@",[[assetsData.productReviewArray objectAtIndex:indexPath.row] productRatingView]];
        
        ///Star Rating
        
        float xBlue = 10;
        
        float  y =  100;
        
        float  width = 15;
        
        float height = 15;
        
            NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        
               for(int i = 0; i<[string intValue];i++)
               {
                   tempReviewCommentsViewController.ratingImage = [[UIImageView alloc]init];
                  tempReviewCommentsViewController.ratingImage.frame = CGRectMake(xBlue,y,width,height);
                   [tempReviewCommentsViewController.ratingImage setImage:[UIImage imageNamed:@"blue_star.png"]];
                   xBlue = xBlue + 15;
                   [tempReviewCommentsViewController.ratingImage setTag:i];
                   [tempReviewCommentsViewController.view  addSubview:tempReviewCommentsViewController.ratingImage];
                   [imageFramesArray addObject:tempReviewCommentsViewController.ratingImage];
               }
        
            [tempReviewCommentsViewController release];

        }
}

-(void)submitReviewButtonSelected:(id)sender
{
   
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(isSpecialOffer == YES )
    {
        
        int rowIndex = reviewProductId; //Gets from the SpecialOffer
        service.strId = [[assetsData.specialProductsArray objectAtIndex:rowIndex] specialProductId];

    }
    else {
        int rowIndex = reviewProductId; //Gets from the results VC
        service.strId = [[assetsData.productArray objectAtIndex:rowIndex] productDetailId];
    }
   
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        SubmitReviewViewController* tempSubmitReviewViewCotroller = [[SubmitReviewViewController alloc]initWithNibName:@"SubmitReviewViewController-iPad" bundle:nil];
        
        self.submitReviewViewController = tempSubmitReviewViewCotroller;
        [self.view addSubview:submitReviewViewController.view];
        [tempSubmitReviewViewCotroller release];
        
    }
    else {  //Iphone
        
        
        if(isSpecialOffer == YES) { //If the product selected from specialOffers

            if(loginChk == YES) { //If the user logged in
                SubmitReviewViewController* tempSubmitReviewViewCotroller = [[SubmitReviewViewController alloc]initWithNibName:@"SubmitReviewViewController" bundle:nil];
                
                self.submitReviewViewController = tempSubmitReviewViewCotroller;
                submitReviewViewController.isFromSpecialOffer = YES;
                tempSubmitReviewViewCotroller.loginChk = YES;
                tempSubmitReviewViewCotroller.submitProductID = reviewProductId;
                [self.view addSubview:submitReviewViewController.view];
                [tempSubmitReviewViewCotroller release];
            }
            
            else { 
                SubmitReviewViewController* tempSubmitReviewViewCotroller = [[SubmitReviewViewController alloc]initWithNibName:@"SubmitReviewViewController" bundle:nil];
                
                self.submitReviewViewController = tempSubmitReviewViewCotroller;
                submitReviewViewController.isFromSpecialOffer = YES;
                [self.view addSubview:submitReviewViewController.view];
                [tempSubmitReviewViewCotroller release];
            }
        }
        else 
        {
            
            if(loginChk == YES) {
                
                SubmitReviewViewController* tempSubmitReviewViewCotroller = [[SubmitReviewViewController alloc]initWithNibName:@"SubmitReviewViewController" bundle:nil];
                
                tempSubmitReviewViewCotroller.loginChk = YES;
                tempSubmitReviewViewCotroller.submitProductID = reviewProductId;
                tempSubmitReviewViewCotroller.submitArray = array_;
                self.submitReviewViewController = tempSubmitReviewViewCotroller;
                [self.view addSubview:submitReviewViewController.view];
                [tempSubmitReviewViewCotroller release];
                
            }
            
            else {
                
                SubmitReviewViewController* tempSubmitReviewViewCotroller = [[SubmitReviewViewController alloc]initWithNibName:@"SubmitReviewViewController" bundle:nil];
                
                self.submitReviewViewController = tempSubmitReviewViewCotroller;
                tempSubmitReviewViewCotroller.loginChk = NO;
                [self.view addSubview:submitReviewViewController.view];
                [tempSubmitReviewViewCotroller release];
                
            }
            
        }
        
    }
    
}


-(void)specialOfferButtonPressed:(id)sender
{
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
        
        [button release];
        
        
    }
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productReviewArray =[[NSMutableArray alloc] init];
    
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

- (void) myCartButtonPressed:(id)sender
{
    NSMutableArray *buttonArrayForMycart = [[NSMutableArray alloc] initWithObjects:
                                            [UIImage imageNamed:@"browse_btn_normal.png"],[UIImage imageNamed:@"offers_btn_normal.png"],
                                            [UIImage imageNamed:@"mycart_btn_highlighted.png"],nil];
    int x  = 5;
	
	int y = 42;
	
	int width = 100;
	
	int height = 35;
	
	for(int i = 0; i<[buttonArrayForMycart count]; i++)
	{
		UIButton *button = [[UIButton alloc] init];
		
		[button setFrame:CGRectMake(x, y, width, height)];
		
		[button setBackgroundImage:[buttonArrayForMycart objectAtIndex:i] forState:UIControlStateNormal];
		
		[self.view addSubview:button];
		
		x = x + 102;
               
       	[button release];
		
	}
    
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productReviewArray = [[NSMutableArray alloc] init];
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
	[tempResultViewController release];
    
}


-(void) goBack:(id) sender
{
	  
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productReviewArray = [[NSMutableArray alloc]init];

	[self.view removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:YES];
    [reviewTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc {
    [starImage release];
    [super dealloc];
}
@end
