//
//  FlickrPhoto.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

@synthesize photoId, owner, secret, server, title;

static NSString * photoFormatString = @"http://farm%i.static.flickr.com/%i/%i_%@_%@.jpg";

- (NSString *)thumbnailPhotoUrl
{
  return [NSString stringWithFormat:photoFormatString, 1, self.server, self.photoId, self.secret, @"s"];
}

- (NSString *)mediumPhotoUrl
{
  return [NSString stringWithFormat:photoFormatString, 1, self.server, self.photoId, self.secret, @"m"];
}

@end
