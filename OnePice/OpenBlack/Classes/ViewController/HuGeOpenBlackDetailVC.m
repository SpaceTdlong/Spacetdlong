//
//  HuGeOpenBlackDetailVC.m
//  HuGeDJ
//
//  Created by edz on 2019/8/29.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackDetailVC.h"

@interface HuGeOpenBlackDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;


@end

@implementation HuGeOpenBlackDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self addSubViews];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
}
-(void)rightBarButtonClick{
    [self.navigationController pushViewController:[[HuGeCommunityHomeVC alloc] init] animated:YES];
}

#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    if (!self.title) {
        self.title = @"房间详情";
    }
    self.view.backgroundColor = [UIColor appBackgroundColor];
}

- (void)addSubViews {
    [self.view addSubview:self.tableView];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HuGeOpenBlackHomeOwnersCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeOpenBlackHomeOwnersCell class])];
        cell.model = self.model.joinlist[0];
        [cell.shieldBtn addTarget:self action:@selector(shieldBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        HuGeOpenBlackRoomDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeOpenBlackRoomDetailCell class])];
        cell.model = self.model;
        return cell;
    }
    
}
-(void)shieldBtnClick{
    HuGeOpenBlackUserModel * userModel = self.model.joinlist[0];
    [HuGeCommentManager huGe_shieldWithID:[NSString stringWithFormat:@"%ld",userModel.u_id] success:^(BOOL logState) {
        if (logState == YES) {
            [SVProgressHUD showSuccessWithStatus:@"拉黑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.domain];
    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 116;
    }
    return 402;
}
#pragma mark - Lazzy Loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeOpenBlackRoomDetailCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeOpenBlackRoomDetailCell class])];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeOpenBlackHomeOwnersCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeOpenBlackHomeOwnersCell class])];
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImage:ESImage(@"jz_edsi_empty") titleStr:@"这里空空如也~" detailStr:nil];
        _tableView.ly_emptyView.autoShowEmptyView = NO;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


@end
