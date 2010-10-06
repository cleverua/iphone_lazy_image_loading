//
//  DownloadableCell.m
//  LazyImages
//
//  Created by Macbook on 06.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "DownloadableCell.h"


@implementation DownloadableCell

- (id)initWithTableView:(UITableView *)theTableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
      tableView = [theTableView retain];
    }
    return self;
}

- (DownloadableImage *)thumbnail
{
  return thumbnail;
}

- (void)setThumbnail:(DownloadableImage *)th
{
  if (th != nil) {
    if (th.image == nil) 
    {
      self.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
      [[NSNotificationCenter defaultCenter] addObserver:self 
                                               selector:@selector(thumbnailDownloaded:) 
                                                   name:@"ImageDownloaded" 
                                                 object:th];
      if ((tableView.dragging == NO) && (tableView.decelerating == NO))
      {
        [th download];
      }      
    }
    else {
      self.imageView.image = th.image;
    }
    [th retain];
  }
  if (thumbnail != nil) {
    [thumbnail release];
  }
  thumbnail = th;
}

- (void)thumbnailDownloaded:(id)sender
{
  self.imageView.image = thumbnail.image;
  if ([[tableView visibleCells] containsObject:self] == YES)
  {
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[tableView indexPathForCell:self]] withRowAnimation:UITableViewRowAnimationNone];
  }
}

- (void)prepareForReuse
{
  [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                  name:@"ImageDownloaded" 
                                                object:thumbnail];
  [super prepareForReuse];
}

- (void)dealloc 
{
  [tableView release];
  [super dealloc];
}


@end
