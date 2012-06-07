//
//  ConnectionManager.h
//  iShop 2.0
//
//  Created by Srivatsa S. on 10/28/10.
//  Copyright Photon Infotech (P) Ltd. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCESS_STATUS_CODE	200
#define FAIL_STATUS_CODE	0

//connection - dictionary Access vars
#define kConnection								@"connection"
#define kConnectionURL							@"URL"
#define kConnectionDataReceived					@"data"
#define kConnectionCallbackTarget				@"callBackTarget"
#define kConnectionCallbackSelector				@"callBackSelector"
#define kConnectionCallbackID					@"callBackID"
#define kConnectionServerResponse				@"serverResponse"
#define kisErrorHandlingRequired				@"isErrorHandlingRequired"

@interface ConnectionManager : NSObject {
	
	NSMutableArray *urlConnectionsArray;
	
	BOOL			isServiceDown;
	
	NSInteger		callbackIDCounter;
}

#pragma mark singleton object methods 

+ (ConnectionManager*)sharedConnections;

- (void)cancel;

- (void)serviceCallWithURL: (NSString*)aURLString
				  httpBody: (NSString*)aHttpBody 
			   httpMethod : (NSString*)aHttpMethod
			callBackTarget: (id)callBackTarget
		  callBackSelector: (SEL)callBackSelector
				callBackID: (id)callbackID;
//errorHandlingRequired: (BOOL)errorHandlingRequired;


- (BOOL)serviceErrorHandling:(NSURLConnection *)connection;

- (BOOL)isResponseNil:(NSURLResponse *)response;

- (BOOL)checkInternetConnection:(NSURLConnection *)connection;

- (id)getConnectionObj:(NSURLConnection *)connection;

- (void)deleteConnObj:(NSURLConnection *)conn;

-(id)getCallbackID;

-(void) serviceCallWithSoapRequest:(NSString*)aURLString
						  httpBody: (NSString*)aHttpBody 
					   httpMethod : (NSString*)aHttpMethod
					callBackTarget: (id)callBackTarget
				  callBackSelector: (SEL)callBackSelector
						callBackID: (id)callbackID;

@end
