//
//  DictionaryUtils.m
//
//  Created by Photon on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DictionaryUtils.h"

static DictionaryUtils *sharedDictionaryUtils = nil;

@implementation DictionaryUtils

- (id) init {
	self = [super init];	
	
	return self;
}

+ (DictionaryUtils *)sharedInstance {
    @synchronized(self) {
        if (sharedDictionaryUtils == nil) 
		{
			sharedDictionaryUtils= [[self alloc] init]; // assignment not done here
        }
    }
	
    return sharedDictionaryUtils;
}

- (void) dealloc
{
	[super dealloc];
}

- (NSString*) stringFromZeroOneInt:(int) aKey {
	return (aKey ? @"1" : @"0");
}

- (int) intFromBool:(BOOL) aKey {
	return (aKey ? 1 : 0);
}

- (NSNumber*) numberWithBool:(BOOL) aKey {
	return (aKey ? [NSNumber numberWithInt:1] :[NSNumber numberWithInt:0]);
}

-(BOOL) dict:(NSDictionary*)dict boolForKey:(id) aKey
{
    BOOL result = FALSE; 
    
	id <NSObject> obj = [dict objectForKey:aKey];
    
	if (obj) {
		
		SEL bv = @selector(boolValue);
        
		if ([obj respondsToSelector:bv]) {
			result = ([obj performSelector:bv] ? TRUE : FALSE);
		}			
        else if ([obj isKindOfClass:[NSString class]]) {
			
			result = ([(NSString *)obj caseInsensitiveCompare: @"TRUE"] == NSOrderedSame);
            
            if (!result) 
				result = ([(NSString *)obj caseInsensitiveCompare: @"YES"] == NSOrderedSame);
			
		}
	}
	
    return result;
}

-(int) dict:(NSDictionary*)dict intForKey:(id) aKey
{
    int result = 0; 
    id <NSObject> obj = [dict objectForKey:aKey];
    if (obj) {
        SEL iv = @selector(intValue);
        if ([obj respondsToSelector:iv])
            result = (int)[obj performSelector:iv];
	}
    return result;
}

-(BOOL) dict:(NSDictionary*)dict hasKey:(id) testKey
{
	if([dict respondsToSelector:@selector(objectForKey:)]) 
	{
		return ([dict objectForKey:testKey] != nil);
	}   
	
	return NO;
}

-(BOOL) dict:(NSDictionary*)dict hasNullForKey:(id) testKey
{
	if([dict respondsToSelector:@selector(objectForKey:)]) 
	{
		return ([[dict objectForKey:testKey] isEqual:[NSNull null]]);
	}
    
	return NO;
}


@end
