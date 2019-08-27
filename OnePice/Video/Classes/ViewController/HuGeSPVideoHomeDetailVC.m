//
//  HuGeSPVideoHomeDetailVC.m
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoHomeDetailVC.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "ZFUtilities.h"


@interface HuGeSPVideoHomeDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *data2Array;
@property (nonatomic, strong) HuGeSPVideoDetailView *detailView;
@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation HuGeSPVideoHomeDetailVC

- (instancetype)initWithVideoId:(NSInteger)viderId {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor appBackgroundColor];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20+iPhoneXYOffset);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    //添加评论底部View
    HuGePLCommentFooterView * footView = [[[NSBundle mainBundle] loadNibNamed:@"HuGePLCommentFooterView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。;
    @weakify(self);
    [self.tableView ly_startLoading];
    NSString * ID = [NSString stringWithFormat:@"%ld",self.video.videoID];
    
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
    
    [self em_initPlayer];
    [self em_laodData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)em_initPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
    };
    
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        NSLog(@"======开始播放了");
        @strongify(self);
        self.isPlaying = YES;
    };
    
    self.assetURLs = @[[NSURL URLWithString:self.video.link]];
    self.player.assetURLs = self.assetURLs;
    [self playClick:nil];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 20+iPhoneXYOffset;  //CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
}

- (void)em_laodData{
    @weakify(self);
    [self.tableView ly_startLoading];
    
    NSString * ID = [NSString stringWithFormat:@"%ld",self.video.videoID];
    [HuGeCommentManager huGe_dataCommonsListWithID:ID type:@"1" success:^(NSArray<HuGeCommentModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView ly_endLoading];
        [self.data2Array removeAllObjects];
        
        if (list.count > 0) {
            [self.data2Array addObjectsFromArray:list];
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
    
    [HuGeSPVideoManager huGe_dataVideoListWithPage:1 isrand:1 success:^(NSArray<HuGeSPVideoHomeModel *> * _Nonnull list, BOOL isLoadEnd, NSInteger total) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView ly_endLoading];
        [self.dataArray removeAllObjects];
        if (list.count > 0) {
            [self.dataArray addObjectsFromArray:list];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView ly_endLoading];
        [self.tableView.mj_header endRefreshing];
        kFixCodePosition6
    }];

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return self.data2Array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HuGeSPVideoRecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeSPVideoRecommendedCell class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
    HuGePLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGePLCommentCell class])];
    cell.model = self.data2Array[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(12, 12, 100, 14);
    titleLabel.textColor = [UIColor colorWithRGB:0x101010];
    titleLabel.font = [UIFont systemFontOfSize:13];
    if (section == 0) {
        titleLabel.text = @"相关视频";
    }else{
        titleLabel.text = @"热门评论";
    }
    [view addSubview:titleLabel];
    return view;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HuGeSPVideoHomeDetailVC * vc = [[HuGeSPVideoHomeDetailVC alloc] init];
        vc.video = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 111;
    }
    return 121;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}


#pragma mark - Actions
- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
}

- (void)backClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark - Lazy Loading
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.portraitControlView.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        _containerView.image = ESImage(@"sp_player_background");
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:ESImage(@"sp_index_btn_play") forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:ESImage(@"sp_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeSPVideoRecommendedCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeSPVideoRecommendedCell class])];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGePLCommentCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGePLCommentCell class])];
        
//        [_tableView registerClass:[HuGeSQVideoLDetailHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([HuGeSQVideoLDetailHeaderView class])];
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 12, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            kFixCodePosition7
        }
#endif
        
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImage:ESImage(@"sp_page_null") titleStr:@"这里空空如也~" detailStr:nil];
        [_tableView ly_hideEmptyView];
//        _tableView.tableHeaderView = self.detailView;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)data2Array {
    if (!_data2Array) {
        _data2Array = [[NSMutableArray alloc] init];
    }
    return _data2Array;
}

- (HuGeSPVideoDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[HuGeSPVideoDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _detailView;
}


@end
