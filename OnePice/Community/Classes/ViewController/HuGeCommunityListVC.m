//
//  HuGeCommunityListVC.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityListVC.h"

@interface HuGeCommunityListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;


@end

@implementation HuGeCommunityListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self addSubViews];
    [self em_refreshData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
}
-(void)rightBarButtonClick{
    [self.navigationController pushViewController:[[HuGeCommunityHomeVC alloc] init] animated:YES];
}

#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    if (!self.title) {
        self.title = @"论坛";
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
    [HuGeCommunityManager huGe_dataCommunityListWithPage:self.page success:^(NSArray<HuGeInfoHomeModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView ly_endLoading];
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
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
    HuGeCommunityListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeCommunityListCell class])];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HuGeCommunityModel * model = self.dataArray[indexPath.row];
    HuGeCommunityDetailVC * vc = [[HuGeCommunityDetailVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuGeCommunityModel * model = self.dataArray[indexPath.row];
    if (model.image.length > 0) {
        return 290;
    }
    return 130;
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeCommunityListCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeCommunityListCell class])];
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
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
