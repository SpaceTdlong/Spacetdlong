//
//  HuGeOpenBlackRoomModel.h
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeOpenBlackRoomModel : HuGeBaseModel

@property (nonatomic , assign) NSInteger              roomID;
@property (nonatomic , assign) NSInteger              room_type;
@property (nonatomic , copy) NSString              * room_name;
@property (nonatomic , copy) NSString              * brief;
@property (nonatomic , copy) NSString              * start_time;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              max_num;
@property (nonatomic , copy) NSString              * phone_num;
@property (nonatomic , assign) NSInteger              qq_num;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              is_master;
@property (nonatomic , assign) NSInteger              is_end;
@property (nonatomic , assign) NSInteger              is_join;
@property (nonatomic , strong) NSArray <HuGeOpenBlackUserModel *>              * joinlist;

@end

NS_ASSUME_NONNULL_END
