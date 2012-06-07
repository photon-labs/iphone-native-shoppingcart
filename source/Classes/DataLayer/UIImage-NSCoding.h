//
//  UIImage-NSCoding.h
//  iShop
//
//  Created by Photon on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

@interface UIImageNSCoding <NSCoding>

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
