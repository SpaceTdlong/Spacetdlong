//
//  HuGeSQVideoLDetailHeaderView.m
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSQVideoLDetailHeaderView.h"

@implementation HuGeSQVideoLDetailHeaderView

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
            make.right.lessThanOrEqualTo(self.contentView).offset(-12);
        }];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateConstraints {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.contentView).offset(-12);
    }];
    [super updateConstraints];
}

#pragma mark - Lazy Loading
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRGB:0x101010];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

@end
