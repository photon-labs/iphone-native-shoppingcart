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
//  AddtoBagCustomCell.h
//  Phresco
//
//  Created by photon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddtoBagCustomCell : UITableViewCell
{

    UIImageView *productImageView;

    UILabel *productLabel;
    
    UILabel *productCountLabel;

    UILabel	*Quantity;
        
	UILabel	*priceLabel;
    
    UILabel	*priceValue;
    
    UITextField *quantityTextView;
    
    UIButton *btnRemove;
    
    NSString *delObj;
    
    NSString *strQuantity;
    
}

@property (nonatomic, retain) UIImageView *productImageView;

@property (nonatomic, retain) UILabel *productLabel;

@property (nonatomic, retain) UILabel *productCountLabel;

@property (nonatomic, retain) UILabel *Quantity;

@property (nonatomic, retain) UILabel *priceLabel;

@property (nonatomic, retain) UILabel *priceValue;

@property (nonatomic, retain) UITextField* quantityTextView;

@property (nonatomic, retain) UIButton *btnRemove;

@property (nonatomic, retain)  NSString *delObj;

@property (nonatomic, retain)  NSString *strQuantity;


@end
