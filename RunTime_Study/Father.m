//
//  Father.m
//  RunTime_Study
//
//  Created by jamalping on 16/5/17.
//  Copyright © 2016年 cisc. All rights reserved.
//

#import "Father.h"

@implementation Father
- (void)test {
    NSLog(@"Father self class %@",self.tt);
//    NSLog(@"Father super class %@",[super tt]);
}

- (Class)tt {
    return super.class;
}
@end
