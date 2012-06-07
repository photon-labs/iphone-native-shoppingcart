//
//  NavigationBar.h
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Webview.h"

@protocol NavigationBarDelegate<NSObject>
@optional
-(void)back:(id)sender;
-(void)search:(id)sender;
-(void)addToWishList:(id)sender;
@end


@interface NavigationBar : UIView {

	UIButton	*infoButton;
	UIButton	*searchButton;	
	UIButton	*backButton;
	UIButton    *previousButton;
	UIButton    *plusButton;
	UIImageView	*backgroundImage;
	
	BOOL		showSearch;
	BOOL		showBackButton;
	id   <NavigationBarDelegate>delegate;

}
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIButton *searchButton;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *previousButton;
@property (nonatomic, retain) UIButton *plusButton;

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, assign) BOOL showSearch;
@property (nonatomic, assign) BOOL showBackButton;
@property (nonatomic, assign) id   <NavigationBarDelegate>delegate;

-(void)back:(id)sender;
-(void)search:(id)sender;
-(void)addToWishList:(id)sender;
-(void)hideInfoButton:(BOOL)hide;

-(void)setHeaderImages:(NSDictionary*)imagesArray;

@end
