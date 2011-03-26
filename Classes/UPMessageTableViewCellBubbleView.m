//
//  UPMessageTableViewCellBubbleView.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessageTableViewCellBubbleView.h"


@implementation UPMessageTableViewCellBubbleView

+ (UIImage *)bubbleImageForMessageStyle:(SSMessageTableViewCellMessageStyle)aMessageStyle {
	UIImage *image;
	if (aMessageStyle == SSMessageTableViewCellMessageStyleGreen) {
		image = [[UIImage imageNamed:@"Balloon_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:22];
	} else {
		image = [[UIImage imageNamed:@"Balloon_2.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:22];
	}
  NSLog(@"bubble image size: %f %f", image.size.width, image.size.height);
	return image;
}

@end
