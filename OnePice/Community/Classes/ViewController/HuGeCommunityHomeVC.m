//
//  HuGeCommunityHomeVC.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityHomeVC.h"

@interface HuGeCommunityHomeVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIImagePickerController *picker;

@property (nonatomic , strong) NSString * imgUrl;
@property (nonatomic , strong) NSString * content;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic, strong) UIImage * curentImage;


@end

@implementation HuGeCommunityHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViewController];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    self.addBtn.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)rightBarButtonClick{
    self.content = self.textView.text;
    if (!self.content || self.content.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        return;
    }else if (!self.imgUrl){
        self.imgUrl = @"";
    }
    [HuGeCommunityManager huGe_uploadCommunity:self.imgUrl content:self.content success:^(NSString * _Nonnull success) {
        if ([success isEqualToString:@"add comment successful"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    if (!self.title) {
        self.title = @"发布帖子";
    }
    self.view.backgroundColor = [UIColor appBackgroundColor];
}
- (IBAction)imgClick:(id)sender {
    [self huGe_showAlbumOptions:self.picker];
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
        self.imgUrl = filePath;
        [self.addBtn setImage:image forState:UIControlStateNormal];
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
