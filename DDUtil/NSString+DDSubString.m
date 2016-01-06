//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "NSString+DDSubString.h"


@implementation NSString (DDSubString)

- (NSArray *)separateWithString:(NSString *)substr{
    return [substr componentsSeparatedByString:substr];
}

- (NSString *)substringWithString:(NSString *)subStr{
    NSRange range = [self rangeOfString:subStr];
    if (range.length>0){
        NSString *newstr = [self substringToIndex:range.location];
        return newstr;
    }
    return self;
}

@end