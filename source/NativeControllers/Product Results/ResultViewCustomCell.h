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
//  ResultViewCustomCell.h
//  Phresco
//
//  Created by photon on 11/10/11.
//  Copyright 2011 EWR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResultViewCustomCell : UITableViewCell {

	UIImageView		*productImage;
	
	UILabel		*productName;
    
	UILabel			*priceLabel;
	
    UILabel         *dollarSign;
    
	UIButton		*reviewsButton;
	
	UIImageView		*ratingsView;
    
    NSMutableArray  *imageFramesArray;
    
    BOOL isSelected;
    
    UIImageView* disImage;
        
}

@property (nonatomic, retain) UIImageView		*productImage;

@property (nonatomic, retain) UILabel		*productName;

@property (nonatomic, retain) UILabel		*productPrice;

@property (nonatomic, retain) UILabel		*priceLabel;

@property (nonatomic, retain) UILabel       *dollarSign;

@property (nonatomic, retain) UIButton		*reviewsButton;

@property(nonatomic, retain) UIImageView* disImage;

@property (nonatomic, retain)NSMutableArray  *imageFramesArray;
@property (nonatomic, retain) UIImageView   *ratingsView;
@property(nonatomic) BOOL isSelected;

@end
