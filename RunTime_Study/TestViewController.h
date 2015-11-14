//
//  TestViewController.h
//  RunTime_Study
//
//  Created by jamalping on 15/11/13.
//  Copyright © 2015年 cisc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestProtocol <NSObject>

- (void)ttt;

@end

@interface TestViewController : UIViewController <TestProtocol>

@property (nonatomic,strong)NSArray *datas; /**< data */
@property (nonatomic,strong)NSDictionary *dic; /**< data */
@property (nonatomic,strong)NSData *data; /**< data */
@property (nonatomic,copy)NSString *str; /**< data */

- (void)resolveAdd:(NSString *)string;

@end
