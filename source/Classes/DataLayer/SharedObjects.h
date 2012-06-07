//
//  SharedObjects.h
//  iShop3.0
//
//  Created by Admin on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AssetsDataEntity;
@class AppInfoEntity;
@class UserProfileEntity;

@interface SharedObjects : NSObject {
	
	AssetsDataEntity *assetsDataEntity;
	
	AppInfoEntity *appInfoEntity;
	
	UserProfileEntity *userProfileData;

}

@property (nonatomic, assign) AssetsDataEntity *assetsDataEntity;

@property (nonatomic, assign) AppInfoEntity *appInfoEntity;

@property (nonatomic, assign) UserProfileEntity *userProfileData;

#pragma mark singleton object methods 

+ (SharedObjects *)sharedInstance;

@end
