//
//  WebUtils.h
//
//  Created by photon on 09/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isStringNumeric(NSString *string);

BOOL interceptURL(NSArray *URLInterceptList, NSString *urlString);

NSString *parseURL(NSString *urlString);

void setCookies(NSDictionary *newCookieDict);

NSString *loadJS(NSString *filename);

BOOL dict(NSDictionary *dict, id testKey);
