//
//  SYPasswordView.m
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "SWPasswordView.h"

#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height self.frame.size.height  //每一个输入框的高度等于当前view的高度
@interface SWPasswordView ()

@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic,strong) NSMutableArray *bottomArray;
@end

@implementation SWPasswordView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initPwdTextField];
    }
    return self;
}

- (void)initPwdTextField
{
    [self addSubview:self.textField];
    //每个密码输入框的宽度
    CGFloat width = self.frame.size.height;
    CGFloat margin = (self.frame.size.width-width*kDotCount)/(kDotCount-1);
    self.bottomArray = [[NSMutableArray alloc] init];
    self.dotArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < kDotCount; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*(width+margin),0,width,K_Field_Height)];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.layer.cornerRadius = 2.0f;
        lineView.layer.borderColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
        lineView.layer.borderWidth = 1.f;
        [self addSubview:lineView];
        [self.bottomArray addObject:lineView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTextField)];
        [lineView addGestureRecognizer:tap];
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDotSize.width, kDotSize.height)];
        dotView.center = lineView.center;
        dotView.backgroundColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
    [self.textField becomeFirstResponder];
}
- (void)showTextField {
    [self.textField becomeFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (UIView *lineView in self.bottomArray) {
        lineView.layer.borderColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
        ((UIView *)[self.bottomArray objectAtIndex:i]).layer.borderColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1].CGColor;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
        [textField resignFirstResponder];
        if ([self.delegate respondsToSelector:@selector(inputDoneWithReslutText:)]) {
            [self.delegate inputDoneWithReslutText:self.textField.text];
        }
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, K_Field_Height)];
        _textField.backgroundColor = [UIColor clearColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor whiteColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
