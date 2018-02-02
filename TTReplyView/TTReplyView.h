//
//  TTReplyView.h
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTRepleyTableView;

@protocol TTReplyViewDelegate <NSObject>

@optional

- (void)TTReplyViewClick:(UITableViewCell*)cell;
- (void)hideView;

@end

@interface TTReplyView : UIView

@property (nonatomic, weak) id<TTReplyViewDelegate> delegate;
-(instancetype)initWith:(NSString *)firstData andData:(NSMutableArray *)data;

@property (nonatomic, strong) UIViewController *mySuperVc;

@property (nonatomic, strong) TTRepleyTableView *tableView; ///< <#name#>

@end
