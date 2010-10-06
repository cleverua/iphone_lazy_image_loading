//
//  DownloadHelper.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadHelperDelegate

@required

- (void)downloadSuccessful:(NSIndexPath *)indexPath data:(NSData *)data;

@end


@interface DownloadHelper : NSObject 
{
  NSString    *downloadUrl;
  id           delegate;
  NSIndexPath *indexPath;
  
  NSMutableData   *downloadedData;
  NSURLConnection *connection;
}

- (id)initWithUrl:(NSString *)url delegate:(id <DownloadHelperDelegate>)delegate indexPath:(NSIndexPath *)indexPath;
- (void)startDownload;
- (void)cancel;

@end
