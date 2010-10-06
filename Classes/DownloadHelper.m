//
//  DownloadHelper.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "DownloadHelper.h"


@implementation DownloadHelper

- (id)initWithDownloadedImage:(DownloadableImage *)downloadableImage
{
  NSLog(@"initWithImage");
  if (self = [super init]) {
    image = downloadableImage;
    [image retain];
  }
  return self;
}

- (void)startDownload
{
  NSLog(@"startDownload %@", image.url);
  
  downloadedData = [[NSMutableData alloc] init];

  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:image.url]];
  connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
  [request release];  
}

- (void)cancel
{
  [connection cancel];
}

#pragma mark Connections

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
  [downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
  NSLog(@"connectionDidFinishLoading");
  
  [image imageDownloaded:downloadedData];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
  NSLog(@"connection:didFailWithError");
  
}

#pragma mark Memory management

- (void)dealloc
{
  [image release];
  
  [super dealloc];
}

@end
