//
//  instiBotViewController.m
//  instiBot
//
//  Created by Norman Rosner on 09.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "InstibotViewController.h"
#import "UPMessageTableViewCell.h"

@implementation InstibotViewController

NSString *lorem[] = {
	@"Hi",
	@"This is a work in progress",
	@"Ya I know",
	@"Fine then\nI see how it is",
	@"Do you? Do you really?",
	@"Yes"
};

#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
//	}
	return YES;
}


#pragma mark SSMessagesViewController

- (SSMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return SSMessageTableViewCellMessageStyleGreen;
	}
	return SSMessageTableViewCellMessageStyleGray;
}


- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return lorem[indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return sizeof(lorem) / sizeof(NSString *);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellIdentifier = @"cellIdentifier";
  
  UPMessageTableViewCell *cell = (UPMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[[UPMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }
	
  cell.messageStyle = [self messageStyleForRowAtIndexPath:indexPath];
	cell.messageText = [self textForRowAtIndexPath:indexPath];
	
  return cell;
}


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [super dealloc];
}

@end
