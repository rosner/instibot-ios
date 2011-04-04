//
//  UPApiAdapterDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 04.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UPApiAdapterDelegate <NSObject>


@optional

- (void)apiAdapter:(UPApiAdapter *)apiAdapter didReceiveBotResponse:(NSString *)answer;

@end
