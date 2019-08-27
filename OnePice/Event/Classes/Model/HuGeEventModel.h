//
//  HuGeEventModel.h
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeEventModel : HuGeBaseModel

@property (nonatomic, assign) NSInteger eventID;
@property (nonatomic , copy) NSString              * a_name;
@property (nonatomic , copy) NSString              * a_logo;
@property (nonatomic , assign) NSInteger              a_num;
@property (nonatomic , copy) NSString              * b_name;
@property (nonatomic , copy) NSString              * b_logo;
@property (nonatomic , assign) NSInteger              b_num;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * urls;
@property (nonatomic , copy) NSString              * g_img;
@property (nonatomic , copy) NSString              * g_time;
@property (nonatomic , copy) NSString              * g_type;
@property (nonatomic , assign) NSInteger              time;
@property (nonatomic , assign) NSInteger              status;

@end

NS_ASSUME_NONNULL_END
