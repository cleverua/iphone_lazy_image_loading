//
//  DownloadHelper.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "DownloadHelper.h"


@implementation DownloadHelper

- (id)initWithUrl:(NSString *)url delegate:(id <DownloadHelperDelegate>)theDelegate indexPath:(NSIndexPath *)theIndexPath
{
  if (self = [super init]) {
    downloadUrl = [url retain];
    delegate    = theDelegate;
    indexPath      = theIndexPath;
  }
  return self;
}

- (void)startDownload
{
  NSLog(@"startDownload %@", downloadUrl);
  
  downloadedData = [[NSMutableData alloc] init];

  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:downloadUrl]];
  connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
  [request release];  
}

- (void)cancel
{
  [connection cancel];
  delegate = nil;
}

#pragma mark Connections

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
  [downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
  NSLog(@"connectionDidFinishLoading");
    
  [delegate downloadSuccessful:indexPath data:downloadedData];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
  NSLog(@"connection:didFailWithError");
  
}

#pragma mark Memory management

- (void)dealloc
{
  [downloadUrl release];
  
  [super dealloc];
}

@end
