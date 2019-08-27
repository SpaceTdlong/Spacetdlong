//
//  HuGeEventHomeDetailVC.m
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeEventHomeDetailVC.h"

@interface HuGeEventHomeDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HuGeEventHomeDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self addSubViews];
    [self em_refreshData];
    //添加评论底部View
    HuGePLCommentFooterView * footView = [[[NSBundle mainBundle] loadNibNamed:@"HuGePLCommentFooterView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。;
    @weakify(self);
    [self.tableView ly_startLoading];
    NSString * ID = [NSString stringWithFormat:@"%ld",self.model.eventID];
    
    footView.sendCommentBlock = ^(NSString * _Nonnull commentContent) {
        
        [HuGeCommentManager huGe_dataPostCommentWithid:ID type:@"2" content:commentContent success:^(BOOL logState) {
            @strongify(self);
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    };
    [self.view addSubview:footView];
    [footView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-20);
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.offset(50);
    }];
}

#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    if (!self.title) {
        self.title = @"赛事详情";
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
    if (self.dataArray.count == 0) {
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    [self em_loadData];
}

- (void)em_loadData {
    @weakify(self);
    [self.tableView ly_startLoading];
    NSString * ID = [NSString stringWithFormat:@"%ld",self.model.eventID];
    [HuGeCommentManager huGe_dataCommonsListWithID:ID type:@"2" success:^(NSArray<HuGeCommentModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView ly_endLoading];
        [self.dataArray removeAllObjects];

        if (list.count > 0) {
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HuGeEventTwoTypeHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeEventTwoTypeHomeCell class])];
        cell.model = self.model;
        return cell;
    }
    HuGePLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGePLCommentCell class])];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(12, 12, 100, 14);
    titleLabel.textColor = [UIColor colorWithRGB:0x101010];
    titleLabel.font = [UIFont systemFontOfSize:13];
    if (section == 0) {
        titleLabel.text = @"赛事详情";
    }else{
        titleLabel.text = @"相关评论";
    }
    
    [view addSubview:titleLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 111;
    }
    
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeEventTwoTypeHomeCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeEventTwoTypeHomeCell class])];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGePLCommentCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGePLCommentCell class])];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.separatorStyle = UITableViewCellAccessoryDisclosureIndicator;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
