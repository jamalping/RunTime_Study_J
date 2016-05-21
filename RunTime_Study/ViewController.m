//
//  ViewController.m
//  RunTime_Study
//
//  Created by jamalping on 15/11/13.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import "ViewController.h"
#import "Father.h"
#import "Son.h"
#import <objc/runtime.h>
#import "TestViewController.h"
@import ObjectiveC.message;

@interface ViewController ()

- (void)fun:(NSString *)str1 str2:(NSString *)str2;
@property (nonatomic,copy)void(^MyBlock)(NSString *sr1); /** block*/

@end
@implementation ViewController
//@dynamic MyBlock;
- (IBAction)click:(id)sender {
    NSLog(@"click");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Father *father = [Father new];
    Son *son = [Son new];
    [son test];
    
    self.MyBlock = ^(NSString *str1){
        NSLog(@"我是block的%@",str1);
    };

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
        NSLog(@"protocol List%@",NSStringFromProtocol(protocolList[i]));
    }
    
///-------------------------------------方法的调用----------------------------------------
    [self performSelector:@selector(resolveAdd:) withObject:@"test"];
    
    NSString *result = [self performSelector:@selector(ttttttttt:) withObject:@"ttttt" withObject:@"dd"];
    NSLog(@"result:%@",result);
    [self tianJiaGuanLianDuiXiang];
    
///-------------------------------------添加方法的实现----------------------------------------
    IMP imp = imp_implementationWithBlock(^(id self,NSString *string,NSString *str2) {
//        NSLog(@"我是方法的实现%@,%@,%@",self,string,str2);
        if ([self isKindOfClass:[ViewController class]]) {
            ViewController *vc = (ViewController *)self;
            if (vc.MyBlock) {
                vc.MyBlock(string);
            }
        }
    });
    
    class_addMethod(self.class, @selector(fun:str2:), imp, "@:@");
    [self fun:@"s1" str2:@"s2"];
///-------------------------------------交换方法的实现----------------------------------------
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(test:)), class_getInstanceMethod(NSClassFromString(@"TestViewController"), @selector(resolveAdd:)));
    [self test:@"我调用的是test1"];
}


// 当调用实例方法的时候，会调用这个方法默认返回NO
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"ttttttttt:"]) {
        
//        return class_addMethod(self, sel, class_getMethodImplementation(self, @selector(test:)), "v@:*");
        class_addMethod(self, sel, (IMP)runAddMethod, " "); // v 表示Void，@ 表示self，：表示_cmd,* 表示参数
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

- (void)test1:(NSString *)string {
    NSLog(@"test1 %@",string);
}

NSString *runAddMethod(id self, SEL _cmd, NSString *string,NSString *dd){
    NSLog(@"add C IMP%@ %@..%@",self, string,dd);
    return @"d";
}

///-------------------------------------关联对象----------------------------------------
static char associatedObjectKey;//首先定义一个全局变量，用它的地址作为关联对象的key
- (void)tianJiaGuanLianDuiXiang {
    objc_setAssociatedObject(self, &associatedObjectKey, self.MyBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)getGuanlianduixiang {
    NSLog(@"AssociatedObject = %@", objc_getAssociatedObject(self, &associatedObjectKey));
    return objc_getAssociatedObject(self, &associatedObjectKey);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
