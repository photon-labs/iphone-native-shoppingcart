/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
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
