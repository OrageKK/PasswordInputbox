# PasswordInputbox
[![tcCVU.md.png](https://storage7.cuntuku.com/2018/06/20/tcCVU.md.png)](https://cuntuku.com/image/tcCVU)

类似微信和支付宝密码输入框

### 使用

```objective-c
SWPasswordView *pwdinputbox = [[SWPasswordView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 60, 50)];
    pwdinputbox.center = self.view.center;
    pwdinputbox.delegate = self;
    [self.view addSubview:pwdinputbox];
```

遵循代理 **SWPasswordViewDelegate ** 并实现方法，输入完毕回调输入字符

```objc
- (void)inputDoneWithReslutText:(NSString *)text{
    NSLog(@"输入的字符是：%@",text);
}
```

