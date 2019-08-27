//
//  HuGeTestTableViewCell.m
//  DJAppCom
//
//  Created by sam on 2019/5/13.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "HuGeTestTableViewCell.h"

@interface HuGeTestTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation HuGeTestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
