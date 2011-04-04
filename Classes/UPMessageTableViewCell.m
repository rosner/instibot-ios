//
//  UPMessageTableViewCell.m
//  instiBot
//
//  Created by Norman Rosner on 03.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessageTableViewCell.h"


@interface UPMessageTableViewCell () 

@property (nonatomic, readonly) UIImageView *bubbleImageView;

@property (nonatomic, readonly) UILabel *messageLabel;

@end

static CGFloat kPortraitMarginFactor = 0.3125;
static CGFloat kLandscapeMarginFactor = 0.475;

static CGFloat kVerticalPadding = 8.0;
static CGFloat kHorizontalPadding = 20.0;

static CGFloat kMessageFontSize = 16.0;

@implementation UPMessageTableViewCell

@synthesize style;
@synthesize bubbleImageView;
@synthesize message;

- (id)initWithMessageStyle:(UPMessageTableViewCellStyle )messageStyle reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    style = messageStyle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.hidden = YES;
    
    [self.contentView addSubview:self.bubbleImageView];
    [self.contentView addSubview:self.messageLabel];
    message = nil;
  }
  return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  [NSException raise:@"Not supported" format:@"Please use the designated initWithMessageStyle!"];
  return nil;
}

- (void)layoutSubviews {
	[super layoutSubviews];
  if ([message length] > 0) {
    CGRect bubbleFrame = self.bounds;
    
		UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize messageSize = [UPMessageTableViewCell sizeForMessageText:message];
    CGFloat deviceWidth = (UIDeviceOrientationIsLandscape(orientation)) ? 480 : 320;
		CGFloat margin =  deviceWidth - messageSize.width;
    bubbleFrame.size = messageSize;
    
    if (style == UPMessageTableViewCellStyleEven) {
      bubbleFrame.origin.x = margin;
    } 
    
    bubbleImageView.frame = bubbleFrame;
    bubbleImageView.hidden = NO;
    
    CGRect messageLabelFrame = bubbleFrame;
    messageLabelFrame.origin.x += kHorizontalPadding;
    messageLabelFrame.origin.y += kVerticalPadding;
    messageLabelFrame.size.width -= 2 * kHorizontalPadding;
    messageLabelFrame.size.height -= 2 * kVerticalPadding;
    NSUInteger numberOfLines = messageSize.height / [self.messageLabel.font lineHeight];
    self.messageLabel.numberOfLines = numberOfLines;
    self.messageLabel.frame = messageLabelFrame;
  } else {
		bubbleImageView.hidden = YES; 
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}


- (void)dealloc {
  [bubbleImageView release];
  bubbleImageView = nil;
  
  [messageLabel release];
  messageLabel = nil;
  
  [super dealloc];
}


- (UIImageView *)bubbleImageView {
  if (!bubbleImageView) {
	  UIImage *bubbleImage;
  	if (style == UPMessageTableViewCellStyleEven) {
    	bubbleImage = [UIImage imageNamed:@"Balloon_1.png"];
	  } else {
  	 	bubbleImage = [UIImage imageNamed:@"Balloon_2.png"];
	  }
  
		UIImage *stretchableBubbleImage = [bubbleImage stretchableImageWithLeftCapWidth:20 topCapHeight:16]; 
  
    bubbleImageView = [[UIImageView alloc] initWithImage:stretchableBubbleImage];
		bubbleImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (style == UPMessageTableViewCellStyleOdd) {
			bubbleImageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    }
  }
  return bubbleImageView;
}

- (UILabel *)messageLabel {
 	if (!messageLabel) {
    messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.font = [UIFont systemFontOfSize:kMessageFontSize];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.text = message;
    messageLabel.backgroundColor = [UIColor clearColor];
  }
  return messageLabel;
}

- (void)setMessage:(NSString *)newMessage {
  if (newMessage != message) {
		[message release];
    message = [newMessage retain];
    self.messageLabel.text = newMessage;
    [self setNeedsLayout];
  }
}

@end

@implementation UPMessageTableViewCell (BubbleSize)

+ (CGSize)sizeForMessageText:(NSString *)messageText {
  CGFloat marginFactor = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) 
  	? kLandscapeMarginFactor : kPortraitMarginFactor;
  
  CGFloat deviceWidth = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? 480.0 : 320.0;
  CGFloat width = (deviceWidth - 2 * kHorizontalPadding) * (1.0 - marginFactor);
  CGSize maxSize = CGSizeMake(width, 999.9);

  CGSize textSize = [messageText sizeWithFont:[UIFont systemFontOfSize:kMessageFontSize] constrainedToSize:maxSize];
  textSize.height += 2 * kVerticalPadding;
  textSize.width += 2 * kHorizontalPadding;
  return textSize; 
}

@end

