//
//  HuGeCommentModel.h
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeCommentModel : HuGeBaseModel

@property (nonatomic , assign) NSInteger              commentID;
@property (nonatomic , assign) NSInteger              game_id;
@property (nonatomic , copy) NSString              * game_type;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , assign) NSInteger              u_id;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * time;

@end

NS_ASSUME_NONNULL_END
