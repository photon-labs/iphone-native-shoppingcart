//
//  DataModelEntities.m
//  iShop3.0
//
//  Created by Admin on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "ConnectionManager.h"
#import "Constants.h"
#import "DictionaryUtils.h"
#import "PhrescoAppDelegate.h"
#import "RootViewController.h"
#import "UIImage-NSCoding.h"
#import "DebugOutput.h"
#import "ConfigurationReader.h"

#define MIN_ASSETS_COUNT 4
#define ASSETS_PER_FEATURE 2
#define EMPTY_STRING [NSString stringWithString:@""]

static int featureAssetsCounter = 0;
static int extraAssetsCounter = 0;


@implementation FeaturedAsset

@synthesize featureName;
@synthesize defaultIconUrl;
@synthesize defaultTabUrl;
@synthesize defaultHighlightedTabUrl;
@synthesize featureUrl;
@synthesize deepLinkPatternMatch;
@synthesize imagesDict;
@synthesize isInTabbar;
@synthesize viewControler;

- (id)init {
	self = [super init];
	
	if (self) {
		featureName					= [[NSString alloc] init];
		defaultIconUrl				= [[NSString alloc] init];
		defaultTabUrl				= [[NSString alloc] init];
		defaultHighlightedTabUrl	= [[NSString alloc] init];
        featureUrl                  = [[NSString alloc] init];
        deepLinkPatternMatch        = [[NSString alloc] init];
		imagesDict					= [[NSMutableDictionary alloc] init];
		isDownloaded				= NO;
		sortWeight					= -1;
        viewControler               = nil;
	}
	return self;
}

- (id) initWithCoder: (NSCoder *)coder
{
    
	if ((self = [super init]))
    {
        //[self set: [coder decodeObjectForKey:self.featureName]];
		//obj = [coder decodeObjectForKey:self.featureName];
		//[self setFeatureName:[coder decodeObjectForKey:@"featureName"]];
		// AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
		
		if (nil != [coder decodeObjectForKey:kfeatureName]) {
			
			self.featureName = [coder decodeObjectForKey:kfeatureName];
			self.defaultIconUrl = [coder decodeObjectForKey:kdefaultIcon];
			self.defaultTabUrl = [coder decodeObjectForKey:kdefaultTab];
			self.defaultHighlightedTabUrl = [coder decodeObjectForKey:khighlightedTab];
			self.imagesDict = [coder decodeObjectForKey:kImagesDict];
			self.featureUrl = [coder decodeObjectForKey:kfeatureUrl];
            
            if ([self.deepLinkPatternMatch length] > 0) {            
                self.deepLinkPatternMatch = [coder decodeObjectForKey:kdeepLinkPatternMatch];
            }
            
		}
    }
	
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	//AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;

    [coder encodeObject:self.featureName forKey:kfeatureName];
	[coder encodeObject:self.defaultIconUrl forKey:kdefaultIcon];
	[coder encodeObject:self.defaultTabUrl forKey:kdefaultTab];
	[coder encodeObject:self.defaultHighlightedTabUrl forKey:khighlightedTab];
	[coder encodeObject:self.imagesDict forKey:kImagesDict];
	[coder encodeObject:self.featureUrl forKey:kfeatureUrl];
    [coder encodeObject:self.deepLinkPatternMatch forKey:kdeepLinkPatternMatch];    
}


- (void)setProperties:(NSDictionary*) dict {

    if (nil != dict) {
        
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
        //if(filePath)
        //{
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
           // NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        int j=0;
        for (int i=0; i<[configReader.stories count]; i++) {
            NSLog(@"i:%d",i);
            NSString *strName = [[configReader.stories objectAtIndex: i] objectForKey:@"name"];
            NSLog(@"strName:%@",strName);
            if ([strName isEqualToString: @"eshop"]) {
                j=i;
                NSLog(@"j:%d",j);
            }
        }
        NSLog(@"jj:%d",j);
            
        NSString *protocol = [[configReader.stories objectAtIndex: j] objectForKey:kwebserviceprotocol];
        protocol = [protocol stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
        NSString *host = [[configReader.stories objectAtIndex: j] objectForKey:kwebservicehost];
        host = [host stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
        NSString *port = [[configReader.stories objectAtIndex: j] objectForKey:kwebserviceport];
        port = [port stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
        NSString *context = [[configReader.stories objectAtIndex: j] objectForKey:kwebservicecontext];
        context = [context stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
            NSString *imageAppendPath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
        
            self.featureUrl = [dict objectForKey:kfeatureUrl];
        
            self.featureName = [dict objectForKey:kName];

            self.defaultHighlightedTabUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@",protocol,host,port,context,imageAppendPath, [[dict objectForKey:kfeatureIcon] objectForKey:khighlightedTab]];

        NSLog(@"self.defaultHighlightedTabUrl: %@",self.defaultHighlightedTabUrl);
        //self.defaultIconUrl = [[dict objectForKey:kfeatureIcon] objectForKey:kdefaultIcon];
        

            self.defaultTabUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@",protocol,host,port,context,imageAppendPath, [[dict objectForKey:kfeatureIcon] objectForKey:kdefaultTab]];        
            
       // }
    }
}

-(void) dealloc
{
	[featureName release];
	
	[defaultIconUrl release];
	
	[defaultTabUrl release];
	
	[defaultHighlightedTabUrl release];
	
    [featureUrl release];
    
    [deepLinkPatternMatch release];
    
	[imagesDict release];
    
	[super dealloc];
}
@end


@implementation ExtraAssets

@synthesize imageName;
@synthesize imageUrl;

- (id)init {
	self = [super init];
	
	if (self) {
		imageName = [[NSString alloc] init];
		imageUrl = [[NSString alloc] init];
	}
	return self;
}


- (void)setProperties:(NSDictionary*) dict
{
	if (nil != dict) {
		
        self.imageName = [dict objectForKey:@"name"];
        
        self.imageUrl = [dict objectForKey:@"urlValue"];
	}
}

- (void) dealloc{
	
	[imageName release];
	[imageUrl release];
	[super dealloc];

}

@end

@implementation AssetsDataEntity

@synthesize assets;
@synthesize appInfo;
@synthesize featureLayout;
@synthesize extraAssets;
@synthesize headerImagesDict;
@synthesize catalogDictionary;
@synthesize catalogArray;
@synthesize productArray;
@synthesize productDetailArray;
@synthesize dictCart;
@synthesize arrayAddtoCart;
@synthesize productReviewArray;
@synthesize specialProductsArray;
@synthesize searchProductsArray;
@synthesize keyValueArray;
@synthesize reviewCommentsArray;

- (id) init {
	
	self = [super init]; 

	assets = [[NSMutableArray alloc] init];
	
	extraAssets = [[NSMutableArray alloc] init];
	
	headerImagesDict = [[NSMutableDictionary alloc] init];
	
	appInfo = [[NSMutableDictionary alloc] init];
	
	featureLayout = [[NSArray alloc] init];
    
    catalogDictionary = [[NSMutableDictionary alloc] init];
    
    catalogArray = [[NSMutableArray alloc] init];
	
    productArray = [[NSMutableArray alloc] init];
    
    productDetailArray = [[NSMutableArray alloc] init];
    
    dictCart = [[NSMutableDictionary alloc]init];
    
    arrayAddtoCart = [[NSMutableArray alloc]init];
    
    productReviewArray = [[NSMutableArray alloc] init];
    
    specialProductsArray =[[NSMutableArray alloc] init];
    
    searchProductsArray = [[NSMutableArray alloc] init];
    
     keyValueArray = [[NSMutableArray alloc]init];
    
    reviewCommentsArray =[[NSMutableArray alloc] init];
    
	return self;

}

-(void) dealloc
{
	[assets release];
		
	[extraAssets release];
	
	[headerImagesDict release];
	
	[appInfo release];
	
	[featureLayout release];
    
    [catalogDictionary release];
    
    [catalogArray release];
    
    [productArray release];
	
    [productDetailArray release];
    
    [productReviewArray release];
    
    [reviewCommentsArray release];

	[super dealloc];
}


/////////////////////////////////////////////////////////////////////////////////////////
//updateExtraAssetsModel
//
//Description:  Update header and background assets after retriving image URL's from App config Dict
//
// IN:  (id) data   -  app config Response Data
//
// Out: None
//
// This func fills the extraAssetsDict with image data
//////////////////////////////////////////////////////////////////////////////////////////

-(void) updateExtraAssetsModel:(NSDictionary*)data{
	
	if(nil != data)
	{
		NSArray *extraAssetsArray = [data objectForKey:@"headerAssets"];
		
		for(int i = 0; i < [extraAssetsArray count]; i++)
		{
			NSDictionary *assetProperties = (NSDictionary*)[extraAssetsArray objectAtIndex:i];
			
			ExtraAssets *asset = [[ExtraAssets alloc] init];
			
			[asset setProperties:assetProperties];
			
			AssetsDataEntity *assetsEntity = [[SharedObjects sharedInstance] assetsDataEntity];
			
			// add FeaturedAsset objects to Data model Array
			[assetsEntity.extraAssets addObject:asset];
			
			[asset release];
			
			asset = nil;
		}
			
	}
}

/////////////////////////////////////////////////////////////////////////////////////////
//updateFeaturedAssetModel
//
//Description:  Update All tabbbar and more page assets after retriving image URL's from App config Dict
//
// IN:  (id) data   -  app config Response Data
//
// Out: None
//
// This func fills the extraAssetsDict with image data
//////////////////////////////////////////////////////////////////////////////////////////

-(void) updateFeaturedAssetModel:(NSDictionary*)data {

	if(nil != data)
	{
		NSArray *featureLayoutArray = [data objectForKey:kfeatureLayout];
		
		// for every feature in the layout, fetch the featureProperties and set them in data model
		for( NSString *feature in featureLayoutArray)
		{
//            //accessing eg:  "featureConfig->"Home "
//			NSMutableDictionary *featureProperties = [[data objectForKey:kfeatureConfig] objectForKey:feature];
//			
//			// add featureName to the featureProperties dictionary
//			[featureProperties setObject:feature forKey:kfeatureName];
//			
//			FeaturedAsset *featuredAsset = [[FeaturedAsset alloc] init];
//			
//			[featuredAsset setProperties:(NSDictionary*)featureProperties];
//			
//			AssetsDataEntity *assetsEntity = [[SharedObjects sharedInstance] assetsDataEntity];
//			
//			// add FeaturedAsset objects to Data model Array
//			[assetsEntity.assets addObject:featuredAsset];
//			
//			[featuredAsset release];
//			
//			featuredAsset = nil;
            
            
            NSMutableArray *featureConfigArray = [data objectForKey:kfeatureConfig];
            NSLog(@"featureConfigArray:%@",[featureConfigArray description]);
            for(int i = 0; i<[featureConfigArray count]; i++)
            {
                NSString *featureName = [[[data objectForKey:kfeatureConfig] objectAtIndex:i] objectForKey:kName];
                
                if([featureName isEqualToString:feature])
                {
                    FeaturedAsset *featuredAsset = [[FeaturedAsset alloc] init];
                    
                    [featuredAsset setProperties:[featureConfigArray objectAtIndex:i]];
                    
                    AssetsDataEntity *assetsEntity = [[SharedObjects sharedInstance] assetsDataEntity];
                    			
                    // add FeaturedAsset objects to Data model Array
                    [assetsEntity.assets addObject:featuredAsset];
                    
                    [featuredAsset release];
                    
                    featuredAsset = nil;
                    
                }
            }
		
		}	
	}
}

- (void)updatedAppFeatureLayout:(NSDictionary*)dict {
	   
    self.featureLayout = [dict objectForKey:kfeatureLayout];
}

-(void) updateCatalogModel:(NSMutableArray*) data
{
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            CatalogService *catalogService = [[CatalogService alloc] init];
            
            [catalogService setProperties:[data objectAtIndex:i]];
            
            [self.catalogArray addObject:catalogService];
            
            [catalogService release];
            
            catalogService = nil;
                
        }
    }
}
//Starts here to display product details and description

-(void) updateProductModel:(NSMutableArray*) data
{
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            productDetailsService *Service = [[productDetailsService alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.productArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }
}

//Starts here to display product TV screen size
-(void) updateProductDetailsModel:(NSMutableArray*) data{
    
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            productService *Service = [[productService alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.productDetailArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }
}

-(void) updateProductReviewModel:(NSMutableArray*) data{
    
      
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            productReview *Service = [[productReview alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.productReviewArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }
}

-(void) updateSpecialproductsModel:(NSMutableArray*) data
{
    
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            specialProducts *Service = [[specialProducts alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.specialProductsArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }

    
}


-(void) updateSearchProductsModel:(NSMutableArray *)data
{
  
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            
            searchProducts *Service = [[searchProducts alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.searchProductsArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }
    
    
}

-(void) updateReviewCommentsModel:(NSMutableArray *)data
{
       
    if(nil != data)
    {
        for(int i = 0; i<[data count]; i++)
        {
            
            ReviewComment *Service = [[ReviewComment alloc] init];
            
            [Service setProperties:[data objectAtIndex:i]];
            
            [self.reviewCommentsArray addObject:Service];
            
            [Service release];
            
            Service = nil;
            
        }
    }
}
//
/////////////////////////////////////////////////////////////////////////////////////////
// Method: indexOfAssetWithName
//
// Description: 
//
// Argument: name of feature 
//
// Returns: index of feature
//
//////////////////////////////////////////////////////////////////////////////////////////

- (int)indexOfAssetWithName:(NSString*)name {
	
    int index = -1;
    //NSLog(@"name:%@", name);
    if (nil != name) {
        
        if ([featureLayout count] > 0) {
            
            index = [featureLayout indexOfObject:name];
        }
    }
    
    return index;
}

/////////////////////////////////////////////////////////////////////////////////////////
// Method: indexOfAssetWithName
//
// Description: 
//
// Argument: name of feature 
//
// Returns: index of feature
//
//////////////////////////////////////////////////////////////////////////////////////////

- (NSString*)featureNameWithIndex:(NSInteger)index {
	
    NSString *name = @"";
    
    if (index >= 0) {
        
        if ([featureLayout count] > 0) {
            
            name = [featureLayout objectAtIndex:index];
        }
    }
    
    return name;
}

/////////////////////////////////////////////////////////////////////////////////////////
// Method: isFeatureNative
//
// Description: finds whether given feature name is of type native/web
//
// Argument: name of feature 
//
// Returns: true or false 
//
//////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)isFeatureNative:(NSString*)name {
	
    BOOL native = NO;
    if (nil != name) {
        
        int index = [self indexOfAssetWithName:name];

        if ([self.assets count] > index) {
            
            NSString *featureUrl = [[self.assets objectAtIndex:index] featureUrl];
            
            if (![featureUrl compare:@"NATIVE" options:NSCaseInsensitiveSearch]) {
                native = YES;
            }
        }
    }
    
    return native;
}

/////////////////////////////////////////////////////////////////////////////////////////
// Method: objectForAssetName
//
// Description: returns the FeaturedAsset object for a given feature name. 
// e.g. if pass "Home" as feature name, method will return corresponding featureAsset object
//
// Argument - (NSString*)name: name of feature 
//
// Returns: object of kind FeaturedAsset
//
//////////////////////////////////////////////////////////////////////////////////////////

- (FeaturedAsset*)objectForAssetName:(NSString*)name {
	
    id featuredAsset = nil;
    
    if (nil != name) {
        
        featuredAsset = [assets objectAtIndex:[self indexOfAssetWithName:name]];
    }
    
    return featuredAsset;
}


/**************************************************************************************************************
 createButton
 
 desc:  Creates a button based on the title given. The titles indexes  are referenced from 
 in  moreButtonIndexArray & tabButtonIndexArray.
 with this index, the images are referenced from imageDictionary.
 
 in:
 
 (NSString*)name : Feature name
 
 (BOOL)addWiggle : Should wiggle be added to the icon
 **************************************************************************************************************/

- (UIButton*) createButton:(NSString*)name willAddWiggle:(BOOL)addWiggle
{
	RootViewController *rootVC = [ (iShopAppDelegate*)[[UIApplication sharedApplication] delegate] viewController];
	
	UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
	
	//Check get button index  for setting tab value....
    int index;
    
    index = [self indexOfAssetWithName:name];
    
	//set bkg img    
    UIImage *image = [[[self.assets objectAtIndex:index] imagesDict] objectForKey:kdefaultTab];
	
    [button setBackgroundImage:image forState:UIControlStateNormal];
	
	//set title name eg. "Home"to button name
	button.titleLabel.text = name;
	
	//If index is less than five then feature is in tabbar
	//else that feature is in more page
	BOOL isInTabbar = (index < 5) ? YES : NO;	
	
	if (isInTabbar) {
		//set button tag ofset by button index
		index += kTabbarTagOffset;
		
		[button addTarget:rootVC action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];     
	}
	else {
		
		//set button tag ofset by button index
		index += kTabbarTagOffset;
		
		[button addTarget:rootVC action:@selector(moreButtonsAction:) forControlEvents:UIControlEventTouchUpInside];
		
	}
	
	//set tag
	[button setTag:index];
	
	
	return button;	
}


/////////////////////////////////////////////////////////////////////////////////////////
// Method: getTabbarAssets
//
// Description: Returns All tabbbar assets 
//
// Argument: None 
//
// Returns: dictionary of objects of kind FeaturedAsset
//
//////////////////////////////////////////////////////////////////////////////////////////

- (NSDictionary*)getTabbarAssets {
    
    NSMutableDictionary *tabbarAssets = [NSMutableDictionary dictionary];
    @try {
        
        if ([featureLayout count] > 0) {
			
            //Add objects with keys named in featureLayout array, from index 0 to 4. That will fetch the assets for tabbar
            for (int i = 0; i < 5; i++) {
                
				NSString *key = [featureLayout objectAtIndex:i];
				
                [tabbarAssets setObject:[self objectForAssetName:key] forKey:key];
				
				[[self objectForAssetName:key] setIsInTabbar:YES];            
            }
			
        }
    }
    @catch (NSException *exception) {
        debug(@"exception:%@", [exception reason]);
    }
    NSLog(@"getTabbarAssets : \t%@", tabbarAssets);

    return tabbarAssets;
}

/////////////////////////////////////////////////////////////////////////////////////////
// Method: getMorePageAssets
//
// Description: Return All more page assets 
//
// Argument: None 
//
// Returns: dictionary of objects of kind FeaturedAsset
//
//////////////////////////////////////////////////////////////////////////////////////////

- (NSDictionary*)getMorePageAssets {
    
    NSMutableDictionary *morePageAssets = [NSMutableDictionary dictionary];
    
    @try {
        
        if ([featureLayout count] > 0) {
            
            //Add objects with keys named in featureLayout array, from index 5 to count of featureLayout. That will fetch the assets for more page
            for (int i = 5; i < [featureLayout count]; i++) {
                
				NSString *key = [featureLayout objectAtIndex:i];
				
                [morePageAssets setObject:[self objectForAssetName:key] forKey:key];
				
				[[self objectForAssetName:key] setIsInTabbar:NO];            
            }
            
        }
    }
    @catch (NSException *exception) {
        debug(@"exception:%@", [exception reason]);
    }
    
    return morePageAssets;
}

- (void)swapFeatureFromMorePage:(UIButton*)morePageFeature toTabbar:(UIButton*) tabbarFeature {

    if (nil != morePageFeature && nil != tabbarFeature) {
        NSString *morePageFeatureTitle = [[morePageFeature titleLabel] text];
        NSString *tabbarFeatureTitle = [[tabbarFeature titleLabel] text];
        
        //swap features in featureLaout array
        int index1 = [self indexOfAssetWithName:morePageFeatureTitle];
        int index2 = [self indexOfAssetWithName:tabbarFeatureTitle];
        [(NSMutableArray*)featureLayout exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
       
        //swap featureAsset in assets array
        [self.assets exchangeObjectAtIndex:index1 withObjectAtIndex:index2];

        //change isInTabbar property of both feature
        BOOL isInTabbar1 = [[self.assets objectAtIndex:index1] isInTabbar];
        BOOL isInTabbar2 = [[self.assets objectAtIndex:index2] isInTabbar];
        [[self.assets objectAtIndex:index1] setIsInTabbar:!isInTabbar1];
        [[self.assets objectAtIndex:index1] setIsInTabbar:!isInTabbar2];
        
        //swap tags
        int tag1 = morePageFeature.tag;
        int tag2 = tabbarFeature.tag;
        
        morePageFeature.tag = tag2;
        tabbarFeature.tag = tag1;
        
        //remove wiggling behavior, if it has any and add wiggling behavior to other one
    }    
}

/////////////////////////////////////////////////////////////////////////////////////////
//startLoadingFeaturedAssets
//
//Description:  Update All tabbbar and more page assets after retriving image URL's from App config Dict
//
// IN:  (id) data   -  a FeaturedAsset object which has images to download
//
// Out: None
//
// This func starts loading the images from given featured asset
//////////////////////////////////////////////////////////////////////////////////////////

- (void)startLoadingFeaturedAssets:(id)object {
	
	if (nil != object) {
		
		if ([object isKindOfClass:[FeaturedAsset class]]) {
			
			FeaturedAsset *asset = (FeaturedAsset*)object;
			
			NSString *defaultIconUrl = asset.defaultIconUrl;
			
			NSString *defaultTabUrl = asset.defaultTabUrl;
			
			NSString *defaultHighlightedTabUrl = asset.defaultHighlightedTabUrl;
			
			//NSString *callbackID1 = [NSString stringWithFormat:@"%@-%@",
//									[asset featureName], kdefaultIcon];
			
			NSString *callbackID2 = [NSString stringWithFormat:@"%@-%@",
									 [asset featureName], kdefaultTab];
			
			NSString *callbackID3 = [NSString stringWithFormat:@"%@-%@",
									 [asset featureName], khighlightedTab];
			
			//mini_dbg(@"start with counter: %d", featureAssetsCounter);
			mini_dbg(@"start Image Downloads: %@", [asset featureName]);

			
			// send callback as dictionary of format {key:"Home-defaultIcon", targetDict:assetObject}
			//NSDictionary *callBack1 = [NSDictionary dictionaryWithObjectsAndKeys:callbackID1,@"key",asset,@"targetDict",nil];

			NSDictionary *callBack2 = [NSDictionary dictionaryWithObjectsAndKeys:callbackID2,@"key",asset,@"targetDict",nil];

			NSDictionary *callBack3 = [NSDictionary dictionaryWithObjectsAndKeys:callbackID3,@"key",asset,@"targetDict",nil];

			//[[ConnectionManager sharedConnections] serviceCallWithURL:defaultIconUrl
//															 httpBody:@"" 
//														   httpMethod:@"GET" 
//													   callBackTarget:self 
//													 callBackSelector:@selector(finishLoadingImages:)
//														   callBackID:callBack1];		

			[[ConnectionManager sharedConnections] serviceCallWithURL:defaultTabUrl
															 httpBody:@"" 
														   httpMethod:@"GET" 
													   callBackTarget:self 
													 callBackSelector:@selector(finishLoadingImages:)
														   callBackID:callBack2];		

			[[ConnectionManager sharedConnections] serviceCallWithURL:defaultHighlightedTabUrl
															 httpBody:@"" 
														   httpMethod:@"GET" 
													   callBackTarget:self 
													 callBackSelector:@selector(finishLoadingImages:)
														   callBackID:callBack3];		
			
		}
	}
}

-(void) finishLoadingImages:(NSMutableDictionary*) responseDataDict
{
	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	// retrieve the callbackID and Asset object from the callback dictionary
	NSDictionary *callbackID = [responseDataDict objectForKey:kConnectionCallbackID];
	
	NSString *key = (NSString*) [callbackID objectForKey:@"key"];
	
	FeaturedAsset *asset = (FeaturedAsset*) [callbackID objectForKey:@"targetDict"];
	
	// parse the callbackID and retrieve the FeatureName and selector
	NSArray *split = [key componentsSeparatedByString:@"-"];
	
	NSString *name = @"";
	NSString *sel = @"";
	
	if (nil != split) {
		
		if ([split count] > 1) {
			name = [split objectAtIndex:0];
			sel = [split objectAtIndex:1];
		}
	}
		
	UIImage *image = [[UIImage alloc] initWithData:responseData];
	
	if (nil != image) {
								
		//set the image to the dictionary of the FeaturedAsset
		[[asset imagesDict] setObject:image forKey:sel];
			
		//mini_dbg(@"end with callback id: %@, counter:%d", callbackID, featureAssetsCounter);
		mini_dbg(@"Completed imageDownload:%@", key);
		featureAssetsCounter++;
		mini_dbg(@"featureAssetsCounter:%d/%d", featureAssetsCounter, ([featureLayout count] * ASSETS_PER_FEATURE));
		
		if(featureAssetsCounter == ([featureLayout count] * ASSETS_PER_FEATURE)) {
			[[NSNotificationCenter defaultCenter] postNotificationName:kAllAssetsDownloadedNotification object:NULL];
			featureAssetsCounter = 0;
		}
	}
	
	[image release];
	image = nil;
}

/////////////////////////////////////////////////////////////////////////////////////////
//startLoadingExtraAssets
//
//Description:  Update header and background assets after retriving image URL's from App config Dict
//
// IN:  (id) data   -  an ExtraAsset object which has images to download
//
// Out: None
//
// This func starts loading the images from given featured asset
//////////////////////////////////////////////////////////////////////////////////////////

- (void)startLoadingExtraAssets:(id)object {

	if(nil != object)
	{
		if([object isKindOfClass:[ExtraAssets class]])
		{
			ExtraAssets *extraAsset = (ExtraAssets*)object;
		
			NSString *imageName = extraAsset.imageName;
			
			NSString *imageUrl = extraAsset.imageUrl;
		
			NSString *callbackID = [NSString stringWithFormat:@"%@",imageName];
			
			NSDictionary *callBack = [[NSDictionary alloc] initWithObjectsAndKeys:callbackID,@"key",extraAsset,@"targetDict",nil];

			[[ConnectionManager sharedConnections] serviceCallWithURL:imageUrl
															 httpBody:@"" 
														   httpMethod:@"GET" 
													   callBackTarget:self 
													 callBackSelector:@selector(finishLoadingExtraImages:)
														   callBackID:callBack];	
			
		}
	
	}

}

-(void) finishLoadingExtraImages:(NSMutableDictionary*) responseDataDict {

	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];

	// retrieve the callbackID and Asset object from the callback dictionary
	NSDictionary *callbackID = [responseDataDict objectForKey:kConnectionCallbackID];

	NSString *key = (NSString*) [callbackID objectForKey:@"key"];
	
	UIImage *image = [[UIImage alloc] initWithData:responseData];
	
	if (nil != image) {
		
		[self.headerImagesDict setObject:image forKey:key];
		
		//mini_dbg(@"end with callback id: %@, counter:%d", callbackID, featureAssetsCounter);
		mini_dbg(@"Completed imageDownload:%@", key);
		extraAssetsCounter++;
		//mini_dbg(@"featureAssetsCounter:%d/%d", featureAssetsCounter, ([featureLayout count] * ASSETS_PER_FEATURE));
		
		if(extraAssetsCounter == [self.extraAssets count]) {
			[[NSNotificationCenter defaultCenter] postNotificationName:kExtraAssetsDownloadedNotification object:nil];
		}
		
	}
	
	[image release];
	image = nil;
	
}

@end

@implementation AppInfoEntity

@synthesize appVersion, configVersion, configDict, supportedVersions, versionUpdateUrl;
////// Support ///////////
@synthesize appLaunchTime, appPushbackTime, appActivatedTime;
@synthesize appServiceCallTime, appConfigUpdateTime, serviceName;
@synthesize featureName, deviceToken, configResponseString, configEndpoint;


- (id) init {
	
	self = [super init];
	
	if (self) {
		appVersion = [[NSString alloc] init];
		
		configVersion = [[NSString alloc] init];
		
		configDict = [[NSDictionary alloc] init];
		
		supportedVersions = [[NSArray alloc] init];
		
		versionUpdateUrl = [[NSString alloc] init];
		
		///// Support //////////////
		appLaunchTime = [[NSDate alloc] init];
		
		appPushbackTime = [[NSDate alloc] init];
		
		appActivatedTime = [[NSDate alloc] init];
		
		appServiceCallTime = [[NSDate alloc] init];
		
		appConfigUpdateTime = [[NSDate alloc] init];
		
		serviceName = [[NSString alloc] init];
		
		featureName = [[NSString alloc] init];
		
		deviceToken = [[NSString alloc] init];
		
		configResponseString = [[NSString alloc] init];
		
		configEndpoint = [[NSString alloc] init];
		///////////////////////////////
	}	
	
	return self;
	
}

-(void) dealloc
{
	[super dealloc];

	[appVersion release];
	
	[configVersion release];
	
	[configDict release];
	
	[supportedVersions release];
	
	[versionUpdateUrl release];
	
	///// Support //////////////
	[appLaunchTime release];
	
	[appPushbackTime release];
	
	[appActivatedTime release];
	
	[appServiceCallTime release];
	
	[appConfigUpdateTime release];
	
	[serviceName release];
	
	[featureName release];
	
	[deviceToken release];
	
	[configResponseString release];
	
	[configEndpoint release];
}

-(void) appInfoUpdate
{
	// cache the config file 

	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];

	NSMutableDictionary *configResponse = (NSMutableDictionary*)[appInfoEntity configDict];
	
	appInfoEntity.configVersion = (NSString*)[[configResponse objectForKey:kappConfig] objectForKey:@"configVersion"];

	appInfoEntity.appVersion = (NSString*)[[[configResponse objectForKey:kappConfig] objectForKey:kappVersionInfoDict] objectForKey:@"appVersionNumber"];

	appInfoEntity.versionUpdateUrl = (NSString*)[[[configResponse objectForKey:kappConfig] objectForKey:kappVersionInfoDict] objectForKey:@"appStoreLink"];
	
	appInfoEntity.supportedVersions = (NSArray*)[[[configResponse objectForKey:kappConfig] objectForKey:kappVersionInfoDict] objectForKey:@"supportedVersions"];
	
}

-(BOOL) isAppVersionSupported:(NSArray*)versions
{	
	if (nil != versions) {
		
		NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
				
		int index = [versions indexOfObject:currentVersion];
		
		if(index == NSNotFound)
		{
			return NO;
		}
	}
	
	return YES;
}

@end

////////////////USER PROFILE///////////
@implementation UserProfileEntity

@synthesize username,password;

-(void) dealloc{
    
	[username release];
	[password release];
	[super dealloc];
	
}
@end

@implementation CatalogService

@synthesize productId;
@synthesize productName;
@synthesize productImageUrl;
@synthesize productCount;
@synthesize catalogDict;


- (id) init {
	
	self = [super init];
	
	if (self) {
        
        productId = [[NSString alloc] init];
        
        productName = [[NSString alloc] init];
        
        productImageUrl = [[NSString alloc] init];
        
        productCount = [[NSString alloc] init];
        
        catalogDict =[[NSArray alloc] init];
    }	
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    if(nil != dictionary)
    {
       // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
        /*if(filePath)
        {*/
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
            
            NSString *imagePath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
            
            self.productId = [dictionary objectForKey:kCatalogId];
            
            self.productName = [dictionary objectForKey:kCatalogName];
            
            self.productCount = [dictionary objectForKey:kCatalogCount];
            
            self.productImageUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@%@", protocol,host, port, context,imagePath,[dictionary objectForKey:kCatalogImage]]; 
            self.catalogDict = [NSArray arrayWithObject:dictionary];
       // }
    }
}

-(void) dealloc
{
    [productId release];
    
    [productName release];
    
    [productImageUrl release];
    
    [productCount release];
    
	[super dealloc];
}


@end


//////////product Details implementation

@implementation productDetailsService

@synthesize  productDetailId;
@synthesize  productDetailName;
@synthesize  productDetailImageUrl;
@synthesize productRatingView;
@synthesize productDetailsPrice;

- (id) init {
	
	self = [super init];
	
	if (self) {
        
         productDetailId = [[NSString alloc] init];
        
         productDetailName = [[NSString alloc] init];
        
         productDetailImageUrl = [[NSString alloc] init];
        
        productDetailsPrice = [[NSString alloc] init];
        
        productRatingView   = [[NSString alloc] init];
    }	
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    if(nil != dictionary)
    {
       // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
        /*if(filePath)
        {*/
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
            
            NSString *imagePath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
                                    
            self.productDetailId = [dictionary objectForKey:kProductId];
            
            self.productDetailName = [dictionary objectForKey:kProductName];
            
            self.productDetailImageUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@%@", protocol,host, port, context,imagePath,[dictionary objectForKey:kproductImage]];
             
           self.productDetailsPrice = [dictionary objectForKey:kproductPrice];
            
            self.productRatingView = [dictionary objectForKey:kproductRating];
            
        //}
    }
}

-(void) dealloc
{
    [productDetailId release];
    
    [productDetailName release];
    
    [productDetailImageUrl release];
    
    [productDetailsPrice release];
    
    [productRatingView release];
    
	[super dealloc];
}


@end

//////////product implementation

@implementation productService

@synthesize  productDetailId;
@synthesize  productDetailName;
@synthesize  productDetailImageUrl;
@synthesize productRatingView;
@synthesize productDescription;
@synthesize productDetailsPrice;
@synthesize productTVType;
@synthesize productScreen;
@synthesize productRatio;
@synthesize productDefinition;

- (id) init {
	
	self = [super init];
	
	if (self) {
        
        productDetailId = [[NSString alloc] init];
        
        productDetailName = [[NSString alloc] init];
        
        productDetailImageUrl = [[NSString alloc] init];
        
        productDetailsPrice = [[NSString alloc] init];
        
        productRatingView   = [[NSString alloc] init];
        
        productDescription  = [[NSString alloc] init];
        
        productTVType = [[NSString alloc] init];
        
        productScreen = [[NSString alloc] init];
        
        productRatio   = [[NSString alloc] init];
        
        productDefinition  = [[NSString alloc] init];
    }	
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    if(nil != dictionary)
    {
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
        /*if(filePath)
        {*/
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
            
            NSString *imagePath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
            
                        
            self.productDetailId = [dictionary objectForKey:kProductId];
            
            self.productDetailName = [dictionary objectForKey:kProductName];
            
            self.productDetailImageUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@%@", protocol,host, port, context,imagePath,[dictionary objectForKey:kproductImage]];
            
            self.productDetailsPrice = [dictionary objectForKey:kproductPrice];
            
            self.productRatingView = [dictionary objectForKey:kproductRating];
            
            self.productDescription = [dictionary objectForKey:kproductDesc];
            
            self.productTVType = [dictionary objectForKey:kproductTVType];
            
            self.productScreen = [dictionary objectForKey:kproductScreen];
            
            self.productRatio = [dictionary objectForKey:kProductRatio];
            
            self.productDefinition = [dictionary objectForKey:kProductDefinition];
            
            
        //}
    }
}

-(void) dealloc
{
    [productDetailId release];
    
    [productDetailName release];
    
    [productDetailImageUrl release];
    
    [productDetailsPrice release];
    
    [productRatingView release];
    
	[super dealloc];
}
@end
//////////product implementation

@implementation productReview

@synthesize  productDetailId;

@synthesize userComments; 

@synthesize productRatingView;

@synthesize averageCustomerReview;

@synthesize ratingKey;

@synthesize ratingValue;

@synthesize userName;

@synthesize commentedDate;

@synthesize productRevUserID;

- (id) init {
	
	self = [super init];
	
	if (self) {
        
        productDetailId = [[NSString alloc] init];
        
        userComments = [[NSString alloc] init];
        
        productRatingView   = [[NSString alloc] init];
        
        averageCustomerReview = [[NSString alloc] init];
        
        ratingKey = [[NSString alloc] init];
        
        ratingValue = [[NSString alloc] init];
        
        userName = [[NSString alloc] init];
        
        commentedDate = [[NSString alloc] init];
        
        productRevUserID = [[NSString alloc] init];
    }
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    //NSLog(@"Dictionary:%@",dictionary);
    /*if(nil != dictionary)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        
        if(filePath)
        {*/
            
            self.productDetailId = [dictionary objectForKey:kProductId];
            
            self.averageCustomerReview = [dictionary objectForKey:kaverage];
          
            self.userComments = [dictionary objectForKey:kuserComments];
            
            self.productRatingView = [dictionary objectForKey:kproductRating];
            
            self.ratingKey = [dictionary objectForKey:kkey];
            
            self.ratingValue = [dictionary objectForKey:kvalue];
            
            self.userName = [dictionary objectForKey:kuserName];
            
            self.commentedDate =[dictionary objectForKey:kCommentedDate];
            
            self.productRevUserID = [dictionary objectForKey:kuserId];
        //}
   // }
}

-(void) dealloc
{
    [productDetailId release];
    
    [averageCustomerReview release];
    
    [userComments release];
    
    [productRatingView release];
    
    [ratingKey release];
    
    [ratingValue release];
    
    [commentedDate release];
    
    [userName release];
    
	[super dealloc];
}

@end


@implementation specialProducts

@synthesize specialProductId;
@synthesize specialProductName;
@synthesize specialProductPrice;
@synthesize specialProductImageUrl;
@synthesize specialProductRatingView;
@synthesize specialProductDesc;

- (id) init {
	
	self = [super init];
	
	if (self) {
        
        specialProductId = [[NSString alloc] init];
        
        specialProductName= [[NSString alloc] init];
        
        specialProductImageUrl   = [[NSString alloc] init];
        
        specialProductRatingView = [[NSString alloc] init];
        
        specialProductPrice = [[NSString alloc] init];
        
        specialProductDesc =[[NSString alloc] init];

    }
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    
    if(nil != dictionary)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
       /* if(filePath)
        {*/
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
            
            NSString *imagePath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
            
            self.specialProductId = [dictionary objectForKey:kspecialProductId];
            
            self.specialProductName = [dictionary objectForKey:kspecialProductName];
            
            self.specialProductImageUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@%@", protocol,host, port, context,imagePath,[dictionary objectForKey:kspecialProductImage]];
            
            self.specialProductRatingView = [dictionary objectForKey:kspecialProductRating];
            
            self.specialProductPrice = [dictionary objectForKey:kspecialProductPrice];
            NSLog(@"self.specialProductPrice:%@",self.specialProductPrice);
            self.specialProductDesc = [dictionary objectForKey:kspecialProductDesc];
       // }
    }
}

-(void) dealloc
{
    [specialProductId release];
    
    [specialProductName release];
    
    [specialProductImageUrl release];
    
    [specialProductRatingView release];
    
    [specialProductPrice release];
    
    [specialProductDesc release];
   
	[super dealloc];
}


@end

@implementation searchProducts

@synthesize searchProductId;
@synthesize searchProductName;
@synthesize searchProductImageUrl;
@synthesize searchProductPrice;
@synthesize searchProductRatingView;

- (id) init {
	
	self = [super init];
	
	if (self) {
        
        searchProductId = [[NSString alloc] init];
        
        searchProductName= [[NSString alloc] init];
        
        searchProductImageUrl   = [[NSString alloc] init];
        
        searchProductPrice = [[NSString alloc] init];
        
        searchProductRatingView = [[NSString alloc] init];
        
       
    }
	
	return self;
	
}

-(void) setProperties:(NSMutableDictionary*) dictionary
{
    
    if(nil != dictionary)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"Config" environment:@"myWebservice"];
        
        /*if(filePath)
        {*/
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
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
            
            NSString *imagePath = [[assetsData.appInfo objectForKey:kiPhoneFeatureImagePaths] objectForKey:k3G];
            
            self.searchProductId = [dictionary objectForKey:kspecialProductId];
            
            self.searchProductName = [dictionary objectForKey:kspecialProductName];
            self.searchProductImageUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/%@%@", protocol,host, port, context,imagePath,[dictionary objectForKey:kspecialProductImage]];
            
            self.searchProductRatingView = [dictionary objectForKey:kspecialProductRating];
            
            self.searchProductPrice = [dictionary objectForKey:kspecialProductPrice];
       // }
    }
}

-(void) dealloc
{
    [searchProductId release];
    
    [searchProductName release];
    
    [searchProductImageUrl release];
    
    [searchProductRatingView release];
    
    [searchProductPrice release];
  
	[super dealloc];
}


@end


@implementation ReviewComment
    
    @synthesize reviewCommentProductId;
    @synthesize reviewCommentComment;
    @synthesize reviewCommentDate;
    @synthesize reviewCommentRating;
    @synthesize reviewCommentUserName;
    
    - (id) init {
        
        self = [super init];
        
        if (self) {
            
            reviewCommentProductId = [[NSString alloc] init];
            
            reviewCommentUserName= [[NSString alloc] init];
            
            reviewCommentComment   = [[NSString alloc] init];
            
            reviewCommentRating = [[NSString alloc] init];
            
            reviewCommentDate = [[NSString alloc] init];
            
            
        }
        
        return self;
        
    }
    
    -(void) setProperties:(NSMutableDictionary*) dictionary
    {
        
       /* if(nil != dictionary)
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
            
            if(filePath)
            {*/
                self.reviewCommentProductId = [dictionary objectForKey:kProductId];
                
                self.reviewCommentDate = [dictionary objectForKey:kCommentedDate];
                
                self.reviewCommentUserName = [dictionary objectForKey:kuserName];
                
                self.reviewCommentComment = [dictionary objectForKey:kuserComments];
                
                self.reviewCommentRating = [dictionary objectForKey:kproductRating];
           // }
       // }
    }
    
    -(void) dealloc
    {
                
        [reviewCommentRating release];
        
        [reviewCommentProductId release];
        
        [reviewCommentUserName release];
        
        [reviewCommentComment release];
        
        [reviewCommentDate release];
        
        [super dealloc];
    }
    
    
    @end



