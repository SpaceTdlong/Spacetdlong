//
//  HuGeCommunityDetailVC.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityDetailVC.h"

@interface HuGeCommunityDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HuGeCommunityDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self addSubViews];
    //添加评论底部View
    HuGePLCommentFooterView * footView = [[[NSBundle mainBundle] loadNibNamed:@"HuGePLCommentFooterView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。;
    @weakify(self);
    [self.tableView ly_startLoading];
    NSString * ID = [NSString stringWithFormat:@"%ld",self.model.commID];
    
    footView.sendCommentBlock = ^(NSString * _Nonnull commentContent) {
        
        [HuGeCommentManager huGe_dataPostCommentWithid:ID type:@"3" content:commentContent success:^(BOOL logState) {
            @strongify(self);
            if (logState == YES) {
                [footView reset];
                [self.view endEditing:YES];
            }
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
        self.title = @"论坛详情";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.model.commentlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HuGeCommunityListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGeCommunityListCell class])];
        cell.model = self.model;
        return cell;
    }
    HuGePLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuGePLCommentCell class])];
    cell.model = self.model.commentlist[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(12, 12, 100, 14);
    titleLabel.textColor = [UIColor colorWithRGB:0x101010];
    titleLabel.font = [UIFont systemFontOfSize:13];
    if (section == 0) {
        titleLabel.text = @"论坛详情";
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
        if (self.model.image.length > 0) {
            return 290;
        }
        return 130;
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGeCommunityListCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGeCommunityListCell class])];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HuGePLCommentCell class]) bundle:ESBundle] forCellReuseIdentifier:NSStringFromClass([HuGePLCommentCell class])];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.separatorColor = [UIColor colorWithRGB:0xE8E8E8];
        _tableView.separatorStyle = UITableViewCellAccessoryDisclosureIndicator;
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
