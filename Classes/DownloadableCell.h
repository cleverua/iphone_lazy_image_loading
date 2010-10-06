//
//  DownloadableCell.h
//  LazyImages
//
//  Created by Macbook on 06.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadableImage.h"


@interface DownloadableCell : UITableViewCell 
{
  DownloadableImage  *thumbnail;
  UITableView        *tableView;
}

- (id)initWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)cellIdentifier;

@property (nonatomic, retain) DownloadableImage  *thumbnail;

@end
