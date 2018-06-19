//
//  ViewController.m
//  PasswordInputbox
//
//  Created by 黄坤 on 2018/6/19.
//  Copyright © 2018年 jinchenshenghui. All rights reserved.
//

#import "ViewController.h"
#import "SWPasswordView.h"
@interface ViewController ()<SWPasswordViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWPasswordView *pwdinputbox = [[SWPasswordView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 60, 50)];
    pwdinputbox.center = self.view.center;
    pwdinputbox.delegate = self;
    [self.view addSubview:pwdinputbox];
}

- (void)inputDoneWithReslutText:(NSString *)text{
    NSLog(@"输入的字符是：%@",text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
