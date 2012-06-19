/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
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
