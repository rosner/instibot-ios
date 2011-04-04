//
//  UPMessageTableViewCell.h
//  instiBot
//
//  Created by Norman Rosner on 03.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
  UPMessageTableViewCellStyleEven,
  
  UPMessageTableViewCellStyleOdd
  
} UPMessageTableViewCellStyle;


@interface UPMessageTableViewCell : UITableViewCell {

  @private
  UPMessageTableViewCellStyle style;
  
  UIImageView *bubbleImageView;
  
  NSString *message;
  
  UILabel *messageLabel;
}

@property (nonatomic, assign) UPMessageTableViewCellStyle style;

@property (nonatomic, copy) NSString *message;

- (id)initWithMessageStyle:(UPMessageTableViewCellStyle )messageStyle reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface UPMessageTableViewCell (BubbleSize)

+ (CGSize)sizeForMessageText:(NSString *)messageText;

@end