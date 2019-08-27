//
//  HuGeCommentListModel.h
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeCommentListModel : HuGeBaseModel

@property (nonatomic, strong) NSArray<HuGeCommentModel *> *list;
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , assign) NSInteger              current_page;
@property (nonatomic , assign) NSInteger              per_page;
@property (nonatomic , assign) NSInteger              last_page;

@end

NS_ASSUME_NONNULL_END
