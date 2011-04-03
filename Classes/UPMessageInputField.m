//
//  UPMessageInputField.m
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPMessageInputField.h"
#import "UPMessageInputFieldDelegate.h"

static CGFloat kButtonHeight = 27.0;

// (40 - 27) / 2; normal height - height of button
static CGFloat kVerticalPadding = 5.0;

static CGFloat kHorizontalPadding = 6.5;

static CGFloat kDefaultTextViewHeight = 37.0;

@implementation UPMessageInputField

@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
  if (self) {
    UIImage *backgroundImage = [UIImage imageNamed:@"MessageEntryBG.png"];
    UIImage *stretchableBackgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:4 topCapHeight:20];
		UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    backgroundImageView.image = stretchableBackgroundImage;
    backgroundImageView.tag = 501;
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | 
    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:backgroundImageView];
    [backgroundImageView release];
    
    textView = [[UITextView alloc] initWithFrame:CGRectZero];    
    textView.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    textView.scrollEnabled = NO;
    textView.scrollsToTop = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.contentOffset = CGPointZero;
    textView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0, 0.0, 10.0, 8.0);
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textView.delegate = self;
    
    [self addSubview:textView];
    
    sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle: NSLocalizedString(@"Send", @"Send the current message") forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    sendButton.titleLabel.textColor = [UIColor whiteColor];
    sendButton.backgroundColor = [UIColor clearColor];
    
    UIImage *normalStateImage = [UIImage imageNamed:@"SendButton.png"];
    UIImage *stretchableNormalStateImage = [normalStateImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    [sendButton setBackgroundImage:stretchableNormalStateImage forState:UIControlStateNormal];
    
    UIImage *pressedStateImage = [UIImage imageNamed:@"SendButtonPressed.png"];
    UIImage *stretchablePressedStateImage = [pressedStateImage stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    [sendButton setBackgroundImage:stretchablePressedStateImage forState:UIControlStateSelected];
    
    [self addSubview:sendButton];
    
    UIImage *coverImage = [UIImage imageNamed:@"input-field-cover.png"];
    UIImage *stretchableCoverImage = [coverImage stretchableImageWithLeftCapWidth:13 topCapHeight:20];
    
    textViewCover = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    textViewCover.image = stretchableCoverImage;
    
    [self addSubview:textViewCover];
    firstTimeLayout = NO;
    previousTextViewHeight = kDefaultTextViewHeight; // this is hacky! It's the initial content size height of the text view after the 
    //first letter is typed
  }
  return self;
}

- (void)layoutSubviews {
  [[self viewWithTag:501] setFrame:self.bounds];
  CGFloat widthFactor = (self.frame.size.width - kHorizontalPadding - kHorizontalPadding) / 5.0;  
  CGRect textFieldFrame = CGRectMake(8.0, 2.0, widthFactor * 4.0 , 38.0);
  CGRect coverFrame;
  if (!firstTimeLayout) {
    
    textView.contentOffset = CGPointZero;
    
    firstTimeLayout = YES;
  } else {
		textFieldFrame.size.height = self.frame.size.height - 2.0;
  }
  
  coverFrame = textFieldFrame;
  coverFrame.origin.y = 0.0;
  coverFrame.size.height = self.frame.size.height;
  
  //  NSLog(@"content size %f %f", textView.contentSize.width, textView.contentSize.height);
  //  NSLog(@"textview frame size %f %f", textView.frame.size.width, textView.frame.size.height);
  //  NSLog(@"frame size %f %f", self.frame.size.width, self.frame.size.height);  
  
  textView.frame = textFieldFrame;
  textViewCover.frame = coverFrame;
  
  CGFloat xOffset = CGRectGetMaxX(textFieldFrame);
  CGFloat yOffset = CGRectGetMaxY(self.bounds) - kVerticalPadding - kButtonHeight;
  CGRect sendButtonFrame = CGRectMake(xOffset, yOffset, widthFactor * 1.0, kButtonHeight);
  
  sendButton.frame = sendButtonFrame;
}

- (void)dealloc {
  [sendButton release];
  sendButton = nil;
  
  [textView release];
  textView = nil;
  
  [textViewCover release];
  textViewCover = nil;
  
  [delegate release];
  delegate = nil;
  
  [super dealloc];
}

- (void)textViewDidChange:(UITextView *)_textView {
  CGSize textSize = [_textView.text sizeWithFont:_textView.font constrainedToSize:_textView.contentSize];
  NSUInteger numberOfLines = textSize.height / _textView.font.lineHeight;
  
  if (numberOfLines < 5) {
    
    // check if there's a delegate
    if (delegate && [delegate conformsToProtocol:@protocol(UPMessageInputFieldDelegate)]) {
      CGFloat newHeight = _textView.contentSize.height;
      
      if ([_textView.text length] == 0) {
        newHeight = kDefaultTextViewHeight;
      }
      
      CGFloat delta = fabsf(newHeight - previousTextViewHeight);
      NSLog(@"delta %f", delta);
      if (delta > 0.0) {
        if (newHeight >= previousTextViewHeight) {
          [delegate messageInputField:self shouldGrowWithDelta:delta];
        } else {
          [delegate messageInputField:self shouldShrinkWithDelta:delta];
        }
      }
      previousTextViewHeight = newHeight;
    }
    
    _textView.scrollEnabled = NO;
  } else {
    _textView.scrollEnabled = YES;
  }
}

@end
