//
//  HuGeCommunityModel.h
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeCommunityModel : HuGeBaseModel

@property (nonatomic, assign) NSInteger commID;
@property (nonatomic , assign) NSInteger              u_id;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * com_num;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * agree;
@property (nonatomic , copy) NSString              * isagree;

@property (nonatomic , copy) NSString              * time;

@property (nonatomic , strong) NSArray <HuGeCommentModel *>  * commentlist;

@end

NS_ASSUME_NONNULL_END
