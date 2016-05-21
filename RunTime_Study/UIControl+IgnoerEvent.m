//
//  UIControl+IgnoerEvent.m
//  RunTime_Study
//
//  Created by jamalping on 15/11/15.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import "UIControl+IgnoerEvent.h"

@implementation UIControl (IgnoerEvent)
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_uxy_ignoreEvent = "UIControl_uxy_ignoreEvent";
- (id)init {
    self = [super init];
    if (self) {
        self.uxy_acceptEventInterval = 2;
        [UIControl load];
    }
    return self;
}


- (NSTimeInterval)uxy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval)doubleValue];
}
-(void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)uxy_ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_uxy_ignoreEvent) boolValue];
}
-(void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_uxy_ignoreEvent, @(uxy_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b =class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a,b);
    
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([self uxy_ignoreEvent]) return;
    if ([self uxy_acceptEventInterval] > 0)
    {
        self.uxy_ignoreEvent = YES;
        [self performSelector:@selector(setUxy_ignoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    [self __uxy_sendAction:action to:target forEvent:event];
}

@end
