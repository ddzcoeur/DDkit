//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DDSocketHelper : NSObject

+ (DDSocketHelper *)getInstance;

- (int)getNextReqid;


@end