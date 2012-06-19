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
//  AsyncImageView.h
//  iShop2.0
//
//  Created by Amit Choudhary on 06/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView {
	
	//could instead be a subclass of UIImageView instead of UIView, depending on what other features you want to 
	// to build into this class?
		
	NSURLConnection* connection; //keep a reference to the connection so we can cancel download in dealloc
	NSMutableData* data;		//keep reference to the data so we can collect it as it downloads
								//but where is the UIImage reference? We keep it in self.subviews - no need to re-code what we have in the parent class
}
	
- (void)loadImageFromURL:(NSURL*)url;
- (UIImage*) image;
	
@end
