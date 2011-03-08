//
//  instiBotAppDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 09.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class instiBotViewController;

@interface instiBotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    instiBotViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet instiBotViewController *viewController;

@end

