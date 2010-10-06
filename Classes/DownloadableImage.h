//
//  DownloadableImage.h
//  LazyImages
//
//  Created by Macbook on 06.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *ImageDownloadedNotificationName = @"ImageDownloaded";

@interface DownloadableImage : NSObject 
{
  CGSize     size;
  NSString  *url;
  UIImage   *image;
}

@property (nonatomic, retain) NSString  *url;
@property (nonatomic, retain) UIImage   *image;

- (id)initWithUrl:(NSString *)url andSize:(CGSize)size;
- (void)download;
- (void)imageDownloaded:(NSData *)data;
- (void)downloadDidFail;

@end
