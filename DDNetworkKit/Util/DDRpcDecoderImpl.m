//
// Created by Ayasofya on 16/1/8.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDRpcDecoderImpl.h"


@implementation DDRpcDecoderImpl {

}

- (NSDictionary *)decodeFromData:(NSData *)msg{
    NSMutableDictionary *contentDic = [NSMutableDictionary new];
    //TODO set headerflag
    int theReqId;
    [msg getBytes:&theReqId range:NSMakeRange(0,4)];
    int typeId;
    [msg getBytes:&typeId range:NSMakeRange(4,4)];
    NSNumber *reqid = [NSNumber numberWithInt:theReqId];
    NSNumber *type = [NSNumber numberWithInt:typeId];
    [contentDic setObject:reqid forKey:DDRpcDefine_RpcParam_ReqID];
    [contentDic setObject:type forKey:DDRpcDefine_RpcParam_Type];
    NSData *bodyContent = [msg subdataWithRange:NSMakeRange(8, [msg length]-1)];
    [contentDic setObject:bodyContent forKey:DDRpcDefine_RpcParam_Body];
    return contentDic;
}
@end