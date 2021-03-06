//
//  instiBotAppDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 09.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPMessagesViewController;

@interface InstibotAppDelegate : NSObject <UIApplicationDelegate> {
  
  UIWindow *window;

  UPMessagesViewController *messagesViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UPMessagesViewController *messagesViewController;

@end

