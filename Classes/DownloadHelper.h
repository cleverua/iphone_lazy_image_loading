//
//  DownloadHelper.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadableImage.h"

@interface DownloadHelper : NSObject 
{
  DownloadableImage *image;
  
  NSMutableData   *downloadedData;
  NSURLConnection *connection;
}

- (id)initWithDownloadedImage:(DownloadableImage *)image;
- (void)startDownload;
- (void)cancel;

@end
