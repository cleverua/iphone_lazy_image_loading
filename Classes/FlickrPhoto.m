//
//  FlickrPhoto.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

@synthesize farm, photoId, secret, server, title;

static NSString * photoFormatString = @"http://farm%@.static.flickr.com/%@/%@_%@%@.jpg";

- (DownloadableImage *)thumbnail
{
  if (thumbnail == nil) 
  {
    NSString *thumbUrl = [[NSString alloc] initWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @"_s"];
    thumbnail = [[DownloadableImage alloc] initWithUrl:thumbUrl andSize:CGSizeMake(75.0, 75.0)];
    [thumbUrl release];
  }
  return thumbnail;
}

- (DownloadableImage *)medium
{
  if (medium == nil) 
  {
    NSString *thumbUrl = [[NSString alloc] initWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @""];
    medium = [[DownloadableImage alloc] initWithUrl:thumbUrl andSize:CGSizeMake(500.0, 500.0)];
    [thumbUrl release];
  }
  return medium;
}

- (void)releaseImages
{
  if (thumbnail.image != nil) {
    thumbnail.image = nil;
    medium.image = nil;
  }
}


#pragma mark Memory Management

- (void)dealloc
{
  [thumbnail release];
  [super dealloc];
}

@end
