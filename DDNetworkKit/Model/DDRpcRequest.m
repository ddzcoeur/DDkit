//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDRpcRequest.h"

@interface DDRpcRequest ()

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSData *content;
@property (nonatomic) int reqid;

@end

@implementation DDRpcRequest {

}

- (void)requestWithReqid:(int)reqId method:(NSString *)method content:(NSData *)content {
    self.reqid = reqId;
    self.method = method;
    self.content = content;
}
@end