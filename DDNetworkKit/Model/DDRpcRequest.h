//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcDefine.h"


@interface DDRpcRequest : NSObject

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSData *content;
@property (nonatomic) int reqid;

- (NSData *)convertToData;

- (void)requestWithReqid:(int)reqId method:(NSString *)method content:(NSData *)content;
- (int)convertMethod:(NSString *)method;
@end