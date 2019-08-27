//
//  HuGeUserHomeViewController.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserHomeViewController.h"

@interface HuGeUserHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString *cache;
@property (nonatomic, copy) NSString *loginStr;
@end

@implementation HuGeUserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    //    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat caches = [self em_folderSizeAtPath: [self em_getCachesPath]];
    self.cache = [NSString stringWithFormat:@"%.02fMB",caches];
    NSArray *arr4 = @[@"我的帖子",@"我的消息",@"黑名单"];
    NSArray *arr = @[@"当前版本",@"分享朋友"];// @"意见反馈",
    NSArray *arr1 = @[@"清理缓存", @"意见反馈"];
    NSArray *arr2 = @[@"退出登录"];
    NSArray *arr3 = @[@"登录"];
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefault objectForKey:@"token"];
    if (!token) {
        self.titleArray = @[arr4,arr, arr1,arr3];
    }else{
        self.titleArray = @[arr4,arr, arr1,arr2];
    }
    
    
    CGFloat height = SCREEN_WIDTH * 9 / 20 + 20;
    CGFloat imgHeight = 75;
    self.tableView.sectionHeaderHeight = height;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height - 20)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - imgHeight / 2  , 28, imgHeight, imgHeight)];
    imageView.layer.cornerRadius = imgHeight / 2;
    //    imageView.backgroundColor = [UIColor purpleColor];
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"AppIcon"];
    imageView.layer.borderColor = [UIColor appMainColor].CGColor;
    [headView addSubview:imageView];
    imageView.layer.borderWidth = 1;
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUser)];
    [imageView addGestureRecognizer:tap];
    
    _tableView.tableHeaderView = headView;
    
    UILabel *label = [[UILabel alloc]init];
    NSString *appName = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    if ([appName isEqualToString:@"(null)"]) {
        appName = @"合上科技";
    }
    label.text = appName;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor darkGrayColor];
    [headView addSubview:label];
    
    UILabel *copyrightlabel = [[UILabel alloc]init];
    copyrightlabel.text = [NSString stringWithFormat:@"Copyright © 2019年 %@. All rights reserved.",appName];
    copyrightlabel.textAlignment = NSTextAlignmentCenter;
    copyrightlabel.font = [UIFont systemFontOfSize:11];
    copyrightlabel.textColor = [UIColor grayColor];
    [headView addSubview:copyrightlabel];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    [copyrightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(10);
    }];
    
    UIBarButtonItem * righgt  = [[UIBarButtonItem alloc] initWithTitle:@"用户信息" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    righgt.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = righgt;
    
}
-(void)rightBarButtonClick{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefault objectForKey:@"token"];
    if (!token) {
        [self.navigationController pushViewController:[[HuGeUserLoginViewController alloc] init] animated:YES];
    }else{
        [self.navigationController pushViewController:[[HuGeUserCenterVC alloc] init] animated:YES];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
-(void)huGe_myPost{
    
}
-(void)tapUser{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefault objectForKey:@"token"];
    
    if (!token) {
        [self.navigationController pushViewController:[[HuGeUserLoginViewController alloc] init] animated:YES];
    }
}

- (void)em_loadLoginState {
    _loginStr = @"意见反馈";
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.titleArray[section];
    return arr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        static NSString *cellID = @"CellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        NSArray *array = self.titleArray[indexPath.section];
        cell.textLabel.text = array[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_set%ld",indexPath.row+1]];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            
        }else if (indexPath.section == 3){
            cell.textLabel.text = @"";
            UILabel * logState = [self.view viewWithTag:10086];
            if (!logState) {
                logState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            }
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            NSString * token = [userDefault objectForKey:@"token"];
            logState.tag = 10086;
            if (!token) {
                logState.textColor = [UIColor blueColor];
                logState.text = @"登             录";
            }else{
                logState.textColor = [UIColor redColor];
                logState.text = @"退出登录";
            }
            
            logState.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:logState];
        }else if(indexPath.section == 2){
            
            if (indexPath.row == 0){
                cell.detailTextLabel.text = self.cache;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            if (indexPath.row == 1){
                cell.textLabel.text = @"意见反馈";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            EMYHFeedbackVC * vc = [EMYHFeedbackVC em_loadVC];//[[EMYHFeedbackVC alloc] initWithNibName:NSStringFromClass([EMYHFeedbackVC class]) bundle:ESBundle];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 0) {
            if ([self.cache isEqualToString:@"0.00M"]) {
                return;
            }else{
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定清除？" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    //
                }]];
                @weakify(self);
                [alertController addAction:[UIAlertAction actionWithTitle:@"立即清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //
                    @strongify(self);
                    self.cache = @"0.00M";
                    [self.tableView reloadData];
                    [self showAlertClearn];
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            NSString *shareText = @"";
            UIImage *shareImage = [UIImage imageNamed:@"AppIcon"];
            NSURL *shareURL = [NSURL URLWithString:@"https://www.jianshu.com/p/fb345e24a266"];
            NSArray *activityItems = [[NSArray alloc] initWithObjects:shareText, shareImage, shareURL, nil];
            
            UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            
            UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
                NSLog(@"%@",activityType);
                if (completed) {
                    //            NSLog(@"分享成功");
                } else {
                    //            NSLog(@"分享失败");
                }
                [vc dismissViewControllerAnimated:YES completion:nil];
            };
            
            vc.completionWithItemsHandler = myBlock;
            
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else if (indexPath.section == 3){
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSString * token = [userDefault objectForKey:@"token"];
        if (!token) {
            [self.navigationController pushViewController:[[HuGeUserLoginViewController alloc] init] animated:YES];
        }else{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [self.tableView reloadData];
        }
    }else if (indexPath.section == 0){
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSString * token = [userDefault objectForKey:@"token"];
        if (!token) {
            [self.navigationController pushViewController:[[HuGeUserLoginViewController alloc] init] animated:YES];
        }else{
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:[[HuGeCommunityMyListVC alloc] init] animated:YES];
                
            }else if (indexPath.row == 2){
                [self.navigationController pushViewController:[[HuGeUserBlackListVC alloc] init] animated:YES];
            }else{
                [self.navigationController pushViewController:[[HuGeUserMyMessageVC alloc] init] animated:YES];
                
            }
                
        }
    }
}

- (void)showAlertClearn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"已经清除缓存." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// 计算目录大小
- (CGFloat)em_folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
- (NSString *)em_getCachesPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

@end
