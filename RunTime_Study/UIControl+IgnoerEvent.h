//
//  UIControl+IgnoerEvent.h
//  RunTime_Study
//
//  Created by jamalping on 15/11/15.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIControl (IgnoerEvent)
@property (nonatomic, assign) NSTimeInterval uxy_acceptEventInterval;  // 可以用这个给重复点击加间隔
@property (nonatomic, assign) BOOL uxy_ignoreEvent;  // 是否忽略点击事件
@end
