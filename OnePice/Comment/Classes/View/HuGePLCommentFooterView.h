//
//  EMGLCommentFooterView.h
//  BiGuoDJ
//
//  Created by zaifeng wu on 2019/4/9.
//  Copyright © 2019 BG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGePLCommentFooterView : UIView
@property (nonatomic, copy) void(^changeBottomConstraintBlock)(CGFloat height);
@property (nonatomic, copy) void(^changeFooterViewHeightBlock)(CGFloat height);
@property (nonatomic, copy) void(^sendCommentBlock)(NSString *commentContent);
- (void)reset;
@end

NS_ASSUME_NONNULL_END
