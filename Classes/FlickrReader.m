//
//  FlickrReader.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "FlickrReader.h"
#import "URLRequestBuilder.h"
#import "LazyImagesAppDelegate.h"
#import "FlickrPhoto.h"

@implementation FlickrReader

@synthesize delegate, items, status, currentPage, pagesCount, totalPhotos;

- (void)searchFor:(NSString *)text onPage:(NSInteger)page delegate:(id <FlickrReaderDelegate>)theDelegate
{
  self.delegate = theDelegate;
  receivedData = [[NSMutableData alloc] init];
  NSArray *arr = [[NSMutableArray alloc] init];
  self.items = arr;
  [arr release];
  
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                          FLICKR_SEARCH_METHOD, @"method",
                          FLICKR_API_KEY, @"api_key",
                          text, @"text",
                          @"1", @"privacy_filter",
                          [NSString stringWithFormat:@"%i", PER_PAGE], @"per_page",
                          [NSString stringWithFormat:@"%i", page], @"page",
                          nil];
  
  URLRequestBuilder *builder = [[URLRequestBuilder alloc] initWithMethod:RequestMethodGet 
                                                                     url:FLICKR_REST_API_ROOT 
                                                              parameters:params];
  NSURLRequest *request = [builder request];
  
  readerConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  [builder release];
  [params release];
}

- (void)cancel
{
  if (readerConnection != nil) 
  {
    delegate = nil;
    [readerConnection cancel];
    [readerConnection release];
    readerConnection = nil;
  }
}

- (void)dealloc
{
  if (readerConnection != nil) {
    [readerConnection cancel];
    [readerConnection release];
    readerConnection = nil;
  }
  if (receivedData != nil) {
    [receivedData release];
  }
  self.items = nil;
  self.status = nil;
  [super dealloc];
}

#pragma mark Connection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  NSLog(@"FlickrReader#connection:didReceiveData");
  [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
  parser.delegate = self;
  [parser parse];
  [parser release];
  
  if (delegate != nil) {
    [delegate dataReady:self];
  }
}

#pragma mark Parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
  if ([elementName isEqualToString:@"rsp"]) 
  {
    NSString *str = [[attributeDict objectForKey:@"stat"] copy];
    self.status = str;
    [str release];
  }
  else if ([elementName isEqualToString:@"photos"])
  {
    currentPage = [[attributeDict objectForKey:@"page"] intValue];
    pagesCount  = [[attributeDict objectForKey:@"pages"] intValue];
    totalPhotos = [[attributeDict objectForKey:@"total"] intValue];
  }
  else if([elementName isEqualToString:@"photo"])
  {
    FlickrPhoto *photo = [[FlickrPhoto alloc] init];

    NSString *str = [[attributeDict objectForKey:@"id"] copy];
    photo.photoId = str;
    [str release];
    
    str = [[attributeDict objectForKey:@"server"] copy];
    photo.server = str;
    [str release];
    
    str = [[attributeDict objectForKey:@"farm"] copy];
    photo.farm = str;
    [str release];
    
    str = [[attributeDict objectForKey:@"secret"] copy];
    photo.secret = str;
    [str release];
    
    str = [[attributeDict objectForKey:@"title"] copy];
    photo.title = str;
    [str release];
    
    [items addObject:photo];
    [photo release];
  }
}

@end
