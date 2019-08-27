//
//  HuGeInfoHomeModel.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoHomeModel.h"

@implementation HuGeInfoHomeModel



+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"infoId":@"id"};
}

- (NSAttributedString *)attrTitle {
    if (!_attrTitle) {
        if (self.title.length > 0) {
            NSMutableAttributedString *introDetail = [[NSMutableAttributedString alloc] initWithString:self.title];
            introDetail.yy_font = [UIFont systemFontOfSize:18];
            introDetail.yy_lineSpacing = 8;
            introDetail.yy_color = UIColorHex(282828);
            _attrTitle = introDetail;
        }
    }
    return _attrTitle;
}

- (CGFloat)titleHeight {
    if (!_titleHeight) {
        _titleHeight = 66;
        if (self.title) {
            _titleHeight += [self calculateHeightWithAttrText:self.attrTitle rowNumber:0];
        }
    }
    return _titleHeight;
}

- (NSAttributedString *)attrContent {
    if (!_attrContent) {
        if (self.title.length > 0) {
            NSMutableAttributedString *introDetail = [[NSMutableAttributedString alloc] initWithString:self.text];
            introDetail.yy_font = [UIFont systemFontOfSize:14];
            introDetail.yy_lineSpacing = 8;
            introDetail.yy_color = UIColorHex(282828);
            _attrContent = introDetail;
        }
    }
    return _attrContent;
}

- (CGFloat)contentHeight {
    if (!_contentHeight) {
        _contentHeight = 56;
        if (self.text) {
            _contentHeight += [self calculateHeightWithAttrText:self.attrContent rowNumber:0];
        }
    }
    return _contentHeight;
}

- (CGFloat )calculateHeightWithAttrText:(NSAttributedString *)attrStr rowNumber:(NSUInteger)rowNumber {
    if (!attrStr) {
        return 0.0;
    }
    CGFloat width = SCREEN_WIDTH - 24;
    CGSize introSize = CGSizeMake(width, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attrStr];
    CGFloat introHeight = layout.textBoundingSize.height * 1.08;
    if (rowNumber > 0) {
        // 具体行数限制
        NSUInteger maxRowNumber = layout.rowCount > rowNumber ? rowNumber : layout.rowCount;
        introHeight = ceil(introHeight/layout.rowCount*maxRowNumber);
    }
    return introHeight;
}

@end
