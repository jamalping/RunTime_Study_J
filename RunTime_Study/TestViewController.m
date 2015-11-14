//
//  TestViewController.m
//  RunTime_Study
//
//  Created by jamalping on 15/11/13.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    NSString *test;
}
@end

@implementation TestViewController
{
    NSString *_tt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resolveAdd:(NSString *)string {
    NSLog(@"resolveAdd %@",string);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
