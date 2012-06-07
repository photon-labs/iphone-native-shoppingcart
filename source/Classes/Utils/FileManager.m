//
//  FileManager.m
//  weddingregistry
//
//  Created by PHOTON on 14/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileManager.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "Constants.h"
#import "DebugOutput.h"

#define TMP NSTemporaryDirectory()


@implementation FileManager

#pragma mark -----------------
#pragma mark Utilitymethod for reading from file
#pragma mark -----------------

- (NSMutableData*) readDataForFile:(NSString*)fileName {
	// check whether the document directory is available or not
	NSString *documentsDirectoryPath = [self performSelector:@selector(tempDirectoryPath:) withObject:fileName];
	
	if ([[NSFileManager defaultManager] isReadableFileAtPath:documentsDirectoryPath]) {
		NSMutableData *data_ = [NSMutableData dataWithContentsOfFile:documentsDirectoryPath];
		
		return data_;
	}
	
	return nil;
	
}

#pragma mark -----------------
#pragma mark Utilitymethod for writing data to a file
#pragma mark -----------------

- (BOOL) writeData:(id)data_ toFile:(NSString*)fileName {
	// check whether the document directory is available or not
	NSString *documentsDirectoryPath = [self performSelector:@selector(tempDirectoryPath:) withObject:fileName];
	
	if ([[NSFileManager defaultManager] isWritableFileAtPath:documentsDirectoryPath]) {
		
		[data_ writeToFile:documentsDirectoryPath atomically:YES];
		return YES;
	}
	
	return NO;
}

- (NSString *)tempDirectoryPath:(NSString*)fileName {
	
    NSString *tempDirPath = [[self performSelector:@selector(applicationDocumentsDirectory)] stringByAppendingPathComponent:@"temp"];	
    
	BOOL isDir = NO;
	if (![[NSFileManager defaultManager] fileExistsAtPath:tempDirPath isDirectory:&isDir]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:tempDirPath attributes:nil];
		
		//[[NSFileManager defaultManager] createDirectoryAtPath:tempDirPath withIntermediateDirectories:YES attributes:nil error:NULL];
	}
	if (!isDir) {
		[[NSFileManager defaultManager] removeItemAtPath:tempDirPath error:nil];
		[[NSFileManager defaultManager] createDirectoryAtPath:tempDirPath attributes:nil];
		
		//[[NSFileManager defaultManager] createDirectoryAtPath:tempDirPath withIntermediateDirectories:YES attributes:nil error:NULL];
	}
	
	NSString *tempFilePath = [tempDirPath stringByAppendingPathComponent:fileName];
	
	if(![[NSFileManager defaultManager] isWritableFileAtPath:tempFilePath]){
		[[NSFileManager defaultManager] createFileAtPath:tempFilePath contents:nil attributes:nil];
	}
    return tempFilePath;
}

- (BOOL) writeImage:(id)data_ toFile:(NSString*)fileName {
	// check whether the document directory is available or not
	NSString *documentsDirectoryPath = [self performSelector:@selector(tempDirectoryPath:) withObject:fileName];
	
	if ([[NSFileManager defaultManager] isWritableFileAtPath:documentsDirectoryPath]) {
		
		UIImage *image = (UIImage*)data_;
		
		//[data_ writeToFile:documentsDirectoryPath atomically:YES];
		
		[UIImagePNGRepresentation(image) writeToFile: documentsDirectoryPath atomically: YES];
		
		return YES;
	}
	
	return NO;
}

/**
 Returns the path to the application's documents directory.
 */

- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (NSString *)directoryPath {
	
    NSString *tempDirPath = [[self performSelector:@selector(applicationDocumentsDirectory)] stringByAppendingPathComponent:@"temp"];
	
	return tempDirPath;
}

-(void) writeAssetsToCache
{
	AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
		
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:assetsData.assets];
	
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:kFeatureAssets];

	NSData *extraData = [NSKeyedArchiver archivedDataWithRootObject:assetsData.headerImagesDict];

	[[NSUserDefaults standardUserDefaults] setObject:extraData forKey:kExtraAssets];


	[[NSUserDefaults standardUserDefaults] setObject:assetsData.appInfo forKey:kAppInfo];
	
	[[NSUserDefaults standardUserDefaults] setObject:assetsData.featureLayout forKey:kfeatureLayout];
	
	[[NSUserDefaults standardUserDefaults] setObject:appInfoEntity.configDict forKey:kConfigDict];
	
	[[NSUserDefaults standardUserDefaults] setObject:appInfoEntity.supportedVersions forKey:kSupportedVersions];
	
	[[NSUserDefaults standardUserDefaults] setObject:appInfoEntity.versionUpdateUrl forKey:kVersionUpdateURL];
	
	[[NSUserDefaults standardUserDefaults] setObject:appInfoEntity.configVersion forKey:kConfigVersion];
	
	[[NSUserDefaults standardUserDefaults] setObject:appInfoEntity.appVersion forKey:kAppVersion];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	//Saving image
	
}

-(void) loadAssetsFromCache
{
	AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kFeatureAssets];
	
	if([data length] > 0)
	{
		//reload assets
        [assetsData.assets removeAllObjects];
        
        [assetsData.assets addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
	}
	
	NSData *extraData = [[NSUserDefaults standardUserDefaults] objectForKey:kExtraAssets];

	if([extraData length] > 0)
	{
		assetsData.headerImagesDict = [NSKeyedUnarchiver unarchiveObjectWithData:extraData];
	}
		
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kAppInfo] count] > 0)
	{
		assetsData.appInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kAppInfo];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kfeatureLayout] count] > 0)
	{
		assetsData.featureLayout = [[NSUserDefaults standardUserDefaults] objectForKey:kfeatureLayout];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kConfigDict] count] > 0)
	{
		appInfoEntity.configDict = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigDict];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kSupportedVersions] count] > 0)
	{
		appInfoEntity.supportedVersions = [[NSUserDefaults standardUserDefaults] objectForKey:kSupportedVersions];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kVersionUpdateURL] length] > 0)
	{
		appInfoEntity.versionUpdateUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionUpdateURL];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kConfigVersion] length] > 0)
	{
		appInfoEntity.configVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigVersion];
	}
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion] length] > 0)
	{
		appInfoEntity.appVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
	}
	
#ifdef DEBUG
	for(int i = 0;i<[assetsData.assets count];i++)
	{
		debug(@"assets %@", [[assetsData.assets objectAtIndex:i] featureName]);
		
		debug(@"Icon url %@", [[assetsData.assets objectAtIndex:i] defaultIconUrl]);
	}
	
	debug(@"app info %@", assetsData.appInfo);
	
	debug(@"Feature layout %@", assetsData.featureLayout);
	
	debug(@"Config dict %@", appInfoEntity.configDict);
	
#endif
	
}


@end
