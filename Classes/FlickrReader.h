//
//  FlickrReader.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlickrReader;

@protocol FlickrReaderDelegate
  
-(void)dataReady:(FlickrReader *)sender;

@end


@interface FlickrReader : NSObject <NSXMLParserDelegate>
{
  id <FlickrReaderDelegate> delegate;
  NSMutableData   *receivedData;
  NSURLConnection *readerConnection;
  NSMutableArray  *items;
  NSString        *status;
  
  NSInteger currentPage;
  NSInteger pagesCount;
  NSInteger totalPhotos;
}

@property (assign) id <FlickrReaderDelegate> delegate;
@property (nonatomic, retain) NSArray  *items;
@property (nonatomic, retain) NSString *status;

@property (nonatomic, assign, readonly) NSInteger currentPage;
@property (nonatomic, assign, readonly) NSInteger pagesCount;
@property (nonatomic, assign, readonly) NSInteger totalPhotos;


- (void)searchFor:(NSString *)text onPage:(NSInteger)page delegate:(id <FlickrReaderDelegate>)delegate;
- (void)cancel;

@end
