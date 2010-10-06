//
//  LazyImagesAppDelegate.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FLICKR_API_KEY       @"7288fdd3db1685f784f03b8892784573"
#define FLICKR_SECRET_KEY    @"7fd9d03aae03ba05"
#define FLICKR_REST_API_ROOT @"http://api.flickr.com/services/rest/"
#define FLICKR_SEARCH_METHOD @"flickr.photos.search"
#define PER_PAGE             10

#define DELEGATE ((LazyImagesAppDelegate *)[[UIApplication sharedApplication] delegate])

@interface LazyImagesAppDelegate : NSObject <UIApplicationDelegate> 
{    
  UIWindow *window;
  UINavigationController *navigationController;
  NSMutableDictionary    *downloaders;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, readonly) NSMutableDictionary  *downloaders;

@end

