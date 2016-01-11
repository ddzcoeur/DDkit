//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDRpcRequest.h"

@interface DDRpcRequest ()



@end

@implementation DDRpcRequest {

}

- (void)requestWithReqid:(int)reqId method:(NSString *)method content:(NSData *)content {
    self.reqid = reqId;
    self.method = method;
    self.content = content;
}

- (NSData *)convertToData {
    NSMutableData *data = [NSMutableData new];
    if (self.reqid>=0){
        int reqid = self.reqid;
        [data appendBytes:&reqid length:4];
    }
    int type = [self convertMethod:self.method];
    if (type>0){
        [data appendBytes:&type length:4];
    }
    if (self.content.length>0){
        [data appendData:self.content];
    }
    return data;
}

- (int)convertMethod:(NSString *)method {
    if ([method isEqualToString:DDRpcDefine_Method_Request]){
        return RPCREQUEST;
    } else if ([method isEqualToString:DDRpcDefine_Method_Ack]){
        return RPCACKRESPONSE;
    } else if ([method isEqualToString:DDRpcDefine_Method_Notif]){
        return RPCNOTIFREQUEST;
    } else if ([method isEqualToString:DDRpcDefine_Method_Response]){
        return RPCRESPONSE;
    } else if([method isEqualToString:DDRpcDefine_Method_Hb]){
        return RPCHBREQUEST;
    } else{
        return -1;
    }
}
@end