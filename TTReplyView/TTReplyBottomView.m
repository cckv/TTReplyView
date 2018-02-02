//
//  TTReplyBottomView.m
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import "TTReplyBottomView.h"
#import "YYKit.h"

@interface TTReplyBottomView()
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) YYTextView *textView;
@property(nonatomic,strong) UIButton *sendBtn;
@end
@implementation TTReplyBottomView


-(instancetype)init
{
    if (self = [super init]) {
        [self setUpViews];
    }
    return self;
}
- (void)setUpViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor grayColor];
    
    YYTextView *textView = [[YYTextView alloc] init];
    self.textView = textView;
    textView.userInteractionEnabled = NO;
    textView.textAlignment = NSTextAlignmentLeft;
    textView.text = @"我要评论";
    [self addSubview:textView];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn = sendBtn;
    [self addSubview:sendBtn];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, 0, self.width, 0.5);
    self.textView.frame = CGRectMake(15, 2, self.width - 100, self.height - 4);
    self.sendBtn.frame = CGRectMake(self.textView.right +5, 2, 60, self.height-4);
}
- (void)send:(UIButton*)btn
{
    if([self.myDelegate respondsToSelector:@selector(sendData:)])
    {
        [self.myDelegate sendData:self.textView.text];
    }
}
@end
