//
//  EMGLCommentFooterView.m
//  BiGuoDJ
//
//  Created by zaifeng wu on 2019/4/9.
//  Copyright © 2019 BG. All rights reserved.
//

#import "HuGePLCommentFooterView.h"


@interface HuGePLCommentFooterView () <UITextViewDelegate>
{
    CGFloat preHei;
}
/// 底部View
@property (weak, nonatomic) IBOutlet UIView *footView;

@property (weak, nonatomic) IBOutlet IQTextView *textview;

/// 发送按钮
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (weak, nonatomic) IBOutlet UIView *textViewBgView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHei;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footViewHei;
@end

@implementation HuGePLCommentFooterView

#define FootView_Hei 50

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.textViewBgView.layer.cornerRadius = 5;
    self.textViewBgView.layer.borderWidth = 1;
    self.textViewBgView.layer.borderColor = [[UIColor colorWithHexString:@"ececec"] CGColor];
    [self.textViewBgView.layer setMasksToBounds:YES];
    
    [self.sendBtn setImage:ESImage(@"PL_fasong") forState:UIControlStateNormal];
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 键盘处理
- (void)em_addKeyBoardObserver
{
    [self em_removeKeyBoardObserver];
    //监听键盘高度变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)em_removeKeyBoardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [weakSelf willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    CGFloat changeHei=toFrame.origin.y-beginFrame.origin.y;
    CGFloat hei;
    //DLog(@"%f",changeHei);
    if (beginFrame.origin.y == kScreenHeight&&changeHei!=0) {
        hei = -changeHei;
    } else if (toFrame.origin.y == kScreenHeight) {
        //收缩键盘
        hei = 0;
    } else {
        //键盘高度更改
       hei = toFrame.size.height;
    }
    if (self.changeBottomConstraintBlock) {
        self.changeBottomConstraintBlock(hei);
    }
}

#pragma mark textView代理方法
-(void)textViewDidChange:(UITextView *)textView
{
    
    float hei = [self heightForString:textView andWidth:textView.width];
    
    if (hei>preHei) {
        if (hei == 49.5) {
            self.footViewHei.constant = FootView_Hei + (hei-preHei);
            self.textViewHei.constant = hei;
        }
        else if (hei > 83) {
            self.footViewHei.constant = 88+16;
            self.textViewHei.constant = 88;
        } else {
            self.footViewHei.constant = hei +16;
            self.textViewHei.constant = hei;
        }
    } else if (hei<preHei) {
        if (hei == 33) {
            self.footViewHei.constant = FootView_Hei;
            self.textViewHei.constant = hei;
        }
        else if (hei == 49.5) {
            self.footViewHei.constant = FootView_Hei + (preHei-hei);
            self.textViewHei.constant = hei;
        } else if (hei > 83) {
            self.footViewHei.constant = 88+16;
            self.textViewHei.constant = 88;
        } else {
            self.footViewHei.constant = hei +16;
            self.textViewHei.constant = hei;
        }
        
    } else {
        
    }
    [self layoutSubviews];
    preHei = hei;
    if (textView.text.length > 140) {
        textView.text = [textView.text substringToIndex:140];
    }
    
    
    if (textView.scrollEnabled) {
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length - 2, 1)];
    }
    if (self.changeFooterViewHeightBlock) {
        self.changeFooterViewHeightBlock(self.footViewHei.constant);
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        // 发送
        [self sendBtnAction:nil];
        return NO;
    }
    if (text.length == 0) return YES;
    
    NSInteger existedLength = textView.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = text.length;
    if (existedLength - selectedLength + replaceLength > 140) {
        return NO;
    }
    
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    
}

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}




#pragma mark 点击发送按钮,创建评论
- (IBAction)sendBtnAction:(id)sender {
    
    if (self.textview.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    self.sendCommentBlock(self.textview.text);
}

- (void)reset {
    self.textview.text = @"";
    self.footViewHei.constant = FootView_Hei;
    self.textViewHei.constant = 33;
    self.textview.scrollEnabled = NO;
    if (self.changeFooterViewHeightBlock) {
        self.changeFooterViewHeightBlock(self.footViewHei.constant);
    }
}


@end
