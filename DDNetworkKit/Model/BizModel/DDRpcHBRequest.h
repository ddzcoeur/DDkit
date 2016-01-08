//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcRequest.h";

/**
 * 心跳请求
 * param:token
 */

@interface DDRpcHBRequest : DDRpcRequest

@property (nonatomic, strong) NSString *token;

@end