//
//  Thumbnailable.h
//  LazyImages
//
//  Created by Macbook on 06.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Thumbnailable

- (NSString *)thumbnailUrl;

- (void)setThumbnailImage:(UIImage *)image;
- (UIImage *)thumbnailImage;

@end
