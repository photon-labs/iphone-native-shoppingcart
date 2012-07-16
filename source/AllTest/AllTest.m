//
//  AllTest.m
//  AllTest
//
//  Created by Administrator on 20/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllTest.h"

@implementation AllTest

- (void)setUp
{
    [super setUp];
    appDelegate = [[UIApplication sharedApplication]delegate];
    rootController = appDelegate.viewController;
    homeController = rootController.homeViewController;
    browseController = homeController.browseViewController;
    resultController = browseController.resultViewController;
    pdtDetailController = resultController.productDetailsViewController;
    addCartController = pdtDetailController.addToBagController;
    viewCartController = addCartController.viewCartController;
    checkViewController = viewCartController.checkCartController;
    checkOverallController = checkViewController.overallViewController;
    reviewController = resultController.reviewViewController;
    reviewCommentsController = reviewController.reviewCommentsViewController;
    loginController = homeController.loginViewController;
    registerController = loginController.registrationViewController;
    splOfferController = homeController.specialOffersViewController;
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [rootController release];
    [homeController release];
    [browseController release];
    [resultController release];
    [pdtDetailController release];
    [addCartController release];
    [viewCartController release];
    [checkViewController release];
    [checkOverallController release];
    [reviewController release];
    [reviewCommentsController release];
    [loginController release];
    [registerController release];
    [splOfferController release];
    [super tearDown];
}

- (void)testExample
{
    [rootController tabBarButtonAction:@"0"];
    // STFail(@"Unit tests are not implemented yet in HomeViewTest");
}
-(void) testAction
{
    [homeController buttonAction:@"0"];
    
}
-(void) testBrowse
{
    
    //[browseController  tableView:tblView didSelectRowAtIndexPath:0];
    
    STAssertThrows([browseController tableView:tblView didSelectRowAtIndexPath:-1] , @"Invalid index");
    
    
}
-(void) testProductResult
{
    [resultController  tableView:tblView didSelectRowAtIndexPath:0];
    [resultController reviewButtonSelected:@"0"];
    
}
-(void) testProductDetail
{
    [pdtDetailController addToCart:@"0"];
    
    
}


-(void) testAddToCart
{
    [addCartController removeIndex:@"0"];
    
    
}
-(void) testViewCart
{
    [viewCartController browseButtonSelected:@"0"];
    
}
-(void) testCheckCart
{
    [checkViewController cancelAction:@"0"];
    
}
-(void) testCheckOverall
{
    [checkViewController reviewAction:@"0"];
    
}
-(void) testReview
{
    [reviewController tableView:tblView didSelectRowAtIndexPath:0];
    
}
-(void) testComments
{
    [reviewCommentsController goBack:0];
    
}

-(void) testLogin
{
    [loginController registerButtonSelected:0];
    
}

-(void) testRegister
{
    [registerController registerButtonSelected:0];
    
}

-(void) testSplOffers
{
    [splOfferController tableView:tblView didSelectRowAtIndexPath:0];
    
}


@end
