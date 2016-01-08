//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDRpcProtocol <NSObject>

@optional

- (void)didReceivedMessage:(NSData *)msg;

- (void)didConnectToHost:(NSString *)hostAddr port:(NSString *)port;

- (void)didFailConnectToHost:(NSString *)hostAddr port:(NSString *)port andError:(NSError *)error;

- (void)didCloseConnectToHost:(NSString *)hostAddr port:(NSString *)port;

@end