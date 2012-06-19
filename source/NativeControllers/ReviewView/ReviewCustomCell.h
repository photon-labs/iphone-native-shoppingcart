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
//  ReviewCustomCell.h
//  Phresco
//
//  Created by bharat kumar on 03/01/12.
//  Copyright (c) 2012 bharatkumar.r@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCustomCell : UITableViewCell
{
    UIImageView* ratingImage;
    UILabel* commentsLabel;
    UIImageView* disImage;
    UILabel *userNameLabel;
    UILabel *dateLabel;
    NSMutableArray            *imageFramesArray;
}
@property(nonatomic, retain) UILabel*  commentsLabel;
@property(nonatomic, retain) UIImageView* ratingImage;
@property(nonatomic, retain) UIImageView* disImage;
@property (nonatomic, retain) UILabel *userNameLabel; 
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) NSMutableArray *imageFramesArray;

@end
