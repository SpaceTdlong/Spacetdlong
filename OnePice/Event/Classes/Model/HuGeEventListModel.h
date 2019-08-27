//
//  HuGeEventListModel.h
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeEventListModel : HuGeBaseModel

@property (nonatomic, strong) NSArray<HuGeEventModel *> *list;
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , assign) NSInteger              current_page;
@property (nonatomic , assign) NSInteger              per_page;
@property (nonatomic , assign) NSInteger              last_page;

@end

NS_ASSUME_NONNULL_END
