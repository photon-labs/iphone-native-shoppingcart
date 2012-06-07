//
//  SharedObjects.m
//  iShop3.0
//
//  Created by Admin on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SharedObjects.h"
#import "DataModelEntities.h"

static SharedObjects *shardObjectsDelegate = nil;

@implementation SharedObjects

@synthesize assetsDataEntity;
@synthesize appInfoEntity;
@synthesize userProfileData;

- (id) init {
	self = [super init];	
	
	assetsDataEntity = [[AssetsDataEntity alloc] init];
	
	appInfoEntity = [[AppInfoEntity alloc] init];
	
	userProfileData = [[UserProfileEntity alloc] init];

	return self;
}

- (id)autorelease
{
    return self;
}

#pragma mark --
#pragma mark singleton object methods 
#pragma mark --

+ (SharedObjects *)sharedInstance {
    @synchronized(self) {
        if (shardObjectsDelegate == nil) 
		{
			shardObjectsDelegate= [[self alloc] init]; // assignment not done here
        }
    }
	
    return shardObjectsDelegate;
}

- (void) dealloc
{
	[assetsDataEntity release];
	
	[appInfoEntity release];
	
	[userProfileData release];
	
	[super dealloc];
}

@end
