//
//  PDPServiceHandler.m
//  iShop2.0
//
//  Created by PHOTON on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServiceHandler.h"
#import "ConnectionManager.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "JSON.h"
#import "ServerURLConstants.h"
#import "DebugOutput.h"
#import "Constants.h"
#import "ConfigurationReader.h"

@implementation ServiceHandler

@synthesize callBackTarget ;
@synthesize callBackSelector;
@synthesize strId;
@synthesize prodId;
@synthesize productName;
@synthesize loginId;
@synthesize pwd;
@synthesize firstName;
@synthesize lastName;
@synthesize password;
@synthesize confirmPassword;
@synthesize emailAddress;
@synthesize phoneNumber;
@synthesize commentProductId;
@synthesize commentUserId;
@synthesize commentDate;
@synthesize commentRating;
@synthesize commentComment;
@synthesize commentUserName;
@synthesize loginUserId;
@synthesize loginUserName;


-(void) configService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    // if(filePath)
    // {
    
    //NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context,kRestApi,kConfigService];
    
    ///////// Support ////////////////////////
    AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
    
    appInfoEntity.configEndpoint = urlString;
    //////////////////////////////////////////
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(configServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    // }	
	
}

-(void) configServiceDone:(NSMutableDictionary*) responseDataDict
{
	///////// Support //////////////
	NSDate *serviceCallTime = [NSDate date];
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	appInfoEntity.serviceName = @"Config";
	
	appInfoEntity.appServiceCallTime = serviceCallTime;
	///////////////////////////////
	
	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *configResponse;
	
	NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    ///////// Support //////////////
    appInfoEntity.configResponseString = responseResultString;
    
    ////////////////////////////////
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    
    //Pass the obtained config response to the callback target(launch flow). The data parsing will be done there
    //after version check and other criterias
    configResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
    
	[string release];
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:configResponse waitUntilDone:NO];	
}

-(void) catalogService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /* if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context,kRestApi,kCatalogService];         
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(catalogServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
}

-(void) catalogServiceDone:(NSMutableDictionary*) responseDataDict
{		
	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
    NSMutableArray *catalogResponse;
	
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    catalogResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempArray objectForKey:@"category"];
    
    
    for (tempArray in ValueID) {
        
        NSMutableString *strText=[[NSMutableString alloc]init];
        NSMutableString *strID=[[NSMutableString alloc]init];
        NSMutableString *strImg=[[NSMutableString alloc]init];
        NSMutableString *strName=[[NSMutableString alloc]init];
        NSMutableString *strCount=[[NSMutableString alloc]init];
        
        strText = [tempArray objectForKey:@"detailsImage"];
        strID = [tempArray objectForKey:@"id"];
        strImg = [tempArray objectForKey:@"image"];
        strName = [tempArray objectForKey:@"name"];
        strCount = [tempArray objectForKey:@"productCount"];
        
        [dictCat setObject:strText forKey:@"detailsImage"];
        [dictCat setObject:strID forKey:@"id"];
        [dictCat setObject:strImg forKey:@"image"];
        [dictCat setObject:strName forKey:@"name"];
        [dictCat setObject:strCount forKey:@"productCount"];
        [catalogResponse addObject:[dictCat copy]];
        
        [strText retain];
        [strText release];
        
        [strID retain];
        [strID release];
        
        [strImg retain];
        [strImg release];
        
        [strName retain];
        [strName release];
        
        [strCount retain];
        [strCount release];
        
        
    }
    
   	[string release];
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:catalogResponse waitUntilDone:NO];	
    
    [ValueID retain];
    [ValueID release];
    
    [dictCat retain];
    [dictCat release];
    
    [catalogResponse retain];
    [catalogResponse release];
}

////To display the product details 
-(void) productDetailsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /*if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi, kCatalogService,strId];
    
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productDetailsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
}

-(void) productDetailsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
    NSMutableArray *productDetailsResponse;
	
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempArray objectForKey:@"product"];
    
    
    for (tempArray in ValueID) {
        
        NSMutableString *strText=[[NSMutableString alloc]init];
        NSMutableString *striD=[[NSMutableString alloc]init];
        NSMutableString *strImg=[[NSMutableString alloc]init];
        NSMutableString *strName=[[NSMutableString alloc]init];
        NSMutableString *strListprice=[[NSMutableString alloc]init];
        
        strText = [tempArray objectForKey:@"rating"];
        striD = [tempArray objectForKey:@"id"];
        strImg = [tempArray objectForKey:@"image"];
        strName = [tempArray objectForKey:@"name"];
        strListprice = [tempArray objectForKey:@"listPrice"];
        
        [dictCat setObject:strText forKey:@"rating"];
        [dictCat setObject:striD forKey:@"id"];
        [dictCat setObject:strImg forKey:@"image"];
        [dictCat setObject:strName forKey:@"name"];
        [dictCat setObject:strListprice forKey:@"listPrice"];
        [productDetailsResponse addObject:[dictCat copy]];
        
        
        [strText retain]; [strText release];
        [striD retain]; [striD release];
        [strImg retain]; [strImg release];
        [strName retain]; [strName release];
        [strListprice retain]; [strListprice release];
        
    }
    
	[string release];
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    [ValueID retain];
    [ValueID release];
    
    [dictCat retain];
    [dictCat release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
}

////To display the product 

-(void) productService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /* if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    // }		
}

-(void) productServiceDone:(NSMutableDictionary*) responseDataDict 
{
    
    
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	
    NSMutableArray *productDetailsResponse;
    
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    //Added
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempArray objectForKey:@"product"];
    
    for (tempArray in ValueID) {
        
        NSMutableString *strText=[[NSMutableString alloc]init];
        NSMutableString *striD=[[NSMutableString alloc]init];
        NSMutableString *strImg=[[NSMutableString alloc]init];
        NSMutableString *strName=[[NSMutableString alloc]init];
        NSMutableString *strListprice=[[NSMutableString alloc]init];
        NSMutableString *strDescription=[[NSMutableString alloc]init];
        NSMutableString *strDetails=[[NSMutableString alloc]init];
        
        
        strText = [tempArray objectForKey:@"rating"];
        striD = [tempArray objectForKey:@"id"];
        strImg = [tempArray objectForKey:@"image"];
        strName = [tempArray objectForKey:@"name"];
        strListprice = [tempArray objectForKey:@"listPrice"];
        strDescription = [tempArray objectForKey:@"description"];
        strDetails = [tempArray objectForKey:@"details"];
        
        NSDictionary *tempDetail = [NSDictionary dictionaryWithDictionary:tempArray];
        NSMutableArray *ValDetail =  [[NSMutableArray alloc]init];
        ValDetail = [tempDetail objectForKey:@"details"];
        
        NSDictionary *flight1 = [tempDetail objectForKey:@"details"];
        
        for (NSString *key in [flight1 allKeys]) {
            
            
            NSMutableString *strTVType=[[NSMutableString alloc]init];
            NSMutableString *strScreen=[[NSMutableString alloc]init];
            NSMutableString *strRatio=[[NSMutableString alloc]init];
            NSMutableString *strDefinition=[[NSMutableString alloc]init];
            
            strTVType = [flight1 objectForKey:@"TV Type"];
            strScreen = [flight1 objectForKey:@"Screen Size"];
            strRatio = [flight1 objectForKey:@"Screen Ratio"];
            strDefinition = [flight1 objectForKey:@"TV Definition"];
            
            [dictCat setObject:strTVType forKey:@"TV Type"];
            [dictCat setObject:strScreen forKey:@"Screen Size"];
            [dictCat setObject:strRatio forKey:@"Screen Ratio"];
            [dictCat setObject:strDefinition forKey:@"TV Definition"];
            
            
            
            [strTVType retain];
            [strTVType release];
            
            [strScreen retain];
            [strScreen release];
            
            [strRatio retain];
            [strRatio release];
            
            
            [strDefinition retain];
            [strDefinition release];
            
            
            
        }
        
        [dictCat setObject:strText forKey:@"rating"];
        [dictCat setObject:striD forKey:@"id"];
        [dictCat setObject:strImg forKey:@"image"];
        [dictCat setObject:strName forKey:@"name"];
        [dictCat setObject:strListprice forKey:@"listPrice"];
        [dictCat setObject:strDescription forKey:@"description"];
        
        [productDetailsResponse addObject:[dictCat copy]];
        
        
        [strText retain];
        [strText release];
        
        [striD  retain];
        [striD release];
        
        [strImg retain];
        [strImg release];
        
        [strName retain];
        [strName release];
        
        [strListprice retain];
        [strListprice release];
        
        [strDescription retain];
        [strDescription release];
        
        [strDetails  retain];
        [strDetails release];
        
        
        [ValDetail retain];
        [ValDetail release];
        
        
    }
    
    //Ended for new portal
    
    
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    [ValueID retain];
    [ValueID release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
    
    
    
    
    
    
}


////To display the product 

- (void) productReviewService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /*if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId,kreview];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productReviewServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
}

-(void) productReviewServiceDone:(NSMutableDictionary*) responseDataDict
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	//NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
    NSMutableArray *productDetailsResponse;
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    NSMutableArray *productDetailsResponseOne = [[NSMutableArray alloc]init];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    // NSLog(@"product review Description....%@", responseResultString);
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    //Added
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSDictionary *tempReview = [tempArray objectForKey:@"review"];
    
    
    
    NSDictionary *tempComments = [NSDictionary dictionaryWithDictionary:tempReview];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempComments objectForKey:@"comments"];
    
    
    NSMutableString* strAvg = [[NSMutableString alloc] init];
    strAvg = [tempReview  objectForKey:@"average"];
    
    
    NSMutableString* ratingsID = [[NSMutableString alloc] init];
    ratingsID = [tempReview  objectForKey:@"ratings"];
    
    
    NSDictionary *tempRating = [tempReview  objectForKey:@"ratings"];
    NSMutableArray* newArray =[[NSMutableArray alloc] init];
    newArray =  [tempRating objectForKey:@"rating"];
    
    for (tempRating in newArray) {
        
        NSMutableString *strKey=[[NSMutableString alloc]init];
        NSMutableString *strValue=[[NSMutableString alloc]init];
        
        strKey = [tempRating objectForKey:@"key"];
        strValue = [tempRating objectForKey:@"value"];
        
        [productDetailsResponseOne addObject:[tempRating copy]];
        
        
        [strKey retain];
        [strKey release];
        
        [strValue retain];
        [strValue release];
        
    }
    
    for (tempComments in ValueID) {
        
        NSMutableString *strComment=[[NSMutableString alloc]init];
        NSMutableString *strDate=[[NSMutableString alloc]init];
        NSMutableString *strRating=[[NSMutableString alloc]init];
        NSMutableString *strUser=[[NSMutableString alloc]init];
        
        strComment = [tempComments objectForKey:@"comment"];
        strDate = [tempComments objectForKey:@"commentDate"];
        strRating = [tempComments objectForKey:@"rating"];
        strUser = [tempComments objectForKey:@"user"];
        [productDetailsResponse addObject:[tempComments copy]];
        
        
        [strComment retain];
        [strComment release];
        
        [strDate retain];
        [strDate release];
        
        [strRating retain];
        [strRating release];
        
        [strUser retain];
        [strUser release];
        
        [ratingsID retain];
        [ratingsID release];
        
    }
    
    [productDetailsResponse addObject:[tempReview copy]];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.keyValueArray = productDetailsResponseOne;
    [self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    
    [ValueID retain];
    [ValueID release];
    
    [newArray retain];
    [newArray release];
    
    
    [strAvg retain];
    [strAvg release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
    
    [productDetailsResponseOne retain];
    [productDetailsResponseOne release];
}


#pragma mark Special Products

-(void) specialProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /*if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context, kRestApi,kSpecialproducts];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(specialProductsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
    
}

-(void) specialProductsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	
    NSMutableArray *productDetailsResponse;
    
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    //Added
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempArray objectForKey:@"product"];
    
    for (tempArray in ValueID) {
        
        NSMutableString *strText=[[NSMutableString alloc]init];
        NSMutableString *striD=[[NSMutableString alloc]init];
        NSMutableString *strImg=[[NSMutableString alloc]init];
        NSMutableString *strName=[[NSMutableString alloc]init];
        NSMutableString *strListprice=[[NSMutableString alloc]init];
        NSMutableString *strDescription=[[NSMutableString alloc]init];
        NSMutableString *strDetails=[[NSMutableString alloc]init];
        
        
        strText = [tempArray objectForKey:@"rating"];
        striD = [tempArray objectForKey:@"id"];
        strImg = [tempArray objectForKey:@"image"];
        strName = [tempArray objectForKey:@"name"];
        strListprice = [tempArray objectForKey:@"listPrice"];
        strDescription = [tempArray objectForKey:@"description"];
        strDetails = [tempArray objectForKey:@"details"];
        
        NSDictionary *tempDetail = [NSDictionary dictionaryWithDictionary:tempArray];
        NSMutableArray *ValDetail =  [[NSMutableArray alloc]init];
        ValDetail = [tempDetail objectForKey:@"details"];
        
        [dictCat setObject:strText forKey:@"rating"];
        [dictCat setObject:striD forKey:@"id"];
        [dictCat setObject:strImg forKey:@"image"];
        [dictCat setObject:strName forKey:@"name"];
        [dictCat setObject:strListprice forKey:@"listPrice"];
        [dictCat setObject:strDescription forKey:@"description"];
        
        [productDetailsResponse addObject:[dictCat copy]];
        
        [strText retain]; 
        [strText release];
        
        [striD  retain];
        [striD release];
        
        [strImg retain];
        [strImg release];
        
        [strName retain];
        [strName release];
        
        [strListprice retain];
        [strListprice release];
        
        [strDescription retain];
        [strDescription release];
        
        [strDetails  retain];
        [strDetails release]; 
        
        [ValDetail retain];
        [ValDetail release];
        
        
        
    }
    
    //Ended for new portal
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    [ValueID retain];
    [ValueID release];
    
    [dictCat retain];
    [dictCat release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
    
}
-(void) searchProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /* if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi, kProductService,ksearch,productName];
    
    NSLog(@"url string:%@", urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(searchProductsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
    
}

-(void) searchProductsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
    NSMutableArray *productDetailsResponse;
	
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSMutableDictionary *dictCat = [[NSMutableDictionary alloc]init];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempArray objectForKey:@"product"];
    
    
    for (tempArray in ValueID) {
        
        NSMutableString *strText=[[NSMutableString alloc]init];
        NSMutableString *striD=[[NSMutableString alloc]init];
        NSMutableString *strImg=[[NSMutableString alloc]init];
        NSMutableString *strName=[[NSMutableString alloc]init];
        NSMutableString *strListprice=[[NSMutableString alloc]init];
        
        strText = [tempArray objectForKey:@"rating"];
        striD = [tempArray objectForKey:@"id"];
        strImg = [tempArray objectForKey:@"image"];
        strName = [tempArray objectForKey:@"name"];
        strListprice = [tempArray objectForKey:@"listPrice"];
        
        [dictCat setObject:strText forKey:@"rating"];
        [dictCat setObject:striD forKey:@"id"];
        [dictCat setObject:strImg forKey:@"image"];
        [dictCat setObject:strName forKey:@"name"];
        [dictCat setObject:strListprice forKey:@"listPrice"];
        [productDetailsResponse addObject:[dictCat copy]];
        
        
        [strText retain]; 
        [strText release];
        
        [striD  retain];
        [striD release];
        
        [strImg retain];
        [strImg release];
        
        [strName retain];
        [strName release];
        
        [strListprice retain];
        [strListprice release];
        
        
    }    
    
	[string release];
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    
    [ValueID retain];
    [ValueID release];
    
    [dictCat retain];
    [dictCat release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
    
}
- (void) productReviewCommentService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    /*if(filePath)
     {
     NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];*/
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId,kreview];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productReviewCommentServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    //}		
    
}

-(void) productReviewCommentServiceDone:(NSMutableDictionary*) responseDataDict
{
    
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
    NSMutableArray *productDetailsResponse;
    NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    debug(@"prod desc STR:%@ ",responseResultString);
    responseData = nil;
    SBJsonParser *jsonParser = [SBJsonParser new];
    
    // Parse the JSON into an Object		
    id data = [jsonParser objectWithString:responseResultString error:NULL];
    
    [responseResultString release];
    responseResultString = nil;
    
    //Release SBJSon Object
    [jsonParser release];
    jsonParser = nil;
    //Added
    NSDictionary *tempArray = [NSDictionary dictionaryWithDictionary:data];
    NSMutableArray *ValueID =  [[NSMutableArray alloc]init];
    NSDictionary *tempReview = [tempArray objectForKey:@"review"];
    
    NSDictionary *tempComments = [NSDictionary dictionaryWithDictionary:tempReview];
    productDetailsResponse =  [[NSMutableArray alloc]init];
    ValueID =  [tempComments objectForKey:@"comments"];
    
    
    for (tempComments in ValueID) {
        
        NSMutableString *strComment=[[NSMutableString alloc]init];
        NSMutableString *strDate=[[NSMutableString alloc]init];
        NSMutableString *strRating=[[NSMutableString alloc]init];
        NSMutableString *strUser=[[NSMutableString alloc]init];
        
        strComment = [tempComments objectForKey:@"comment"];
        strDate = [tempComments objectForKey:@"commentDate"];
        strRating = [tempComments objectForKey:@"rating"];
        strUser = [tempComments objectForKey:@"user"];
        [productDetailsResponse addObject:[tempComments copy]];
        
        
        [strComment retain];
        [strComment release];
        
        [strDate retain];
        [strDate release];
        
        [strRating retain];
        [strRating release];
        
        [strUser retain];
        [strUser release];
        
    }//Ended for new portal
    
    
    [self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
    
    [ValueID retain];
    [ValueID release];
    
    [productDetailsResponse retain];
    [productDetailsResponse release];
}


@end
