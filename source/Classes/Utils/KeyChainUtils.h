//
//  KeyChainUtils.h
//  Bloomingdales
//
//  Created by PHOTON on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


NSMutableDictionary *newSearchDictionary(NSString *identifier);

NSString *searchKeychainCopyMatching(NSString *identifier);

BOOL createKeychainValue(NSString *password ,NSString *identifier);

BOOL updateKeychainValue(NSString *password ,NSString *identifier);

void deleteKeychainValue(NSString *identifier);
