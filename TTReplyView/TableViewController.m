//
//  TableViewController.m
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import "TableViewController.h"
#import "YYKit.h"
#import "TTReplyView.h"

@interface TableViewController ()<TTReplyViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *bgView;

@property(nonatomic,strong) TTReplyView *replyView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.dataArray addObject:@"这是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题是你要回答的问题"];
    [self.dataArray addObject:@"回答的问题1"];
    [self.dataArray addObject:@"回答的问题2"];
    [self.dataArray addObject:@"回答的问题3"];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TTReplyView *replyView = [[TTReplyView alloc]initWith:self.dataArray[indexPath.row] andData:self.dataArray];
    self.replyView = replyView;
    // 添加边缘手势
    UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(dissMissSelf:)];
    ges.edges = UIRectEdgeLeft;
    // 换成侧滑手势
    //    UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dissMissSelf:)];
    // 指定左边缘滑动
    [replyView addGestureRecognizer:ges];
    
//    replyView.inputView = self.inputView;
    
    replyView.delegate = self;
    [self.navigationController.view addSubview:replyView];
    replyView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-10);
    [UIView animateWithDuration:0.25 animations:^{
        replyView.top = 20;
    }];

}

#pragma mark -
- (void)dissMissSelf:(UIScreenEdgePanGestureRecognizer *)ges {
    // 让view跟着手指去移动
    // frame的x应该为多少??应该获取到手指的x值
    // 取到手势在当前控制器视图中识别的位置
    CGPoint p = [ges locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(p));
    
    //    UIGestureRecognizerStateBegan
    //    UIGestureRecognizerStateChanged
    //    UIGestureRecognizerStateEnded
    if (ges.state == UIGestureRecognizerStateEnded) {
        if (self.replyView.left > ([UIScreen mainScreen].bounds.size.width/3)) {
            [UIView animateWithDuration:0.1 animations:^{
                self.replyView.left = [UIScreen mainScreen].bounds.size.width;
            } completion:^(BOOL finished) {
                [self.replyView removeFromSuperview];
                self.replyView = nil;
                [self.bgView removeFromSuperview];
                self.bgView = nil;
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                self.replyView.left = 0;
            }];
        }
    }else{
        self.replyView.left = p.x;
    }
    
}
-(void)hideInputView
{
    [self.view endEditing:YES];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.inputView.top = [UIScreen mainScreen].bounds.size.height;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self.inputView removeFromSuperview];
        
        [self.bgView removeFromSuperview];
        self.bgView = nil;

    }];
    
}

-(void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.replyView.top = [UIScreen mainScreen].bounds.size.height;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self.replyView removeFromSuperview];
        self.replyView = nil;
        
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
    
}

#pragma mark - lazy
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _bgView.backgroundColor = [UIColor grayColor];
        _bgView.alpha = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideInputView)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
@end
