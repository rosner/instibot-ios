//
//  UPMessageInputFieldDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 03.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMessageInputField.h"

@protocol UPMessageInputFieldDelegate <NSObject>

@required

- (void)messageInputField:(UPMessageInputField *)theMessageInputField shouldGrowWithDelta:(CGFloat )delta;

- (void)messageInputField:(UPMessageInputField *)theMessageInputField shouldShrinkWithDelta:(CGFloat )delta;
@end
