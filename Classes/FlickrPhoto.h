//
//  FlickrPhoto.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FlickrPhoto : NSObject 
{
  NSInteger photoId;
  NSString  *owner;
  NSString  *secret;
  NSInteger server;
  NSString  *title;
  
  UIImage *thumbnailImage;
  UIImage *mediumImage;
}

@property (nonatomic, assign) NSInteger photoId;
@property (nonatomic, retain) NSString  *owner;
@property (nonatomic, retain) NSString  *secret;
@property (nonatomic, assign) NSInteger server;
@property (nonatomic, retain) NSString  *title;

@property (nonatomic, retain) UIImage   *thumbnailImage;
@property (nonatomic, retain) UIImage   *mediumImage;

- (NSString *)thumbnailPhotoUrl;
- (NSString *)mediumPhotoUrl;

@end
