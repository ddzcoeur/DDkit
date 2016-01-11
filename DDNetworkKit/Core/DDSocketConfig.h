//
// Created by Ayasofya on 16/1/11.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DDSocketConfig : NSObject
@property (nonatomic, strong) NSString *urlAddr;
@property (nonatomic) int timeOut;
@property (nonatomic, strong) NSString *token;
@end