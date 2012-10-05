//
//  LogicTest.h
//  LogicTest
//
//  Created by Sathiyasuresh on 05/10/12.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIkit.h>

#import "PhrescoAppDelegate.h"
#import "RootViewController.h"
#import "HomeViewController.h"
#import "BrowseViewController.h"
#import "ResultViewController.h"
#import "ProductDetailsViewController.h"
#import "AddToBagViewController.h"
#import "ViewCartController.h"
#import "CheckOutViewController.h"
#import "CheckOutOVerallViewController.h"
#import "ReviewViewController.h"
#import "ReviewCommentsViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "SpecialOffersViewController.h"
@interface LogicTest : SenTestCase {
    
@private
    iShopAppDelegate *appDelegate;
    RootViewController *rootController;
    HomeViewController *homeController;
    BrowseViewController *browseController;
    ResultViewController *resultController;
    ProductDetailsViewController *pdtDetailController;
    AddToBagViewController *addCartController;
    ViewCartController *viewCartController;
    CheckOutViewController *checkViewController;
    CheckOutOVerallViewController *checkOverallController;
    ReviewViewController *reviewController;
    ReviewCommentsViewController *reviewCommentsController;
    LoginViewController *loginController;
    RegistrationViewController *registerController;
    SpecialOffersViewController *splOfferController;
    
    UITableView *tblView;

}

@end
