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
//  Base64.h
//  CryptTest
//
//  Created by Kiichi Takeuchi on 4/20/10.
//  Copyright 2010 ObjectGraph LLC. All rights reserved.
// 
// Original Source Code is donated by Cyrus
// Public Domain License
// http://www.cocoadev.com/index.pl?BaseSixtyFour

#import <Foundation/Foundation.h>


@interface Base64 : NSObject {

}
+ (void) initialize;
+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;
+ (NSString*) encode:(NSData*) rawBytes;
+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength;
+ (NSData*) decode:(NSString*) string;
@end
