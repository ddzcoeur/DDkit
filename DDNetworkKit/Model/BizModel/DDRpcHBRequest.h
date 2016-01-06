//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDRpcReuqest;

/**
 * 心跳请求
 * param:token
 */

@interface DDRpcHBRequest : DDRpcReuqest

@property (nonatomic, strong) NSString *token;

@end