//
//  HuGeUserCenterVC.m
//  HuGeDJ
//
//  Created by edz on 2019/8/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserCenterVC.h"

@interface HuGeUserCenterVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *describe;
@property (weak, nonatomic) IBOutlet UILabel *phoneNub;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic , strong) NSString * imgUrl;


@property (nonatomic, strong) HuGeUserModel * model;

@end

@implementation HuGeUserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHuGeDagta];
    self.navigationItem.title = @"用户中心";
    [self.saveBtn setBackgroundColor:[UIColor appMainColor]];
    self.avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAvatar)];
    [self.avatar addGestureRecognizer:tap];
}
-(void)updateAvatar{
    [self huGe_showAlbumOptions:self.picker];
}
-(void)getHuGeDagta{
    @weakify(self);
    [HuGeUserManager huGe_dataUserInfotWithSuccess:^(HuGeUserModel * _Nonnull user, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        self.model = user;
        [self huGeRefreshUI];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)huGeRefreshUI{
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    self.userName.text = self.model.nickname;
    self.describe.text = self.model.bio;
    self.email.text = self.model.email;
    self.phoneNub.text = self.model.mobile;
}
- (IBAction)saveClick:(id)sender {
    
    self.model.nickname = self.userName.text;
    self.model.bio = self.describe.text;
    
    [HuGeUserManager huGe_updataInfoWithNickname:self.model.nickname bio:self.model.bio email:self.model.email avatar:self.model.avatar success:^(BOOL logState) {
        if (logState == YES) {
            [SVProgressHUD showSuccessWithStatus:@"更新成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //    self.userIcon.image = image;
    //    self.index = -2;
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [self em_uploadAvatar:data with:image];
}
- (void)em_uploadAvatar:(NSData *)data with:(UIImage *)image{
    [SVProgressHUD show];
    [HuGeCommunityManager huGe_uploadAvatar:data success:^(NSString * _Nonnull filePath) {
        [SVProgressHUD dismiss];
        self.model.avatar = filePath;
        [self.avatar setImage:image];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"上传头像失败，如果还是失败，可以选择较小的头像图片"];
    }];
}
//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)huGe_showAlbumOptions:(UIImagePickerController *)picker{
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [[UIViewController currentTopViewController] presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *camaraAction = [UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            [SVProgressHUD showErrorWithStatus:@"无法打开相机，已打开本地相册"];
        }
        [[UIViewController currentTopViewController] presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtr addAction:imagePickerAction];
    [alertCtr addAction:camaraAction];
    [alertCtr addAction:cancelAction];
    
    [[UIViewController currentTopViewController] presentViewController:alertCtr animated:YES completion:^{
        
    }];
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
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
