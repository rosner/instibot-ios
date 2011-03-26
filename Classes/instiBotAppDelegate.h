//
//  instiBotAppDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 09.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstibotViewController;

@interface InstibotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
  
    InstibotViewController *instibotController;;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

