//
//  UPMessagesViewController.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessagesViewController.h"

#import "UPMessageInputField.h"

@interface UPMessagesViewController ()

- (void)tearDown;

@end

@implementation UPMessagesViewController

@synthesize tableView;

@synthesize messageInputField;

- (void)viewDidLoad {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardDidShowNotification object:nil];  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardWillHideNotification object:nil];    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardDidHideNotification object:nil];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Overriden to allow any orientation.
  return YES;
}


- (void)tearDown {
 	[tableView release];
  tableView = nil;
  
  [messageInputField release];
  messageInputField = nil;
  
  // remove the observation of keyboard notifications
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}


- (void)viewDidUnload {
  [super viewDidUnload];
  [self tearDown];
}


- (void)dealloc {
  [self tearDown];  
  [super dealloc];
}

#pragma mark -
#pragma mark Keyboard notification handling for transforming the table views
#pragma mark -

- (void)handleKeyBoardNotification:(NSNotification *)notification {
//  NSLog(@"%@", notification);
	NSString *notificationName = [notification name];
  if ([notificationName isEqualToString:UIKeyboardWillShowNotification]) {

    NSDictionary *userInfo = [notification userInfo];

    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

    // calculate the right size of the keyboard in relation to the orientation
    keyboardFrame = [self.view convertRect:keyboardFrame toView:nil];
//    NSLog(@"keyboard frame %f %f %f %f", keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);    

    CGRect newFrame = self.view.frame;
//    NSLog(@"old frame %f %f %f %f", newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);        
//    NSLog(@"old tableview frame %f %f %f %f", tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);            
//    NSLog(@"old input frame %f %f %f %f", messageInputField.frame.origin.x, messageInputField.frame.origin.y, messageInputField.frame.size.width, messageInputField.frame.size.height);                
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
			newFrame.size.height -= keyboardFrame.size.height;
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
      newFrame.size.height -= keyboardFrame.size.height;
      newFrame.origin.y += keyboardFrame.size.height;
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
			newFrame.size.width -= keyboardFrame.size.height;
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    	newFrame.size.width -= keyboardFrame.size.height;
      newFrame.origin.x += keyboardFrame.size.height;
    }
//    NSLog(@"new frame %f %f %f %f", newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);        
    self.view.frame = newFrame;
//    NSLog(@"new tableview frame %f %f %f %f", tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);                
//    NSLog(@"new input frame %f %f %f %f", messageInputField.frame.origin.x, messageInputField.frame.origin.y, messageInputField.frame.size.width, messageInputField.frame.size.height);                    
  }
}

#pragma mark -
#pragma mark UITableView delegate and datasource stuff
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 	static NSString *CellIdentifier = @"UPMessageTableViewCell"; 
  
  UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:CellIdentifier];
  }
  
  cell.textLabel.text = @"foo";
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
  
}

@end
