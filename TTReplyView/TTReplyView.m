//
//  TTReplyView.m
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import "TTReplyView.h"
#import "TTRepleyTableView.h"
#import "YYKit.h"
#import "MJRefresh.h"
#import "TTReplyBottomView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface TTReplyView()<UITableViewDelegate,UITableViewDataSource,TTReplyBottomViewDelegate>

@property (nonatomic, strong) UIButton *backBtn; ///< name
@property (nonatomic, strong) UILabel *titleLabel; ///< name
@property (nonatomic, strong) UIView *line; ///< name
@property (nonatomic, strong) UIView *line2; ///< name

@property (nonatomic, strong) TTReplyBottomView *bottomView;

@property(nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSString *firstDataDict;

@end

@implementation TTReplyView


-(instancetype)initWith:(NSString *)firstData andData:(NSMutableArray *)data
{
    if (self = [super init]) {
        self.firstDataDict = firstData;
        self.dataList = data;
        [self setUpViews];
    }
    return self;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self setUpViews];
    }
    return self;
}

- (void)getData
{
    // 获取数据
    
    [self.dataList addObjectsFromArray:@[@"343",@"23tg4rw3r43",@"uyhib3nhg4u",@"23tg4rw3r43",@"uyhib3nhg4u"]];
    
    typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    });
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backBtn.frame = CGRectMake(15, 14, 17, 17);
    self.titleLabel.top = 0;
    self.titleLabel.height = 44;
    self.titleLabel.width = self.width/2;
    self.titleLabel.left = self.width/4;
    self.line.frame = CGRectMake(0, 44, self.width, 0.5);
    self.tableView.frame = CGRectMake(0, 44, self.width, self.height - 94);
    self.line2.frame = CGRectMake(0, 88, self.width, 0.5);
    self.bottomView.frame = CGRectMake(0, self.height - 60, self.width, 50);

}

- (void)setUpViews
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    self.backgroundColor = [UIColor lightGrayColor];
        
    UIButton *backBtn = [[UIButton alloc] init];
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    [backBtn setTitle:@"X" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    titleLabel.text = @"hahha";
//    titleLabel.text = [NSString stringWithFormat:@"%d回复",[self.dataDict[@"sub_reply_num"]intValue]];
    //    titleLabel.text = @"回复";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    UIView *line = [[UIView alloc]init];
    self.line = line;
    [self addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
    
    UIView *line2 = [[UIView alloc]init];
    self.line2 = line2;
    [self addSubview:line2];
    line2.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
    
    [self addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
    
    self.bottomView = [[TTReplyBottomView alloc] init];
    self.bottomView.myDelegate = self;
    [self addSubview:self.bottomView];
    
}

-(void)sendData:(NSString *)data
{
    [self.dataList addObject:data];
    [self.tableView reloadData];
}

#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];

    //当前的point
    CGPoint currentP = [touch locationInView:self];

    //以前的point
    CGPoint preP = [touch previousLocationInView:self];

    //x轴偏移的量
    //    CGFloat offsetX = currentP.x - preP.x;

    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;

    if (self.top <20) {
        return;
    }

    self.transform = CGAffineTransformTranslate(self.transform, 0, offsetY);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    if (self.top > 100) {
        [self back];
    }else
    {
        self.top = 20;
    }
    self.tableView.userInteractionEnabled = YES;
}

#pragma mark - handle
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateEnded) {

    }else if (pan.state == UIGestureRecognizerStateChanged){
        
    }else if (pan.state == UIGestureRecognizerStateBegan){

        if (self.top > 100) {
            [self back];
        }
    }
}
- (void)back
{
    if ([self.delegate respondsToSelector:@selector(hideView)]) {
        [self.delegate hideView];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.dataList.count-1;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    cell.textLabel.numberOfLines = 0;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.dataList[indexPath.row];
    }else{
        cell.textLabel.text = self.dataList[indexPath.row+1];
    }
    return cell;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] init];
        [view addSubview:line];
        line.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
        line.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1];
        
        UILabel *replyL = [[UILabel alloc]init];
        [view addSubview:replyL];
        replyL.font = [UIFont systemFontOfSize:13];
        replyL.frame = CGRectMake(15, 0, 100, 44);
        replyL.textColor = [UIColor colorWithRed:(51/255.0) green:(51/255.0) blue:(51/255.0) alpha:1];
        replyL.text = (@"全部回复");
        
        UIView *line2 = [[UIView alloc] init];
        [view addSubview:line2];
        line2.frame = CGRectMake(0, 44, kScreenWidth, 0.5);
        line2.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1];
        
        return view;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }else{
        return 0.001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentStr;
    if (indexPath.section == 0) {
        contentStr = self.dataList[indexPath.row];
    }else{
        contentStr = self.dataList[indexPath.row+1];
    }
    NSMutableParagraphStyle *paraStyle2 = [[NSMutableParagraphStyle alloc] init];
    paraStyle2.lineSpacing = 2; //设置行间距
    NSDictionary *dic2 = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    CGFloat tempH = 0;
    
    tempH = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic2 context:nil].size.height;
    
    if (tempH <44) {
        return 44;
    }
    return tempH;
    
}


#pragma mark - UIScrollViewDelegatte
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollViewDidScroll");
    
    if (scrollView.contentOffset.y < 0) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
        scrollView.userInteractionEnabled = NO;
        
    }else{
        scrollView.userInteractionEnabled = YES;
    }

}
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"scrollViewWillEndDragging");
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
}

// 滑动减速时调用该方法。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDecelerating");
    // 该方法在scrollViewDidEndDragging方法之后。
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    scrollView.userInteractionEnabled = YES;
}

// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation");
    scrollView.userInteractionEnabled = YES;
}

#pragma mark - lazy
-(NSMutableArray *)dataList
{
    if(!_dataList){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
-(TTRepleyTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[TTRepleyTableView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end

