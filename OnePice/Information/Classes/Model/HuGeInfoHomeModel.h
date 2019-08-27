//
//  HuGeInfoHomeModel.h
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeInfoHomeModel : HuGeBaseModel

@property (nonatomic , assign) NSInteger              infoId;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * gettime;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              status;

@property(assign, nonatomic)CGFloat titleHeight;
@property(strong, nonatomic)NSAttributedString *attrTitle;

@property(assign, nonatomic)CGFloat contentHeight;
@property(strong, nonatomic)NSAttributedString *attrContent;

@end

NS_ASSUME_NONNULL_END
