//
//  Tabbar.m
//
//  Created by PHOTON on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Tabbar.h"
#import "DataModelEntities.h"
#import "WebContainer.h"
#import "SharedObjects.h"
#import "DebugOutput.h"
#import "Constants.h"


#define kTabbarTag			19

#define kTabbarButtonHeight 49

#define kMaxButtonCount		5

#define kScreenWidth		320


@implementation Tabbar

@synthesize viewControllers;
@synthesize selectedIndex;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		//self.backgroundColor = [UIColor blackColor];
		self.tag = kTabbarTag;
        lastSelectedIndex = 0;
        selectedIndex = 0;
        
    }
	
    return self;
}

- (UIView*)initWithInfo:(NSArray*)names {
	
	int buttonsCount = [names count];
	
	float contentWidth = 0;
	
	for (int i = 0; i < buttonsCount; i++) {
		
		AssetsDataEntity *assetsDataEntity = [[SharedObjects sharedInstance] assetsDataEntity];
		
		UIButton *customTabButton = [assetsDataEntity createButton:[names objectAtIndex:i] willAddWiggle:NO];
		
		CGRect rect;
		
		float x_pos = 0;
		
		if (buttonsCount < kMaxButtonCount) {
            float allotedWidth;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                allotedWidth= 768 / buttonsCount;
            }
            else {
                allotedWidth= kScreenWidth / buttonsCount;
            }
			 
			//x_pos = (allotedWidth - tabImage.frame.size.width) / 2;
			x_pos = (allotedWidth - 32) / 2;
		}
		else {
			float allotedWidth;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
               allotedWidth = 768 / kMaxButtonCount;
            }
            else {
                allotedWidth = kScreenWidth / kMaxButtonCount;
            }
			//x_pos = (allotedWidth - tabImage.frame.size.width) / 2;
			x_pos = (allotedWidth - 32) / 2 - 13;
		}
		
		if(contentWidth == 0) {			
			
			//rect = CGRectMake(x_pos + 5, (tabbar.frame.size.height - tabImage.size.height) / 2 + 5, tabImage.size.width, tabImage.size.height);
			rect = CGRectMake(x_pos , (self.frame.size.height - 45) / 2, 62, 40);
			
		}
		else {			
			
			//rect = CGRectMake(contentWidth + 25, (self.frame.size.height - tabImage.size.height) / 2 + 5, tabImage.size.width, tabImage.size.height);
			rect = CGRectMake(contentWidth + 2, (self.frame.size.height - 45) / 2, 62, 40);
			
		}
		
		customTabButton.frame = rect;
		
		[self addSubview:customTabButton];
		
		contentWidth += rect.size.width + x_pos - 1;
		
	}
	
    return self;
}

-(UIView*) addBgView
{
    UIImageView *bgImage;
    UIView *view;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_bg-72.png"]];
        
         view = [[[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height - bgImage.frame.size.height + 9,bgImage.frame.size.width, bgImage.frame.size.height)] autorelease];
        self.frame = CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height - bgImage.frame.size.height + 9,
                                bgImage.frame.size.width, bgImage.frame.size.height);
        
        [view addSubview:bgImage];
        
        [bgImage release];
        
        return view;
    }
    else {
        
         bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_bg.png"]];
        
         view = [[[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height - bgImage.frame.size.height + 9,bgImage.frame.size.width, bgImage.frame.size.height)] autorelease];
        self.frame = CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height - bgImage.frame.size.height + 9,
                                bgImage.frame.size.width, bgImage.frame.size.height);
        
        [view addSubview:bgImage];
        
        [bgImage release];
        
        return view;
    }
     
	
	
}

- (void)setControllers:(NSArray*)controllers {
    
    self.viewControllers = controllers;
    
    for (int i = 0; i < [self.viewControllers count]; i++) {
    
        if (nil != [self.viewControllers objectAtIndex:i]) {
            
            if ([[self.viewControllers objectAtIndex:i] respondsToSelector:@selector(view)]) {
                
                [[self superview] addSubview:[[self.viewControllers objectAtIndex:i] view]];
            }
        }                
    }    
}

- (void)setSelectedIndex:(int)index fromSender:sender {
    
    lastSelectedIndex = self.selectedIndex;
    
    self.selectedIndex = (NSInteger)index;
    
    NSLog(@"selectedIndex %d", self.selectedIndex);

    
    @try {
        
        if ([[self.viewControllers objectAtIndex:index] respondsToSelector:@selector(view)]) {
            
            [[self superview] bringSubviewToFront:[[self.viewControllers objectAtIndex:index] view]];
            
            [[self superview] bringSubviewToFront:self];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
            
            if (![assetsData isFeatureNative:[assetsData.featureLayout objectAtIndex:index]]) {
                if (nil == [[[self.viewControllers objectAtIndex:index] iWebview] request]) {
                    
                    [self reloadFeatureTab:index];
                }
            }    
        }
        
        
        [self highlightTab:sender atIndex:index];
    }
    @catch (NSException *exception) {
        debug(@"raised exception: %@", [exception reason]);
    }
}

- (void)highlightTab:(UIButton*)button atIndex:(int)index {
	
    if (nil != button) {
     
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
        
        UIImage *image = [[[assetsData.assets objectAtIndex:index] imagesDict] objectForKey:khighlightedTab];
        
        if (nil != image) {
        
            [button setBackgroundImage:image forState:UIControlStateNormal];
            
            if (lastSelectedIndex != selectedIndex) {
            
                [self unHighlightLastSelectedTab];
            }            
        }        
    }
    else {
        [self highlightTabAtIndex:index];
    }
}

- (void)highlightTabAtIndex:(int)index {
	
    if (index >= 0 && index < [[self subviews]count]) {
     
        UIButton *lastSelectedTab = (UIButton*)[self viewWithTag:(kTabbarTagOffset + index)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
        
        UIImage *image = [[[assetsData.assets objectAtIndex:index] imagesDict] objectForKey:khighlightedTab];
        
        if (nil != image) {
            [lastSelectedTab setBackgroundImage:image forState:UIControlStateNormal];
        }
    }    
}

- (void)unHighlightLastSelectedTab {
	
    if (lastSelectedIndex >= 0 && lastSelectedIndex < [[self subviews]count]) {
    
        UIButton *lastSelectedTab = (UIButton*)[self viewWithTag:(kTabbarTagOffset + lastSelectedIndex)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
        
        UIImage *image = [[[assetsData.assets objectAtIndex:lastSelectedIndex] imagesDict] objectForKey:kdefaultTab];
        
        if (nil != image) {
            [lastSelectedTab setBackgroundImage:image forState:UIControlStateNormal];
        } 
    }       
}

- (void)reloadFeatureTab:(int)index {
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
    
    FeaturedAsset *featuredAsset = (FeaturedAsset*)[assetsData.assets objectAtIndex:index];
    
    if ([[self.viewControllers objectAtIndex:index] respondsToSelector:@selector(loadWebViewWithRequest:)]) {
    
        [[self.viewControllers objectAtIndex:index] loadWebViewWithRequest:featuredAsset.featureUrl];
    }    
}

- (id)selectedController {
    
    return nil;
}

/**************************************************************************************************************
 getImageForButton
 
 desc:  returns button image based on the title given. The titles indexes  are referenced from 
 in  moreButtonIndexArray & tabButtonIndexArray.
 with this index, the images are referenced from imageDictionary.
 
 in:
 (NSString*) btnTitle : the Title of the button to create
 
 (BOOL) isInTabBar : Is button to be in tab bar button or more page. Image will be taken accordingly.
 
 (BOOL)isHighlighted : Is the image a highlighted image to be returned (Used in tab bar)
 
 
 **************************************************************************************************************/

-(UIImage*) getImageForButton:(NSString*)btnTitle  isHighlighted:(BOOL)isHighlighted
{
	UIImage *btnImage = nil;
	
	
	return btnImage;	
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	[super drawRect:rect];
}


- (void)dealloc {
    [viewControllers release];
	viewControllers = nil;
    [super dealloc];
}


@end
