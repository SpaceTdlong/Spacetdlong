//
//  HuGeSPVideoDetailView.m
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoDetailView.h"

@interface  HuGeSPVideoDetailView()

@property (nonatomic, strong) UILabel *titleaLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *playIconImageView;
@property (nonatomic, strong) UILabel *playNumberLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *authorHotLabel;
@property (nonatomic, strong) UIView *opView;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) UILabel *favoriteLabel;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *reportButton;

@end

@implementation HuGeSPVideoDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleaLabel];
        [self addSubview:self.descriptionLabel];
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.playIconImageView];
        [self addSubview:self.playNumberLabel];
        [self addSubview:self.opView];
        [self.opView addSubview:self.avatarImageView];
        [self.opView addSubview:self.authorLabel];
        //        [self.opView addSubview:self.authorHotLabel];
        [self.opView addSubview:self.favoriteLabel];
        [self.opView addSubview:self.favoriteButton];
        [self.opView addSubview:self.reportButton];
        //        [self.opView addSubview:self.shareButton];
        [self addConstraints];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addConstraints {
    [self.titleaLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(12);
        make.right.lessThanOrEqualTo(self).offset(-12);
    }];
    [self.playIconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleaLabel);
        make.top.equalTo(self.titleaLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(14, 8));
    }];
    [self.playNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playIconImageView.mas_right).offset(2);
        make.centerY.equalTo(self.playIconImageView);
    }];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self.playIconImageView);
    }];
    [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleaLabel);
        make.top.equalTo(self.playIconImageView.mas_bottom).offset(10);
        make.right.equalTo(self.titleaLabel);
    }];
    [self.opView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
    }];
    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.opView).offset(12);
        make.centerY.equalTo(self.opView);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [self.authorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(4);
        make.centerY.equalTo(self.avatarImageView);
    }];

    
    [self.favoriteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.opView).offset(-12);
        make.centerY.equalTo(self.opView);
    }];
    [self.favoriteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.favoriteLabel.mas_left).offset(4);
        make.centerY.equalTo(self.opView).offset(-2);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.reportButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.favoriteButton.mas_left).offset(-12);
        make.centerY.equalTo(self.opView);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
}

- (void)setModel:(HuGeSPVideoHomeModel *)model {
    if (!_model) {
        kFixCodePosition6
    }
    _model = model;
    self.titleaLabel.text = model.title;

}

- (void)setIsSupportLike:(BOOL)isSupportLike {
    _isSupportLike = isSupportLike;
    self.favoriteButton.hidden = !isSupportLike;
    self.favoriteLabel.hidden = !isSupportLike;
}

+ (CGFloat)em_heightWithTitle:(NSString *)title description:(NSString *)description {
    CGFloat titleHeight = [title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(SCREEN_WIDTH-24, CGFLOAT_MAX)].height;
    CGFloat descriptionHeight = [description sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH-24, CGFLOAT_MAX)].height;
    CGFloat height = 12+titleHeight+10+14+10+descriptionHeight+10+50;
    return height;
}

- (void)em_reportAction:(UIButton *)button {
    [SVProgressHUD showWithStatus:@"举报中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"举报成功，我们会二十四小时内对该内容进行审核。谢谢您的反馈！"];
    });
}

#pragma mark - Lazy Loading
- (UILabel *)titleaLabel {
    if (!_titleaLabel) {
        _titleaLabel = [[UILabel alloc] init];
        _titleaLabel.font = [UIFont systemFontOfSize:16];
        _titleaLabel.textColor = [UIColor colorWithRGB:0x101010];
        _titleaLabel.numberOfLines = 0;
        if (!_titleaLabel) {
            kFixCodePosition5
        }
    }
    return _titleaLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textColor = [UIColor darkGrayColor];
        _descriptionLabel.numberOfLines = 0;
        if (!_titleaLabel) {
            kFixCodePosition4
        }
    }
    return _descriptionLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor darkGrayColor];
    }
    return _timeLabel;
}

- (UIImageView *)playIconImageView {
    if (!_playIconImageView) {
        _playIconImageView = [[UIImageView alloc] init];
        _playIconImageView.image = ESImage(@"sp_play_number_icon");
    }
    return _playIconImageView;
}

- (UILabel *)playNumberLabel {
    if (!_playNumberLabel) {
        _playNumberLabel = [[UILabel alloc] init];
        _playNumberLabel.font = [UIFont systemFontOfSize:12];
        _playNumberLabel.textColor = [UIColor darkGrayColor];
    }
    return _playNumberLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.image = ESImage(@"sp_default_author");
        _avatarImageView.layer.cornerRadius = 16;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:12];
        _authorLabel.textColor = [UIColor darkGrayColor];
    }
    return _authorLabel;
}

- (UILabel *)authorHotLabel {
    if (!_authorHotLabel) {
        _authorHotLabel = [[UILabel alloc] init];
        _authorHotLabel.font = [UIFont systemFontOfSize:12];
        _authorHotLabel.textColor = [UIColor darkGrayColor];
    }
    return _authorHotLabel;
}

- (UIView *)opView {
    if (!_opView) {
        _opView = [[UIView alloc] init];
    }
    return _opView;
}

- (UILabel *)favoriteLabel {
    if (!_favoriteLabel) {
        _favoriteLabel = [[UILabel alloc] init];
        _favoriteLabel.font = [UIFont systemFontOfSize:14];
        _favoriteLabel.textColor = [UIColor colorWithRGB:0x8a8a8a];
    }
    return _favoriteLabel;
}

- (UIButton *)reportButton {
    if (!_reportButton) {
        _reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportButton setTitle:@"举报" forState:UIControlStateNormal];
        [_reportButton setTitleColor:[UIColor colorWithRGB:0xA7A4A4] forState:UIControlStateNormal];
        _reportButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_reportButton addTarget:self action:@selector(em_reportAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reportButton;
}

@end
