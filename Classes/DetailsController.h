//
//  DetailsController.h
//  LazyImages
//
//  Created by Macbook on 06.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"


@interface DetailsController : UITableViewController 
{
  FlickrPhoto *photo;
}

@property (nonatomic, retain) FlickrPhoto *photo;

@end
