//
//  DictionaryUtils.h
//
//  Created by Photon on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DictionaryUtils : NSObject {

}

+ (DictionaryUtils *)sharedInstance;
- (NSString*) stringFromZeroOneInt:(int) aKey;
- (int) intFromBool:(BOOL) aKey;
- (NSNumber*) numberWithBool:(BOOL) aKey;
- (BOOL) dict:(NSDictionary*)dict boolForKey:(id) aKey;
- (int) dict:(NSDictionary*)dict intForKey:(id) aKey;
- (BOOL) dict:(NSDictionary*)dict hasKey:(id) testKey;
- (BOOL) dict:(NSDictionary*)dict hasNullForKey:(id) testKey;

@end
