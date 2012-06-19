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
//  SpecialOfferCustomCell.h
//  Phresco
//
//  Created by bharat kumar on 24/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialOfferCustomCell : UITableViewCell
{
    UIImageView		*productImage;
	
	UILabel		    *productName;
    
    UILabel			*productPrice;
    
	UILabel			*priceLabel;
    
	UIButton		*reviewsButton;
	
	UIImageView		*ratingsView;
    
    UIImageView     *disImage;
}


@property (nonatomic, retain) UIImageView		*productImage;

@property (nonatomic, retain) UILabel		    *productName;

@property (nonatomic, retain) UILabel			*productPrice;

@property (nonatomic, retain) UILabel			*priceLabel;

@property (nonatomic, retain) UIButton		    *reviewsButton;

@property (nonatomic, retain)UIImageView		*ratingsView;

@property (nonatomic, retain)UIImageView		*disImage;

@end
