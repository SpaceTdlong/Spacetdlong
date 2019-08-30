//
//  HuGeOpenBlackListVC.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackListVC.h"

@interface HuGeOpenBlackListVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation HuGeOpenBlackListVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self em_refreshData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewController];
    [self addSubViews];
    [self em_refreshData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布约玩" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
}
-(void)rightBarButtonClick{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefault objectForKey:@"token"];
    if (!token) {
        [self.navigationController pushViewController:[[HuGeUserLoginViewController alloc] init] animated:YES];
    }else{
        [self.navigationController pushViewController:[[HuGeOpenBlackCreateRoomVC alloc] init] animated:YES];
    }
}
#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    self.view.backgroundColor = [UIColor appBackgroundColor];
    self.navigationItem.title = @"约玩";
}

- (void)addSubViews {
    [self.view addSubview:self.collectionView];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)em_refreshData {
    self.page = 1;
    if (self.dataArray.count == 0) {
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    [self em_laodData];
}
#pragma mark - Custom Methods
- (void)em_addLoadMoreData {
    if (self.collectionView.mj_footer) {
        [self.collectionView.mj_footer resetNoMoreData];
    } else {
        @weakify(self);
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self em_laodData];
        }];
    }
}
- (void)em_laodData{
    @weakify(self);
    [self.collectionView ly_startLoading];
    [HuGeOpenBlackManager huGe_dataOpenBlackListWithPage:1 success:^(NSArray<HuGeOpenBlackRoomModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.collectionView ly_endLoading];
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            if (isLoadEnd) {
                [self em_addLoadMoreData];
            }
        }
        if (list.count > 0) {
            [self.dataArray addObjectsFromArray:list];
        }
        if (isLoadEnd) {
            [self.collectionView.mj_footer endRefreshing];
            //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.collectionView ly_endLoading];
        [self.collectionView.mj_header endRefreshing];
        kFixCodePosition6
    }];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    size = CGSizeMake(SCREEN_WIDTH, 212);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 0);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HuGeOpenBlackListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HuGeOpenBlackListCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HuGeOpenBlackRoomModel * model = self.dataArray[indexPath.item];
    HuGeOpenBlackDetailVC * vc = [[HuGeOpenBlackDetailVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy Loading
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeOpenBlackListCell class]) bundle:ESBundle] forCellWithReuseIdentifier:NSStringFromClass([HuGeOpenBlackListCell class])];
        @weakify(self);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self em_refreshData];
        }];
        _collectionView.ly_emptyView = [LYEmptyView emptyViewWithImage:ESImage(@"sp_page_null") titleStr:@"这里空空如也~" detailStr:nil];
        _collectionView.ly_emptyView.autoShowEmptyView = NO;
        if (!_collectionView) {
            kFixCodePosition2
        }
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
