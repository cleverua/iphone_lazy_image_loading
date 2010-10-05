//
//  RootViewController.h
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrReader.h"

@interface RootViewController : UITableViewController <FlickrReaderDelegate>
{
  NSMutableArray *items;
  FlickrReader   *flickr;
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) FlickrReader    *flickr;

@end
