//
//  FlickrPhoto.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

@synthesize farm, photoId, owner, secret, server, title, thumbnailImage, mediumImage;

static NSString * photoFormatString = @"http://farm%@.static.flickr.com/%@/%@_%@_%@.jpg";

- (NSString *)thumbnailUrl
{
  return [NSString stringWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @"s"];
}

- (NSString *)mediumUrl
{
  return [NSString stringWithFormat:photoFormatString, self.farm, self.server, self.photoId, self.secret, @"m"];
}

@end
