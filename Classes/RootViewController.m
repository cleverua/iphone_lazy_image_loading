//
//  RootViewController.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright CleverUA 2010. All rights reserved.
//

#import "RootViewController.h"
#import "FlickrReader.h"
#import "MiscHeler.h"
#import "FlickrPhoto.h"
#import "LazyImagesAppDelegate.h"

@implementation RootViewController

@synthesize items, flickr;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
  [super viewDidLoad];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count] + 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
  static NSString *SearchCellIdentifier   = @"SearchCell";
  static NSString *FlickrCellIdentifier   = @"FlickrCell";
  static NSString *NextPageCellIdentifier = @"NextPageCell";
    
  UITableViewCell *cell;
  
  if (indexPath.row == 0) {
    // search bar cell
    cell = [tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCellIdentifier] autorelease];
      UISearchBar *bar = [[UISearchBar alloc] initWithFrame:[tableView rectForRowAtIndexPath:indexPath]];
      [cell.contentView addSubview:bar];
      [bar release];
    }
  }
  else if (indexPath.row > [items count]) 
  {
    cell = [tableView dequeueReusableCellWithIdentifier:NextPageCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NextPageCellIdentifier] autorelease];
      cell.textLabel.text = @"Loading Next Page...";
    }
    NSLog(@"Loading Next Page...");
    
    FlickrReader *reader = [[FlickrReader alloc] init];
    self.flickr = reader;
    [reader searchFor:@"cat" onPage:([items count]/PER_PAGE + 1) delegate:self];  
    [reader release];    
  }
  else
  {
    cell = [tableView dequeueReusableCellWithIdentifier:FlickrCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FlickrCellIdentifier] autorelease];
    }
    
    FlickrPhoto *photo = [items objectAtIndex:indexPath.row - 1];
    cell.textLabel.text = photo.title;
  }
  return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

