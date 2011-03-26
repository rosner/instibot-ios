//
//  UPMessageInputField.h
//  instiBot
//
//  Created by Norman Rosner on 26.03.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UPMessageInputField : UIView {
	
  @private 
  UIButton *sendButton;
  
  UITextField *textField;
  
  UIImageView *textFieldCover;
}

@end
