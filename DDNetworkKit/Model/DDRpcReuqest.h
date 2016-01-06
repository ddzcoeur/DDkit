//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DDRpcReuqest : NSObject

- (NSData *)convertToData;

- (void)requestWithReqid:(int)reqId method:(NSString *)method content:(NSData *)content;

@end