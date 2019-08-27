//
//  EMYHFeedbackVC.m
//  Demo
//
//  Created by 刘兴坤 on 2018/12/6.
//  Copyright © 2018年 whbalzac. All rights reserved.
//

#import "EMYHFeedbackVC.h"

@interface EMYHFeedbackVC ()
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation EMYHFeedbackVC
+ (EMYHFeedbackVC *)em_loadVC {
    EMYHFeedbackVC *vc = [[EMYHFeedbackVC alloc]initWithNibName:NSStringFromClass([EMYHFeedbackVC class]) bundle:[NSBundle bundleForClass:[EMYHFeedbackVC class]]];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    self.enterButton.backgroundColor = [UIColor appMainColor];
    [self.enterButton addTarget:self action:@selector(em_commitBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)em_commitBtn:(UIButton *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"反馈" message:@"反馈成功，我们会跟进您所反馈的问题，祝你使用愉快" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancleAc = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self popoverPresentationController];
    }];
    [alertController addAction:cancleAc];
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
