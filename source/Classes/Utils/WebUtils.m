//
//  WebUtils.m
//
//  Created by photon on 09/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DebugOutput.h"

BOOL isStringNumeric(NSString*string){
	
	BOOL _flag = YES;
	
	if(nil != string) {
		for(int i = 0; i < [string length]; i++) {
			
			char ch = [string characterAtIndex:i];
			
			if(!isdigit(ch))
				
				_flag = NO;
				break;
		}
	}
	
	return _flag;
}


NSString* parseURL(NSString *urlString)
{
	NSArray *params = [urlString componentsSeparatedByString:@"?"];
	
	NSString *parameter = [params objectAtIndex:1];
	
	NSArray *paramArray = [parameter componentsSeparatedByString:@"&"];
	
	NSString *prodId1 = [paramArray objectAtIndex:0];
	
	NSArray *prodIdArray = [prodId1 componentsSeparatedByString:@"="];
	
	NSString *prodId = [prodIdArray objectAtIndex:1];
	
	
	return prodId;
}


BOOL interceptURL(NSArray *URLInterceptList, NSString *urlString)
{
	
	BOOL found;
	
	if(nil != URLInterceptList)
	{
		for(int i = 0; i<[URLInterceptList count]; i++)
		{
			NSString *url = [URLInterceptList objectAtIndex:i];
			
			NSRange match = [urlString rangeOfString:url];
			
			if(match.location == NSNotFound)
			{
				found = NO;
				
			}
			
			else {
				
				found = YES;
				
				break;
				
			}
			
		}
	}
	
	return found;
	
}


void setCookies(NSDictionary *newCookieDict) {
	
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
	
	NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:newCookieDict];
	
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newCookie];		
}


NSString *loadJS(NSString *filename)
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"js" ];
	
	NSData *fileData = [NSData dataWithContentsOfFile:filePath];
	
	return [[NSMutableString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
	
	
}


BOOL dict(NSDictionary *dict, id testKey)
{
	if([dict respondsToSelector:@selector(objectForKey:)]) 
	{
		return ([dict objectForKey:testKey] != nil);
	}   
	
	return NO;
}
