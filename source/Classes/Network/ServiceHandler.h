//
//  PDPServiceHandler.h
//  iShop2.0
//
//  Created by PHOTON on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServiceHandler : NSObject {

	NSString *coremetricsURLString;
    
    NSString *strId;
    NSString *prodId;
    NSString *productName;
    
    NSMutableString *loginId;
    NSMutableString *pwd;
    
    NSMutableString *firstName;
    NSMutableString *lastName;
    NSMutableString *emailAddress;
    NSMutableString *password;
    NSMutableString *confirmPassword;
    NSMutableString *phoneNumber;
    NSDictionary* loginDict;
  
    //To post the review comment
    NSString *commentProductId;
    NSMutableString *commentUserId;
    NSMutableString *commentRating;
    NSMutableString *commentComment;
    NSMutableString *commentDate;
    NSMutableString *commentUserName;
    
    NSString *loginUserId;
    NSString *loginUserName;
    
@private
	id callBackTarget;
	SEL callBackSelector;	
	
}

@property(assign) id callBackTarget;
@property(assign) SEL callBackSelector;

@property(nonatomic,retain)  NSString *strId;
@property(nonatomic,retain)  NSString *prodId;
@property(nonatomic,retain)  NSString *productName;

@property(nonatomic,retain)  NSMutableString  *loginId;
@property(nonatomic,retain)  NSMutableString *pwd;
@property(nonatomic,retain)  NSMutableString *firstName;
@property(nonatomic,retain)  NSMutableString *lastName;
@property(nonatomic,retain)  NSMutableString *confirmPassword;
@property(nonatomic,retain)  NSMutableString *emailAddress;
@property(nonatomic,retain)  NSMutableString *password;
@property(nonatomic,retain)  NSMutableString *phoneNumber;

@property(nonatomic,retain)  NSString *commentProductId;
@property(nonatomic,retain)  NSMutableString *commentUserId;
@property(nonatomic,retain)  NSMutableString *commentRating;
@property(nonatomic,retain)  NSMutableString *commentComment;
@property(nonatomic,retain)  NSMutableString *commentDate;
@property(nonatomic,retain)  NSMutableString *commentUserName;
@property(nonatomic,retain)  NSString *loginUserId;
@property(nonatomic,retain)  NSString *loginUserName;


-(void) configService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) configServiceDone:(NSMutableDictionary*) responseDataDict;

-(void) catalogService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) catalogServiceDone:(NSMutableDictionary*) responseDataDict;

-(void) productDetailsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productDetailsServiceDone:(NSMutableDictionary*) responseDataDict ;

-(void) productService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productServiceDone:(NSMutableDictionary*) responseDataDict ;

- (void) productReviewService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productReviewServiceDone:(NSMutableDictionary*) responseDataDict;


-(void) specialProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) specialProductsServiceDone:(NSMutableDictionary*) responseDataDict ;

-(void) searchProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) searchProductsServiceDone:(NSMutableDictionary*) responseDataDict ;

- (void) productReviewCommentService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productReviewCommentServiceDone:(NSMutableDictionary*) responseDataDict;


@end
