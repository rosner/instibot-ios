//
//  UPMessageInputField.h
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UPMessageInputFieldDelegate;

@interface UPMessageInputField : UIView <UITextViewDelegate> {
	
  @private 
  UIButton *sendButton;
  
  UITextView *textView;
  
  UIImageView *textViewCover;
  
  BOOL firstTimeLayout;
  
  id<UPMessageInputFieldDelegate> delegate;
  
  CGFloat previousTextViewHeight;
}

@property (nonatomic, retain) IBOutlet id<UPMessageInputFieldDelegate> delegate;

@end

