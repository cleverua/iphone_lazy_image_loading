//
//  FlickrPhoto.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadableImage.h"

@interface FlickrPhoto : NSObject
{
  NSString  *photoId;
  NSString  *secret;
  NSString  *server;
  NSString  *title;
  NSString  *farm;
  
  DownloadableImage  *thumbnail;
  DownloadableImage  *medium;
}

@property (nonatomic, retain) NSString  *photoId;
@property (nonatomic, retain) NSString  *secret;
@property (nonatomic, retain) NSString  *server;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *farm;

@property (nonatomic, readonly) DownloadableImage  *thumbnail;
@property (nonatomic, readonly) DownloadableImage  *medium;

- (void)releaseImages;

@end
