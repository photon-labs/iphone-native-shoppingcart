#import "RegistrationViewController.h"
#import "Constants.h"
#import "ServiceHandler.h"
#import "Constants.h"
#import "DataModelEntities.h"
#import "SBJsonWriter.h"
#import "SBJsonParser.h"
#import "NSString+SBJSON.h"
#import "Tabbar.h"
#import "SharedObjects.h"
#import "ConfigurationReader.h"

@implementation RegistrationViewController
@synthesize backGroundView;
@synthesize viewController;
@synthesize okButton;
@synthesize closeButton;
@synthesize myImageView;
@synthesize registerButton;
@synthesize cancelButton;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"RegistrationViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"RegistrationViewController" bundle:nil];
        
    }

    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    [tabbar setSelectedIndex:0 fromSender:nil];
    
    [self loadNavigationBar];
    
    [self createRegistrationScreen];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

-(void) goBack:(id) sender

{
    [self.view removeFromSuperview];
}

-(void) createRegistrationScreen
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        backGroundView = [[UIView alloc] init];
        backGroundView.frame = CGRectMake(0,140, 768, 660);
        backGroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"register_bg.png"]];
        [self.view addSubview:backGroundView];
        
        
        regScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 660)];
        regScrollView.contentSize = CGSizeMake(760, 680);
        [backGroundView addSubview:regScrollView];
        
        
        UIImageView	*registerHeader = [[UIImageView alloc] initWithFrame:CGRectMake(230, -15, 300, 60)];
        
        [registerHeader setImage:[UIImage imageNamed:@"register_header.png"]];
        
        [backGroundView addSubview:registerHeader];
        
        [registerHeader release];
        //create an array of labels and text field
        
        NSMutableArray *labelArray = [[NSMutableArray alloc] initWithObjects:@"FirstName",@"LastName",@"Email Address", @"Password", @"Confirm Password", nil];
        
        int labelX = 40;
        
        int labelY = 40;
        
        int labelWidth = 280;
        
        int labelHeight = 40;
        
        for(int i = 0; i<[labelArray count]; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
            
            [label setText:[labelArray objectAtIndex:i]];
            
            [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setTextColor:[UIColor whiteColor]];
            
            [regScrollView addSubview:label];
            
            [label release];
            
            labelY = labelY + 120;
            
        }
        //create text fields
        firstName= [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 560, 60)];
        
        firstName.delegate = self;
        
        firstName.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:firstName];
        
        
        lastName = [[UITextField alloc] initWithFrame:CGRectMake(40, 220, 560, 60)];
        
        lastName.delegate = self;
        
        lastName.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:lastName];   
        
        
        
        emailAddress = [[UITextField alloc] initWithFrame:CGRectMake(40, 340, 560, 60)];
        
        emailAddress.delegate = self;
        
        emailAddress.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:emailAddress];
        
        
        passWord = [[UITextField alloc] initWithFrame:CGRectMake(40, 460, 560, 60)];
        
        passWord.delegate = self;
        
        passWord.borderStyle = UITextBorderStyleRoundedRect;
        
        [passWord setSecureTextEntry:YES];
        
        [regScrollView addSubview:passWord];
        
        
        confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(40, 580, 560, 60)];
        
        confirmPassword.delegate = self;
        
        confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
        
        [confirmPassword setSecureTextEntry:YES];
        
        [regScrollView addSubview:confirmPassword];
        
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"register_btn2.png"], [UIImage imageNamed:@"cancel_btn2.png"], nil];
        
        int buttonX = 250;
        
        int buttonY = 840;
        
        int buttonWidth = 140;
        
        int buttonHeight = 60;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
            
            [button setBackgroundImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            
            if(i == 0) {
                
                [button addTarget:self action:@selector(registerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            if(i == 1) {
                
                [button addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            
            [self.view addSubview:button];
            
            buttonX = buttonX + 160;
            
            [button release];
        }
        
        [buttonArray release];
	}
    else {
        
        backGroundView = [[UIView alloc] init];
        backGroundView.frame = CGRectMake(0,80, 320, 280);
        backGroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"register_bg.png"]];
        [self.view addSubview:backGroundView];
        
        
        regScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
        regScrollView.contentSize = CGSizeMake(320, 350);
        regScrollView.delegate =  self;
        [backGroundView addSubview:regScrollView];
 
        
        UIImageView	*registerHeader = [[UIImageView alloc] initWithFrame:CGRectMake(90, -8, 150, 30)];
        
        [registerHeader setImage:[UIImage imageNamed:@"register_header.png"]];
        
        [backGroundView addSubview:registerHeader];
        
        [registerHeader release];
        
        
        NSMutableArray *labelArray = [[NSMutableArray alloc] initWithObjects:@"FirstName",@"LastName",@"Email Address", @"Password", @"Confirm Password", nil];
        
        int labelX = 20;
        
        int labelY = 20;
        
        int labelWidth = 140;
        
        int labelHeight = 20;
        
        for(int i = 0; i<[labelArray count]; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
            
            [label setText:[labelArray objectAtIndex:i]];
            
            [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
            
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setTextColor:[UIColor whiteColor]];
            
            [regScrollView addSubview:label];
            
            [label release];
            
            labelY = labelY + 60;
            
        }
        //create text fields
        firstName= [[UITextField alloc] initWithFrame:CGRectMake(labelX, 50, 280, 30)];
        
        firstName.delegate = self;
        
        firstName.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:firstName];
        
        
        lastName = [[UITextField alloc] initWithFrame:CGRectMake(labelX,110 , 280, 30)];
        
        lastName.delegate = self;
        
        lastName.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:lastName];   
        
        
        
        emailAddress = [[UITextField alloc] initWithFrame:CGRectMake(labelX, 170, 280, 30)];
        
        emailAddress.delegate = self;
        
        emailAddress.borderStyle = UITextBorderStyleRoundedRect;
        
        [regScrollView addSubview:emailAddress];
        
        
        passWord = [[UITextField alloc] initWithFrame:CGRectMake(labelX, 230, 280, 30)];
        
        passWord.delegate = self;
        
        passWord.borderStyle = UITextBorderStyleRoundedRect;
        
        [passWord setSecureTextEntry:YES];
        
        [regScrollView addSubview:passWord];
        
        confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(labelX, 290, 280, 30)];
        
        confirmPassword.delegate = self;
        
        confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
        
        [confirmPassword setSecureTextEntry:YES];
        
       [regScrollView addSubview:confirmPassword];
        
                
        int buttonY = 370;
        
        
        registerButton = [[UIButton alloc] init];
        
        [registerButton setFrame:CGRectMake(145, buttonY, 70, 30)];
        
        [registerButton setImage:[UIImage imageNamed:@"register_btn2.png"] forState:UIControlStateNormal];
        
        [registerButton addTarget:self action:@selector(registerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:registerButton];
        
        registerButton.accessibilityLabel = @"reg";
        
        cancelButton = [[UIButton alloc] init];
        
        [cancelButton setFrame:CGRectMake(225, buttonY, 70, 30)];
        
        [cancelButton setImage:[UIImage imageNamed:@"cancel_btn2.png"] forState:UIControlStateNormal];
        
        [cancelButton addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:cancelButton];
        
        cancelButton.accessibilityLabel= @"logCancel";
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        [self.view addSubview:activityIndicator];

    }
	
 
}


- (void)registerButtonSelected:(id)sender
{
    NSString* str1 =firstName.text ;
    NSString* str2 =lastName.text ;
    NSString* str3 =emailAddress.text ;
    NSString* str4 =passWord.text ;
    NSString* str5 =confirmPassword.text ;
    
    
        if(([str1 length] == 0 ) && ([str2 length]  > 0) && ([str3 length] > 0 )&& ([str4 length] > 0 ) && ([str5 length] > 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  Firstname " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] > 0 ) && ([str2 length]  ==  0) && ([str3 length] > 0 )&& ([str4 length] > 0 ) && ([str5 length] > 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  Lastname " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] > 0 ) && ([str2 length]  >  0) && ([str3 length] == 0 )&& ([str4 length] > 0 ) && ([str5 length] > 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  Email address " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] > 0 ) && ([str2 length]  >  0) && ([str3 length] > 0 )&& ([str4 length] == 0 ) && ([str5 length] > 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  password " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] > 0 ) && ([str2 length]  >  0) && ([str3 length] > 0 )&& ([str4 length] > 0 ) && ([str5 length] == 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  confirm password " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] == 0 ) && ([str2 length]  ==  0) && ([str3 length] == 0 )&& ([str4 length] == 0 ) && ([str5 length] == 0))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter the values " delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
        else if(([str1 length] > 0 ) && ([str2 length]  >  0) && ([str3 length] > 0 )&& ([str4 length] > 0 ) && ([str5 length] > 0))
        {
           
            
            [activityIndicator startAnimating];
            
            ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
            
            serviceHandler.firstName = (NSMutableString*)firstName.text;
            
            serviceHandler.lastName = (NSMutableString*)lastName.text;
            
            serviceHandler.emailAddress = (NSMutableString*)emailAddress.text;
            
            serviceHandler.password = (NSMutableString*)passWord.text;
            
            serviceHandler.phoneNumber = (NSMutableString*)@"";
       
            
            NSMutableDictionary* loginDict= [[NSMutableDictionary alloc] init];
            
            [loginDict setObject:serviceHandler.firstName  forKey:kfirstName];
            
            [loginDict setObject:serviceHandler.lastName  forKey:klastName];
            
            [loginDict setObject:serviceHandler.emailAddress  forKey:kemailAddress];
            
            [loginDict setObject:serviceHandler.password  forKey:kpassword];
            
            [loginDict setObject:serviceHandler.phoneNumber  forKey:kphoneNumber];
            
            
            
            serviceHandler.firstName =[loginDict objectForKey:kfirstName];
            
            serviceHandler.lastName =[loginDict objectForKey:klastName];
            
            serviceHandler.emailAddress = [loginDict objectForKey:kemailAddress];
            
            serviceHandler.password = [loginDict objectForKey:kpassword];
            
            serviceHandler.phoneNumber = [loginDict objectForKey:kphoneNumber];
            
            
            
            NSDictionary* dict = [NSDictionary dictionaryWithObject:loginDict forKey:kRegister];
            
            
            NSString* pwd = passWord.text;
            NSString* confirmPwd = confirmPassword.text;
            
            //Email id validation
           NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
             NSRange aRange;
            //Valid email address
            if ([emailTest evaluateWithObject:str3] == YES) 
            {
                    aRange = [str3 rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [str3 length])];
                    int indexOfDot = aRange.location;
                    if(aRange.location != NSNotFound) {
                        NSString *topLevelDomain = [str3 substringFromIndex:indexOfDot];
                        topLevelDomain = [topLevelDomain lowercaseString];
                        NSLog(@"topleveldomains:%@",topLevelDomain);
                        NSSet *TLD;
                        TLD = [NSSet setWithObjects:@".phresco",@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
                                                
                    }
                   
             
            if([pwd isEqualToString:confirmPwd]) {
                
                
//                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
//                
//                if(filePath)
//                {
//                    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
//                    NSString *protocol = [dictionary objectForKey:kwebserviceprotocol];
//                    NSString *host = [dictionary objectForKey:kwebservicehost];
//                    NSString *port = [dictionary objectForKey:kwebserviceport];
//                    NSString *context = [dictionary objectForKey:kwebservicecontext]; 
                
                
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
                    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kpost,kRegister];
                    // http://172.16.17.180:9990/eshop/rest/api/post/register/
                    NSLog(@"urlString %@",urlString);
                    
                    SBJsonWriter* json =[SBJsonWriter alloc];
                    NSString* jsonString  = [json stringWithObject:dict];
                    NSLog(@"jsonString :%@", jsonString);
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
                    NSLog(@"response :%@", response);
                    NSMutableString* strMsg = [[NSMutableString alloc] init];
                    strMsg = [response objectForKey:@"message"];
                    NSLog(@"%@",strMsg);
                    NSMutableString* successMsg = [[NSMutableString alloc] init];
                    successMsg = [response objectForKey:@"successMessage"];
                    NSLog(@"%@",successMsg);
                    if([successMsg isEqualToString:@"Success"]) { 
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Registered Successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                        
                        [alert show];
                        [alert release];
                    }
                    
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    {
                        [activityIndicator stopAnimating];
                        viewController = [[UIView alloc] init];   
                        viewController.frame = CGRectMake(100, 200, 480, 240);
                        UILabel *label = [[UILabel alloc] init];
                        label.text = successMsg;
                        label.frame = CGRectMake(200, 60, 300, 40);
                        label.backgroundColor = [UIColor clearColor];
                        label.accessibilityLabel = @"ResultLabel";
                        label.accessibilityValue = successMsg;
                        label.adjustsFontSizeToFitWidth = YES;
                        label.textColor =[UIColor whiteColor];
                        label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:24];
                        myImageView = [[UIImageView alloc] init] ;
                        myImageView.frame =CGRectMake(0, 0,480, 280);
                        myImageView.image = [UIImage imageNamed :@"popup_bg.png"];
                        [viewController addSubview:myImageView];
                        [viewController addSubview:label];
                        [self.view addSubview:viewController];
                        okButton = [[UIButton alloc] init];
                        [okButton setFrame:CGRectMake(180, 160, 100, 60)];
                        [okButton setBackgroundImage:[UIImage imageNamed:@"ok_btn.png"] forState:UIControlStateNormal];
                        
                        [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [viewController addSubview:okButton];
                        
                        okButton.accessibilityLabel = @"OkButton";

                        closeButton = [[UIButton alloc] init];
                        
                        [registerButton setUserInteractionEnabled:NO];
                        [cancelButton setUserInteractionEnabled:NO];
                        
                    }
                    else{
                    
                    [activityIndicator stopAnimating];
                    viewController = [[UIView alloc] init];   
                    
                    viewController.frame = CGRectMake(20, 150, 290, 120);
                    
                    UILabel *label = [[UILabel alloc] init];
                    
                    label.text = successMsg;
                    
                    label.frame = CGRectMake(100, 30, 150, 20);
                        
                    label.accessibilityLabel = @"ResultLabel";
                        
                    label.accessibilityValue = successMsg; 
                    
                    label.backgroundColor = [UIColor clearColor];
                    
                    label.adjustsFontSizeToFitWidth = YES;
                    
                    label.textColor =[UIColor whiteColor];
                    
                    label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:12];
                    
                    myImageView = [[UIImageView alloc] initWithImage : 
                                                [UIImage imageNamed :@"popup_bg.png"]];
                    
                    [viewController addSubview:myImageView];
                    
                    [viewController addSubview:label];
                    
                    [self.view addSubview:viewController];
                    
                    okButton = [[UIButton alloc] init];
                    
                    [okButton setFrame:CGRectMake(120, 80, 50, 30)];
                    
                    [okButton setBackgroundImage:[UIImage imageNamed:@"ok_btn.png"] forState:UIControlStateNormal];
                    
                    [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
                        
                    [viewController addSubview:okButton];
                    
                    okButton.accessibilityLabel = @"OkButton";
                        
                    [registerButton setUserInteractionEnabled:NO];
                    
                    [cancelButton setUserInteractionEnabled:NO];
                        
                    [activityIndicator stopAnimating];
                   
                    }
                //}
                
                }
            
            else
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Passwords are not same" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                
                [alert show];
                [alert release]; 
            }
         }

            else
            {
                NSLog(@"Email not in proper format");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Email validation" message:@"Email not in proper formats" delegate:   self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                
                [alert show];
                [alert release];
    
            }
        }
        
        else { 
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter the values" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
            
        }
}


- (void)okButtonSelected:(id)sender
{
    [self.view removeFromSuperview];
    
}

- (void)closeButtonSelected:(id)sender
{
    [self.view removeFromSuperview];
    
}

- (void)cancelButtonSelected:(id)sender
{
    [self.view removeFromSuperview];
    
}
- (void)passwordValidation:(id)sender 
{
}
#pragma --------------
#pragma Mark TextField Delegates
#pragma --------------

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
//    [firstName resignFirstResponder];
//    [lastName resignFirstResponder];
//    [emailAddress resignFirstResponder];
//    [passWord resignFirstResponder];
//    [confirmPassword resignFirstResponder];
    
    [textField resignFirstResponder];
    return YES;
}

-(void) dealloc
{
    
    [okButton release];
    [closeButton release];
    [viewController release];
    [myImageView release];
    [super dealloc];
}
@end
