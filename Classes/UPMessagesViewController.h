//
//  UPMessagesViewController.h
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMessageInputFieldDelegate.h"
#import "UPApiAdapterDelegate.h"

extern NSString *const UPBotKey;

extern NSString *const UPUserKey;

@class UPMessageInputField, UPApiAdapter;

@interface UPMessagesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, 
UPMessageInputFieldDelegate, UPApiAdapterDelegate> {
  
@private 
  UITableView *tableView;
  
  UPMessageInputField *messageInputField;
  
  // contains the messages. A message is a Dictionary with a question and an answer
  NSMutableArray *messages;
  // number of answers in the messages
  NSUInteger numberOfAnswers;
  
  UPApiAdapter *apiAdapter;
}

@property (nonatomic, retain) IBOutlet UPMessageInputField *messageInputField;;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
