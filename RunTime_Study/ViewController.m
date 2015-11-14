//
//  ViewController.m
//  RunTime_Study
//
//  Created by jamalping on 15/11/13.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    unsigned int count;
    // 获取属性列表
    objc_property_t *propertList = class_copyPropertyList(NSClassFromString(@"TestViewController"), &count);
    for (int i = 0;i < count; i++) {
        const char *propertyName = property_getName(propertList[i]);
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        NSLog(@"%@-%s",propertyString,propertyName);
    }
    NSLog(@"\n\n\n\n");
///-----------------------------------------------------------------------------
    // 获取方法列表
    Method * methodList = class_copyMethodList(NSClassFromString(@"TestViewController"), &count);
    for (int i = 0;i < count; i++) {
        NSLog(@"%@",NSStringFromSelector(method_getName(methodList[i])));
    }
    NSLog(@"\n\n\n\n");
///-----------------------------------------------------------------------------
    // 获取成员列表
    Ivar *ivarList = class_copyIvarList(NSClassFromString(@"TestViewController"), &count);
    for (int i = 0;i < count; i++) {
        NSLog(@"%s",ivar_getName(ivarList[i]));
    }
    NSLog(@"\n\n\n\n");
    
///-----------------------------------------------------------------------------
    // 获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(NSClassFromString(@"TestViewController"), &count);
    for (int i = 0;i < count; i++) {
        NSLog(@"%@",NSStringFromProtocol(protocolList[i]));
    }
    
///-------------------------------------方法的调用----------------------------------------
    [self performSelector:@selector(resolveAdd:) withObject:@"test"];
    
    [self performSelector:@selector(ttttttttt:) withObject:@"ttttt"];
    
    [self tianJiaGuanLianDuiXiang];
}


// 当调用实例方法的时候，会调用这个方法默认返回NO
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"ttttttttt:"]) {
        
//        return class_addMethod(self, sel, class_getMethodImplementation(self, @selector(test:)), "v@:*");
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:*");
    }
    return YES;
}

// 返回实现了该方法的类对应的实例变量
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"%@",NSStringFromSelector(aSelector));
    return [[NSClassFromString(@"TestViewController") alloc] init];
}


- (void)test:(NSString *)string {
    NSLog(@"test %@",string);
}

void runAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"add C IMP %@", string);
}

///-------------------------------------关联对象----------------------------------------
static char associatedObjectKey;//首先定义一个全局变量，用它的地址作为关联对象的key
- (void)tianJiaGuanLianDuiXiang {
    objc_setAssociatedObject(self, &associatedObjectKey, @"添加的字符串属性", OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSLog(@"AssociatedObject = %@", objc_getAssociatedObject(self, &associatedObjectKey));
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
