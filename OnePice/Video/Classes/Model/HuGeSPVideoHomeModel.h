//
//  HuGeSPVideoHomeModel.h
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeSPVideoHomeModel : HuGeBaseModel


@property (nonatomic , assign) NSInteger              videoID;
@property (nonatomic , assign) NSInteger              type_id;
@property (nonatomic , copy) NSString              * type_name;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * link;
@property (nonatomic , copy) NSString              * img_src;
@property (nonatomic , copy) NSString              * duration;
@property (nonatomic , copy) NSString              * up_time;
@property (nonatomic , assign) NSInteger              time;
@property (nonatomic , assign) NSInteger              view_counts;


@end

NS_ASSUME_NONNULL_END
