//
//  FileManager.h
//  weddingregistry
//
//  Created by PHOTON on 14/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManager : NSObject {
	
}

- (NSMutableData*) readDataForFile:(NSString*)fileName;

- (BOOL) writeData:(id)data_ toFile:(NSString*)fileName;

- (NSString *)tempDirectoryPath:(NSString*)fileName;

-(void) writeAssetsToCache;

-(void) loadAssetsFromCache;

@end
