//
//  FlickrPhoto.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "FlickrPhoto.h"


@interface FlickrPhoto(PrivateMethods)

- (NSString *)mediumUrl;

@end


@implementation FlickrPhoto

@synthesize farm, photoId, secret, server, title;

static NSString * photoFormatString = @"http://farm%@.static.flickr.com/%@/%@_%@_%@.jpg";

- (DownloadableImage *)thumbnail
{
  if (thumbnail == nil) 
  {
    NSString *thumbUrl = [[NSString alloc] initWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @"s"];
    thumbnail = [[DownloadableImage alloc] initWithUrl:thumbUrl andSize:CGSizeMake(75.0, 75.0)];
    [thumbUrl release];
  }
  return thumbnail;
}

- (void)releaseImages
{
  if (thumbnail.image != nil) {
    thumbnail.image = nil;
  }
}


#pragma mark PrivateMethods

- (NSString *)mediumUrl
{
  return [NSString stringWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @"m"];
}

#pragma mark Memory Management

- (void)dealloc
{
  [thumbnail release];
  [super dealloc];
}

@end
