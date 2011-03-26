//
//  UPMessageInputField.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessageInputField.h"


static CGFloat kButtonHeight = 27.0;

// (40 - 27) / 2; normal height - height of button
static CGFloat kVerticalPadding = 8.0;

static CGFloat kHorizontalPadding = 6.5;

@implementation UPMessageInputField

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
  if (self) {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MessageEntryBG.png"]];
    
    textField = [[UITextField alloc] initWithFrame:CGRectZero];
    UIImage *balloonInputImage = [UIImage imageNamed:@"BalloonInputField.png"];
		textField.background = [balloonInputImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    [self addSubview:textField];
    
    sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle: NSLocalizedString(@"Send", @"Send the current message") forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    sendButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIImage *normalStateImage = [UIImage imageNamed:@"SendButton.png"];
    UIImage *stretchableNormalStateImage = [normalStateImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    [sendButton setBackgroundImage:stretchableNormalStateImage forState:UIControlStateNormal];
    
    UIImage *pressedStateImage = [UIImage imageNamed:@"SendButtonPressed.png"];
    UIImage *stretchablePressedStateImage = [pressedStateImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    [sendButton setBackgroundImage:stretchablePressedStateImage forState:UIControlStateSelected];

    [self addSubview:sendButton];
    
    UIImage *coverImage = [UIImage imageNamed:@"input-field-cover.png"];
    UIImage *stretchableCoverImage = [coverImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    textFieldCover = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    textFieldCover.image = stretchableCoverImage;
    
    [self addSubview:textFieldCover];
  }
  return self;
}

- (void)layoutSubviews {
  CGFloat widthFactor = (self.frame.size.width - kHorizontalPadding - kHorizontalPadding) / 5.0;
  CGRect textFieldFrame = CGRectMake(kHorizontalPadding, 0.0, widthFactor * 4.0, 40.0);
	textField.frame = textFieldFrame;
  textFieldCover.frame = textFieldFrame;
  
  CGFloat xOffset = CGRectGetMaxX(textFieldFrame);
  CGRect sendButtonFrame = CGRectMake(xOffset, kVerticalPadding, widthFactor * 1.0, kButtonHeight);

  sendButton.frame = sendButtonFrame;

}

- (void)dealloc {
  [sendButton release];
  sendButton = nil;
  
  [textField release];
  textField = nil;
  
  [textFieldCover release];
  textFieldCover = nil;
  
  [super dealloc];
}


@end
