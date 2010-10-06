//
//  RootViewController.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrReader.h"

#define THUMBNAIL_HEIGHT 75

@interface TableViewController : UITableViewController <UITableViewDataSource, FlickrReaderDelegate>
{
  NSMutableArray      *items;
  NSMutableDictionary *downloaders;
  FlickrReader        *flickr;
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) FlickrReader    *flickr;
@property (nonatomic, readonly) NSMutableDictionary *downloaders;

@end
