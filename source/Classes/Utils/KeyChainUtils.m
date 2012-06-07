//
//  KeyChainUtils.m
//  Bloomingdales
//
//  Created by PHOTON on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeyChainUtils.h"
#import <Security/Security.h>

/*********************
 
 Using the KeyChain Access in iPhone
 
 *********************/

/*************************
 newSearchDictionary
 
 Desc:   Creates a new Keychain Dictionary with encrypted keys
 
 In:
	NSString *identifier: the key value to be encrypted key 
 
 Out:
	NSMutableDictionary *newSearchDictionary : Encrypted dicttionary
 ***********************/
NSMutableDictionary *newSearchDictionary(NSString *identifier)
{
	//Create search dictionary
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];  
	
    [searchDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	
	//Encode the dict
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
    //[searchDictionary setObject:serviceName forKey:(id)kSecAttrService];
	
    return searchDictionary; 
}
/*******************
 
 searchKeychainCopyMatching
 
 Desc: Searches key value in dectionary
 
 In:
   NSString *identifier:the identifier to be search value
 
 Out:
  
 NSString *stringresult:the value to the identifier
 
 *******************/



NSString *searchKeychainCopyMatching(NSString *identifier)
{
    NSMutableDictionary *searchDictionary = newSearchDictionary(identifier);
	
    // Add search attributes
    [searchDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
    NSData *result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchDictionary,
                                          (CFTypeRef *)&result);
	
    [searchDictionary release];
	// Result of the search
	NSString *stringresult=[[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
	[result release];
    return stringresult;
}

/*******************
 
 createKeychainValue
 
 Desc: Creates  key value in dictionary
 
 In:
 
 NSString *value: The value to store
 NSString *identifier:the identifier to the value 
 
 Out:
 
 NSString *stringresult:the value to the key
 
 *******************/


BOOL createKeychainValue(NSString *value,NSString *identifier)
{
	//deletes the previous identifier
	deleteKeychainValue(identifier);
	
	//Create a new dict
	NSMutableDictionary *dictionary =  newSearchDictionary(identifier);
	
	//created new identifier
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(id)kSecValueData];
	
	//status of the creataing new identifier
    OSStatus status = SecItemAdd((CFDictionaryRef)dictionary, NULL);
    [dictionary release];
	
    if (status == errSecSuccess) {
        return YES;
    }
	
    return NO;
}

/*******************
 
 updateKeychainValue
 
 Desc: Updates  identifiers value in dictionary
 
 In:
 
 NSString *value: The value to update
 NSString *identifier:the identifier to the value 
 
 Out:
 
 BOOL status:returns the status of the update
 
 *******************/


BOOL updateKeychainValue(NSString *password ,NSString *identifier)
{
	
    NSMutableDictionary *searchDictionary = newSearchDictionary(identifier);
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
   
	//getting the old identifier value
	
	NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
   
	//update the old to new
	
	[updateDictionary setObject:passwordData forKey:(id)kSecValueData];
	
	//status  of the update
    
	OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictionary,
                                    (CFDictionaryRef)updateDictionary);
    [searchDictionary release];
    [updateDictionary release];
	
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

/*******************
 
 deleteKeychainValue
 
 Desc: deletes the  identifier value in dectionary
 
 In: 
 
 NSString *identifier:the identifier to delete  value  
 
 Out:
 
 void
 
 *******************/

void deleteKeychainValue(NSString *identifier)
{
	
    NSMutableDictionary *searchDictionary =  newSearchDictionary(identifier);
    //delete the identefier value
	SecItemDelete((CFDictionaryRef)searchDictionary);
    [searchDictionary release];
}



