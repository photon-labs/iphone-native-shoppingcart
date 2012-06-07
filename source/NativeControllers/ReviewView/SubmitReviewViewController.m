//
//  SubmitReviewViewController.m
//  Phresco
//
//  Created by bharat kumar on 26/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import "SubmitReviewViewController.h"
#import "ServiceHandler.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "Constants.h"
#import "SBJsonWriter.h"
#import "NSString+SBJSON.h"
#import "AddToBagViewController.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"
#import "PhrescoAppDelegate.h"
#import "LoginViewController.h"
#import "ConfigurationReader.h"


@implementation SubmitReviewViewController
@synthesize commentTextView;
@synthesize submitButton;
@synthesize specialOffersViewController;
@synthesize addToBagViewController;
@synthesize activityIndicator;
@synthesize loginViewController;
@synthesize isUserLogged;
@synthesize isFromSpecialOffer;
@synthesize loginChk;
@synthesize user;
@synthesize userID;
@synthesize submitProductID;
@synthesize submitArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"SubmitReviewViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"SubmitReviewViewController" bundle:nil];
        
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
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_highlighted.png"], [UIImage imageNamed:@"offers_btn_normal.png"],
                                       [UIImage imageNamed:@"mycart_btn_normal.png"], 
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
        
        submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submitButton.frame = CGRectMake(300, 800, 160, 50);
        [submitButton setBackgroundImage:[UIImage imageNamed:@"submitreview_btn.png"] forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(postComments:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitButton];
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
        
        submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submitButton.frame = CGRectMake(130, 300, 70, 25);
        [submitButton setBackgroundImage:[UIImage imageNamed:@"submitreview_btn.png"] forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(postComments:) forControlEvents:
         UIControlEventTouchUpInside];
        
        [self.view addSubview:submitButton];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        [self.view addSubview:activityIndicator];
        
        submitArray =[[NSMutableArray alloc] init];
        
    }
	
}
-(void) initializeTableView
{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        commentTextView = [[UITextField alloc] initWithFrame:CGRectMake(40, 240, 688, 450)];
    }
    else {
        commentTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 160)];
        
        user =[[NSString alloc] init];
        userID =[[NSString alloc] init];
        
        float x = 10;
        
        float  y =  100;
        
        float  width = 15;
        
        float height = 15;
        
        NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            ratingsButton = [[UIButton alloc]init];
            ratingsButton.frame = CGRectMake(x,y,width,height);
            [ratingsButton setBackgroundImage:[UIImage imageNamed:@"white_star.png"]forState:UIControlStateNormal];
            x = x + 15;
            [ratingsButton setTag:i];
            [submitButton addTarget:self action:@selector(postRatings:) forControlEvents:UIControlEventTouchUpInside];
            [self.view  addSubview:ratingsButton];
            [imageFramesWhiteArray addObject:ratingsButton];
        }
    }
    [commentTextView becomeFirstResponder];
    
    commentTextView.delegate = self;
    
    commentTextView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:commentTextView];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField 
{
    [textField resignFirstResponder];
    
    return  YES;
}

-(void)postRatings:(id)sender 
{
    float x = 10;
    
    float  y =  100;
    
    float  width = 15;
    
    float height = 15;
    
    NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
    for(int i = 0; i<1;i++)
    {
        ratingsButton = [[UIButton alloc]init];
        ratingsButton.frame = CGRectMake(x,y,width,height);
        [ratingsButton setBackgroundImage:[UIImage imageNamed:@"blue_star.png"]forState:UIControlStateNormal];
        x = x + 15;
        [ratingsButton setTag:i];
        [submitButton addTarget:self action:@selector(postRatings:) forControlEvents:UIControlEventTouchUpInside];
        [self.view  addSubview:ratingsButton];
        [imageFramesWhiteArray addObject:ratingsButton];
    }
    [ratingsButton setBackgroundImage:[UIImage imageNamed:@"blue_star.png"]forState:UIControlStateNormal];
}

-(void)postComments:(id)sender 
{
    
    [activityIndicator startAnimating];
    
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    
    if(isFromSpecialOffer == YES)
    {
        serviceHandler.strId= [[assetsData.specialProductsArray objectAtIndex:submitProductID]specialProductId];
        
    }
    else
    {    
        serviceHandler.strId = [[assetsData.productArray objectAtIndex:submitProductID]productDetailId];
    }
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myString = [prefs stringForKey:@"userId"];
    userID = myString;
    NSString *userName = [prefs stringForKey:@"userName"];
    user = userName;

    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:MM:SS"]; 
    NSString *dateString = [dateFormat stringFromDate:today];
    
    
    if([commentTextView.text length] > 0) {
        
        serviceHandler.commentProductId = serviceHandler.strId ;
        
        serviceHandler.commentUserId = (NSMutableString*)userID;
        
        serviceHandler.commentRating = (NSMutableString*)@"";
        
        serviceHandler.commentComment = (NSMutableString*)commentTextView.text;
        
        serviceHandler.commentDate =  (NSMutableString*)dateString;
        
        serviceHandler.commentUserName = (NSMutableString*)user;
        
        [serviceHandler productReviewService:self :@selector(finishedProductReviewService:)];
        
        NSMutableDictionary* loginDict= [[NSMutableDictionary alloc] init];
        
        [loginDict setObject:serviceHandler.commentProductId  forKey:kpostReviewProductId];
        
        [loginDict setObject:serviceHandler.commentUserId  forKey:kpostReviewUserId];
        
        [loginDict setObject:serviceHandler.commentRating  forKey:kpostReviewRating];
        
        [loginDict setObject:serviceHandler.commentComment  forKey:kpostReviewComment];
        
        [loginDict setObject:serviceHandler.commentDate  forKey:kpostReviewCommentDate];
        
        [loginDict setObject:serviceHandler.commentUserName forKey:kpostReviewUserName];
        
        
        serviceHandler.commentProductId =[loginDict objectForKey:kpostReviewProductId];
        
        serviceHandler.commentUserId =[loginDict objectForKey:kpostReviewProductId];
        
        serviceHandler.commentRating =[loginDict objectForKey:kpostReviewRating];
        
        serviceHandler.commentComment =[loginDict objectForKey:kpostReviewComment];
        
        serviceHandler.commentDate = [loginDict objectForKey:kpostReviewCommentDate];
        
        serviceHandler.commentUserName = [loginDict objectForKey:kpostReviewUserName];
        
        NSDictionary* dict = [NSDictionary dictionaryWithObject:loginDict forKey:kReview];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        
        
        if(loginChk == YES)
        {
            loginViewController.isLogin = YES;
            
//        if(filePath)
//        {
//            NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
//            
//            NSString *protocol = [dictionary objectForKey:kwebserviceprotocol];
//            
//            NSString *host = [dictionary objectForKey:kwebservicehost];
//            
//            NSString *port = [dictionary objectForKey:kwebserviceport];
//            
//            NSString *context = [dictionary objectForKey:kwebservicecontext]; 
            
            
            ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
            [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
            
            //  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
            
            //       if(filePath)
            //        {
            //  NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
           
            NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,korderproduct,kpost,kReview];
            
                NSLog(@"urlString in postComments %@",urlString);
            
                SBJsonWriter* json =[SBJsonWriter alloc];
                
                NSString* jsonString  = [json stringWithObject:dict];
                
                NSData* postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding];
                
                NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString]];
                [request setHTTPMethod:@"POST"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
                [request setHTTPBody:postData];
                
                NSURLResponse *urlResponse;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:nil];   
                
                NSString* jsonData = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                
                
                NSDictionary* response = [jsonData JSONValue];
                
                NSMutableString* successMsg = [[NSMutableString alloc] init];
                successMsg = [response objectForKey:@"successMessage"];
            
                if([successMsg isEqualToString:@"Success"]) {
                    
                    UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"" message:  @"Review comments posted successfully"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
                    [alertSuccess show]; 
                    [alertSuccess release];
                    [activityIndicator stopAnimating];
                    
                }
                
          /// }//End of userLogged BOOL condition
           
        }//End of BOOL condition
            else{ UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:  @"Please Login"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
                [alert show]; [alert release];
                [activityIndicator stopAnimating];
            }
      
        
    }//End of (textfield length > 0)
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:  @"Review cannot be posted. Please try again"  
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
        [alert show]; 
        [alert release];   
        [activityIndicator stopAnimating];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1 ) 
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

-(void)finishedProductReviewService:(id)data {
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
    
}
-(void)specialOfferButtonPressed:(id)sender
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


- (void) myCartButtonPressed:(id)sender
{
    NSMutableArray *buttonArrayForMycart = [[NSMutableArray alloc] initWithObjects:
                                            [UIImage imageNamed:@"browse_btn_normal.png"],                                        [UIImage imageNamed:@"offers_btn_normal.png"],
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
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
	[tempResultViewController release];
    
    
}


-(void) goBack:(id) sender 
{
       
    [self.view removeFromSuperview];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc 
{
    [super dealloc];
    [userID release];
    [user release];
}

@end
