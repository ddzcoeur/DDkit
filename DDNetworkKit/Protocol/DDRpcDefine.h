//
//  DDRpcDefine.h
//  DDKit
//
//  Created by Ayasofya on 16/1/11.
//  Copyright (c) 2016 ddz. All rights reserved.
//

#ifndef DDRpcDefine_h
#define DDRpcDefine_h


typedef enum DDRpcNotifType : int{
    RPCREQUEST=1,
    RPCACKRESPONSE=2,
    RPCNOTIFREQUEST=3,
    RPCRESPONSE=4,
    RPCHBREQUEST=5,
} DDRpcNotifType;


#define DDRpcDefine_RpcParam_ReqID  @"reqid"
#define DDRpcDefine_RpcParam_Type   @"type"
#define DDRpcDefine_RpcParam_RpcFlag    @"header_flag"
#define DDRpcDefine_RpcParam_Body   @"body"


#define DDRpcDefine_Method_Request  @"rpcRequest"
#define DDRpcDefine_Method_Hb       @"rpcHb"
#define DDRpcDefine_Method_Ack      @"rpcAck"
#define DDRpcDefine_Method_Notif    @"rpcNotif"
#define DDRpcDefine_Method_Response @"rpcRsp"


#endif /* DDRpcDefine_h */
