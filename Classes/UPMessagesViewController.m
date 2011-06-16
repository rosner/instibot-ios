//
//  UPMessagesViewController.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessagesViewController.h"

#import "UPMessageInputField.h"
#import "UPMessageInputFieldDelegate.h"

#import "UPApiAdapter.h"
#import "UPApiAdapterDelegate.h"

#import "UPMessageTableViewCell.h"

#import "NSString+URLEncoding.h"

NSString *const UPBotKey = @"answer";

NSString *const UPUserKey = @"question";

@interface UPMessagesViewController ()

@property (nonatomic, retain) NSArray *messages;

- (void)tearDown;

- (void)adaptSizeForSubviews:(CGFloat )delta;

@end

@implementation UPMessagesViewController

@synthesize tableView;

@synthesize messages;

@synthesize messageInputField;

- (void)viewDidLoad {
//  messages = [[NSArray arrayWithObjects:
//               [NSDictionary dictionaryWithObject:@"Lorem ipsum dolor" forKey:UPUserKey],
//               [NSDictionary dictionaryWithObject:@"Lorem ipsum dolor sit amet, consetetur" forKey:UPBotKey],
//               [NSDictionary dictionaryWithObject:@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.," forKey:UPUserKey],
//               [NSDictionary dictionaryWithObject:@"Lorem" forKey:UPBotKey],
//               [NSDictionary dictionaryWithObject:@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod" forKey:UPBotKey],
//               nil
//               ] retain];

  messages = [[NSMutableArray alloc] init];
  
  numberOfAnswers = 0;
  numberOfQuestions = 0;
  
  tableView.separatorColor = [UIColor clearColor];
  tableView.backgroundColor = [UIColor clearColor];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardDidShowNotification object:nil];  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardWillHideNotification object:nil];    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardDidHideNotification object:nil];
  
  apiAdapter = [[UPApiAdapter alloc] init];
  apiAdapter.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Overriden to allow any orientation.
  return YES;
}


- (void)tearDown {
  apiAdapter = nil;
  
 	[tableView release];
  tableView = nil;
  
  [messageInputField release];
  messageInputField = nil;
  
  [apiAdapter release];
  apiAdapter = nil; 
  
  [messages release];
  messages = nil;
  
  // remove the observation of keyboard notifications
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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
  NSDictionary *messageDictionary = [messages objectAtIndex:indexPath.row];
  NSString *message;
  NSString *evenOrOddSuffix;
  BOOL messageIsFromUser = NO;
  
  if ([messageDictionary objectForKey:UPBotKey]) {
    evenOrOddSuffix = @"Even";
		message = [messageDictionary objectForKey:UPBotKey];
    
  } else {
    evenOrOddSuffix = @"Odd";
		message = [messageDictionary objectForKey:UPUserKey];    
    messageIsFromUser = YES;
  }
  
 	NSString *cellIdentifier = [NSString stringWithFormat:@"UPMessageTableViewCell%@", evenOrOddSuffix];  
  UPMessageTableViewCell *cell = (UPMessageTableViewCell *)[tableView_ dequeueReusableCellWithIdentifier:cellIdentifier];
  
  
  UPMessageTableViewCellStyle messageStyle = (messageIsFromUser) ? UPMessageTableViewCellStyleOdd : UPMessageTableViewCellStyleEven;
  if (!cell) {
    cell = [[UPMessageTableViewCell alloc] initWithMessageStyle:messageStyle reuseIdentifier:cellIdentifier];
  }
  cell.message = message;
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [messages count];
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *message = [messages objectAtIndex:indexPath.row];
  NSString *key = ([message objectForKey:UPBotKey]) ? UPBotKey : UPUserKey;
  
	NSString *messageForCellAtIndexPath = [message objectForKey:key];
  
  CGSize messageSize = [UPMessageTableViewCell sizeForMessageText:messageForCellAtIndexPath];
  return messageSize.height;
}

#pragma mark -
#pragma mark UPMessageInputFieldDelegate methods
#pragma mark -

- (void)messageInputField:(UPMessageInputField *)_messageInputField shouldGrowWithDelta:(CGFloat )delta {
  [self adaptSizeForSubviews:delta];
}

- (void)messageInputField:(UPMessageInputField *)_messageInputField shouldShrinkWithDelta:(CGFloat )delta {
  [self adaptSizeForSubviews:-delta];
}

- (void)adaptSizeForSubviews:(CGFloat )delta {
  CGRect newMessageInputFieldFrame = messageInputField.frame;
  newMessageInputFieldFrame.origin.y -= delta;
  newMessageInputFieldFrame.size.height += delta;
  messageInputField.frame = newMessageInputFieldFrame;
  
  CGRect newTableViewFrame = tableView.frame;
  newTableViewFrame.size.height -= delta;
  tableView.frame = newTableViewFrame;
  
  [self.view setNeedsLayout];
}


- (void)messageInputField:(UPMessageInputField *)theMessageInputField didSendMessage:(NSString *)message {
  [messages addObject:[NSDictionary dictionaryWithObject:message forKey:UPUserKey]];
  [tableView reloadData];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([messages count] - 1)  inSection:0];
  [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
  NSString *urlEncodedMessage = [NSString stringByURLEncoding:message];
	[apiAdapter reuqestResponseForMessage:urlEncodedMessage];
}


#pragma mark -
#pragma mark UPApiAdapterDelegate
#pragma mark -
- (void)apiAdapterIsReady:(UPApiAdapter *)apiAdapter {
  NSLog(@"%s", __FUNCTION__);
}

- (void)apiAdapter:(UPApiAdapter *)apiAdapter didReceiveBotResponses:(NSArray *)responses {
  
  NSLog(@"responses %d %@", [responses count], responses);                                   
  
  // calculate the number of question and answers responded
  NSMutableArray *answers = [[NSMutableArray alloc] init];
  [responses enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
    if ( [obj valueForKey:UPBotKey] ) {
      [answers addObject:[obj objectForKey:UPBotKey]];
    }
  }];
  
  NSUInteger numberOfNewAnswers = [answers count] - numberOfAnswers;
  NSLog(@"number of new Answers %d", numberOfNewAnswers);
  
  if ( numberOfNewAnswers > 0 ) {
    // get the new answers from the responses
    NSInteger indexForNewAnswers = [answers count] - numberOfNewAnswers;
    indexForNewAnswers = (indexForNewAnswers < 0) ? 0 : indexForNewAnswers;
    NSRange range = NSMakeRange(indexForNewAnswers, numberOfNewAnswers);
    NSLog(@"index of new answers: %d", indexForNewAnswers);
    NSArray *newAnswers = [answers subarrayWithRange:range];
    NSLog(@"new answers: %@", newAnswers);
    
    // concatenate the new answers so it looks like the bot is answering in on response
    NSString *aggregatedAnswer = [newAnswers componentsJoinedByString:@" "];
    NSLog(@"%@", aggregatedAnswer);
  } 
  
  numberOfAnswers += numberOfNewAnswers;
  [answers release];
  
  
   
//  self.messages = newMessages;
//  [tableView reloadData];
//  // scroll to end of table view to show the answer
//  NSIndexPath *indexPathForLastCell = [NSIndexPath indexPathForRow:[messages count] - 1 inSection:0];
//  [tableView scrollToRowAtIndexPath:indexPathForLastCell atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//  [newMessages release];

}
@end
