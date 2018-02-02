//
//  TTReplyBottomView.h
//  TTReplyView
//
//  Created by cckv on 2018/2/2.
//  Copyright © 2018年 cckv. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTReplyBottomViewDelegate <NSObject>

@optional

- (void)sendData:(NSString*)data;

@end

@interface TTReplyBottomView : UIView

@property(nonatomic,weak) id<TTReplyBottomViewDelegate> myDelegate;
@end
