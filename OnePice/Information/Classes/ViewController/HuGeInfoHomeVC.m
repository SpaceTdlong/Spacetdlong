//
//  HuGeInfoHomeVC.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoHomeVC.h"
#import "HuGeInfoHomeVCHomeCell.h"
#import "HuGeDJMWKViewController.h"

@interface HuGeInfoHomeVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HuGeInfoHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self addSubViews];
    [self em_refreshData];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"战队" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
}
-(void)rightBarButtonClick{
    HuGeDJMWKViewController * teamVC = [[HuGeDJMWKViewController alloc] init];
    teamVC.url = ESZhanDuiDataUrl;
    [self.navigationController pushViewController:teamVC animated:YES];
}
#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    if (!self.title) {
        self.title = @"热点";
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

- (void)em_refreshData {
    self.page = 1;
    if (self.dataArray.count == 0) {
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    [self em_loadData];
}

- (void)em_loadData {
    @weakify(self);
    [self.tableView ly_startLoading];
    [HuGeInfoHomeManager huGe_dataListWithPage:self.page type:@"1" success:^(NSArray<HuGeInfoHomeModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
                @strongify(self);
                [SVProgressHUD dismiss];
                [self.tableView ly_endLoading];
                if (self.page == 1) {
                    [self.dataArray removeAllObjects];
                    if (isLoadEnd) {
                        [self em_addTableViewLoadMoreData];
                    }
                }
                if (list.count > 0) {
                    self.page++;
                    [self.dataArray addObjectsFromArray:list];
                }
        if (isLoadEnd) {
            [self.tableView.mj_footer endRefreshing];
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

                [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                [self.tableView ly_endLoading];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                kFixCodePosition7
    }];
}

#pragma mark - Custom Methods
- (void)em_addTableViewLoadMoreData {
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer resetNoMoreData];
    } else {
        @weakify(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self em_loadData];
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuGeInfoHomeVCHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HuGeInfoHomeVCHomeCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HuGeInfoHomeModel * model = self.dataArray[indexPath.row];
    HuGeInfoHomeVCDetail * vc = [[HuGeInfoHomeVCDetail alloc] init];
    vc.url = [NSURL URLWithString:model.url];
//    https://m.huya.com
    vc.content = model.text;
    vc.titleStr = @"资讯详情";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 134;
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
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.separatorStyle = UITableViewCellAccessoryDisclosureIndicator;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeInfoHomeVCHomeCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeInfoHomeVCHomeCell class])];
        
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self em_refreshData];
        }];
        [self em_addTableViewLoadMoreData];
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