//
//  RootViewController.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import "TableViewController.h"
#import "FlickrReader.h"
#import "MiscHeler.h"
#import "LazyImagesAppDelegate.h"
#import "DownloadableCell.h"
#import "FlickrPhoto.h"
#import "DetailsController.h"

@interface TableViewController(PrivateMethods)

- (void)loadImagesForOnscreenRows;

@end

@implementation TableViewController

@synthesize items, flickr, downloaders;

static const NSInteger SEARCH_SECTION_INDEX = 0;
static const NSInteger ITEMS_SECTION_INDEX  = 1;
static const NSInteger RELOAD_SECTION_INDEX = 2;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
  [super viewDidLoad];

  self.title = @"Flickr";
  items = [[NSMutableArray alloc] init];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
  return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
  return (section == ITEMS_SECTION_INDEX) ? [items count] : 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
  static NSString *SearchCellIdentifier   = @"SearchCell";
  static NSString *FlickrCellIdentifier   = @"FlickrCell";
  static NSString *NextPageCellIdentifier = @"NextPageCell";
    
  UITableViewCell *cell;
  
  if (indexPath.section == SEARCH_SECTION_INDEX) {
    // search bar cell
    cell = [tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCellIdentifier] autorelease];
      UISearchBar *bar = [[UISearchBar alloc] initWithFrame:[tableView rectForRowAtIndexPath:indexPath]];
      [cell.contentView addSubview:bar];
      [bar release];
    }
  }
  else if (indexPath.section == RELOAD_SECTION_INDEX) 
  {
    cell = [tableView dequeueReusableCellWithIdentifier:NextPageCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NextPageCellIdentifier] autorelease];
      cell.textLabel.text = @"Loading Next Page...";
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"Loading Next Page...");
    
    FlickrReader *reader = [[FlickrReader alloc] init];
    self.flickr = reader;
    [reader searchFor:@"cat" onPage:([items count]/PER_PAGE + 1) delegate:self];  
    [reader release];    
  }
  else
  {
    cell = (DownloadableCell *)[tableView dequeueReusableCellWithIdentifier:FlickrCellIdentifier];
    if (cell == nil) {
      cell = [[[DownloadableCell alloc] initWithTableView:self.tableView style:UITableViewCellStyleDefault reuseIdentifier:FlickrCellIdentifier] autorelease];
      cell.textLabel.numberOfLines = 3;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    FlickrPhoto *photo = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = [photo title];
    
    ((DownloadableCell *)cell).thumbnail = photo.thumbnail;
  }
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == SEARCH_SECTION_INDEX) 
    return 36;
  else if (indexPath.section == RELOAD_SECTION_INDEX)
    return 36;
  else 
    return THUMBNAIL_HEIGHT +4;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
  DetailsController *detailsController = [[DetailsController alloc] initWithNibName:nil bundle:nil];
  detailsController.photo = [items objectAtIndex:indexPath.row];
  // ...
  // Pass the selected object to the new view controller.
  [self.navigationController pushViewController:detailsController animated:YES];
  [detailsController release];
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if (!decelerate)
	{
    [self loadImagesForOnscreenRows];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self loadImagesForOnscreenRows];
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
  if ([items count] > 0)
  {
    for (DownloadableCell *cell in [self.tableView visibleCells])
    {    
      if ([cell isMemberOfClass:[DownloadableCell class]] && (cell.thumbnail.image == nil))
      {
        [cell.thumbnail download];
      }
    }
  }
}

#pragma mark FlickrReader delegate

-(void)dataReady:(FlickrReader *)sender
{
  NSLog(@"dataReady fired");
  [self.items addObjectsFromArray:sender.items];
  [self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
    
  // Relinquish ownership any cached data, images, etc that aren't in use.
  for (FlickrPhoto *photo in self.items) 
  {
    [photo releaseImages];
  }
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
  self.items = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

