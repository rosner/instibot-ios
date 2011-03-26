//
//  UPMessageTableViewCell.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessageTableViewCell.h"
#import "UPMessageTableViewCellBubbleView.h"

@implementation UPMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;		
		self.textLabel.hidden = YES;
    
		bubbleView = [[UPMessageTableViewCellBubbleView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
		bubbleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:bubbleView];
		[self.contentView sendSubviewToBack:bubbleView];
  }
  return self;
}

#pragma mark Getters

- (SSMessageTableViewCellMessageStyle)messageStyle {
	return bubbleView.messageStyle;
}


- (NSString *)messageText {
	return bubbleView.messageText;
}

#pragma mark Setters

- (void)setMessageStyle:(SSMessageTableViewCellMessageStyle)aMessageStyle {
	bubbleView.messageStyle = aMessageStyle;
}


- (void)setMessageText:(NSString *)text {
	bubbleView.messageText = text;
}


@end
