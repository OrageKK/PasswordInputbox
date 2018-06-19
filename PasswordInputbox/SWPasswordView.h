//
//  SYPasswordView.h
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 Oragekk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SWPasswordViewDelegate<NSObject>
@optional
- (void)inputDoneWithReslutText:(NSString *)text;
@end
@interface SWPasswordView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,weak) id<SWPasswordViewDelegate> delegate;
/**
 *  清除密码
 */
- (void)clearUpPassword;

@end
