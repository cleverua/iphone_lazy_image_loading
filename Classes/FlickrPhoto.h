//
//  FlickrPhoto.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thumbnailable.h"

@interface FlickrPhoto : NSObject <Thumbnailable>
{
  NSString  *photoId;
  NSString  *owner;
  NSString  *secret;
  NSString  *server;
  NSString  *title;
  NSString  *farm;
  
  UIImage *thumbnailImage;
  UIImage *mediumImage;
}

@property (nonatomic, retain) NSString  *photoId;
@property (nonatomic, retain) NSString  *owner;
@property (nonatomic, retain) NSString  *secret;
@property (nonatomic, retain) NSString  *server;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *farm;


@property (nonatomic, retain) UIImage   *thumbnailImage;
@property (nonatomic, retain) UIImage   *mediumImage;

- (NSString *)thumbnailUrl;
- (NSString *)mediumUrl;

@end
