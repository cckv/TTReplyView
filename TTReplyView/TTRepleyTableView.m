//
//  TTRepleyTableView.m
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import "TTRepleyTableView.h"

@implementation TTRepleyTableView


/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//右边侧滑：
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
