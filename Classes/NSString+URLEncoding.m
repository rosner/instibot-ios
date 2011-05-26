//
//  NSString+URLEncoding.m
//  instiBot
//
//  Created by Norman Rosner on 05.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "NSString+URLEncoding.h"

#import <Foundation/Foundation.h>

@implementation NSString (URLEncoding)

+ (NSString *)stringByURLEncoding:(NSString *)stringToBeEncoded {
	NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)stringToBeEncoded, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
  return [result autorelease];
}
@end
