//
//  UPMessagesViewController.h
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMessageInputFieldDelegate.h"

@class UPMessageInputField;
@protocol UPMessageInputFieldDelegate;

@interface UPMessagesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UPMessageInputFieldDelegate> {

  @private 
  UITableView *tableView;

  UPMessageInputField *messageInputField;
  
  NSMutableArray *messages;
}

@property (nonatomic, retain) IBOutlet UPMessageInputField *messageInputField;;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
