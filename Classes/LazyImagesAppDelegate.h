//
//  LazyImagesAppDelegate.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LazyImagesAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

