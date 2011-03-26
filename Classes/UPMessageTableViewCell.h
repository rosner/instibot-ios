//
//  UPMessageTableViewCell.h
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMessageTableViewCell.h"

@class UPMessageTableViewCellBubbleView;

@interface UPMessageTableViewCell : UITableViewCell {

  UPMessageTableViewCellBubbleView *bubbleView;
}

// these are simple wrappers that access the specific properties from the bubble view
@property (nonatomic, copy) NSString *messageText;

@property (nonatomic, assign) SSMessageTableViewCellMessageStyle messageStyle;


@end
