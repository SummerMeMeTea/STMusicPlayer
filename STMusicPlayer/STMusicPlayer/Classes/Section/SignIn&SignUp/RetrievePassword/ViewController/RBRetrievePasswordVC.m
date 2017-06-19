//
//  RBRetrievePasswordVC.m
//  Master
//
//  Created by Lan on 2017/6/2.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import "RBRetrievePasswordVC.h"
#import "RBTimerButton.h"
#import "RBTextView.h"
#import "RBThemeConfig.h"
#import "MBProgressHUD.h"
#import "UIImage+RBAdd.h"
#import "Masonry.h"

@interface RBRetrievePasswordVC ()

@property(nonatomic, weak) UITextField *accountTextField;
@property(nonatomic, weak) UITextField *passwordTextField;
@property(nonatomic, weak) UITextField *verifyCodeTextField;

@end

@implementation RBRetrievePasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //demo
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat leftWidth = 66;
    CGFloat padding = 22;
    CGFloat height = 50;
    
    RBTextView *accountTextView = ({
        RBTextView *view = [RBTextView textViewWithLeftWidth:leftWidth padding:15 image:[UIImage rbImageWithColor:[UIColor blueColor]] title:nil placeHolder:@"填写手机号"];
        [self.view addSubview:view];
        self.accountTextField = view.textField;
        view;
    });
    [accountTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(66);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(height);
    }];
    
    RBTextView *passwordTextView = ({
        RBTextView *view = [RBTextView textViewWithLeftWidth:leftWidth padding:15 image:[UIImage rbImageWithColor:[UIColor blueColor]] title:nil placeHolder:@"填写密码"];
        [self.view addSubview:view];
        self.passwordTextField = view.textField;
        view;
    });
    [passwordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountTextView.mas_bottom).offset(padding/2);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(height);
    }];
    
    RBTimerButton *timerButton = ({
        RBTimerButton *btn = [RBTimerButton new];
        [btn addTarget:self action:@selector(timerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if ([btn hasReachedMaxTimeInterval])
        {
            btn.settingBlock(btn.maxTimeInterval + 1);
        }
        else
        {
            [btn startTimer];
        }
        btn;
    });
    [timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordTextView.mas_bottom).offset(padding/2);
        make.right.mas_equalTo(passwordTextView.mas_right);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(120);
    }];
    
    UITextField *verifyCodeTextField = ({
        UITextField *textField = [UITextField new];
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = @"填写验证码";
        [self.view addSubview:textField];
        self.verifyCodeTextField = textField;
        textField;
    });
    [verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordTextView.mas_bottom).offset(padding/2);
        make.height.mas_equalTo(height);
        make.right.mas_equalTo(timerButton.mas_left);
        make.left.mas_equalTo(passwordTextView);
    }];
    
    UIButton *signUpBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(signUpBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verifyCodeTextField.mas_bottom).offset(padding/2);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(height);
    }];

}


#pragma mark - Event

- (void)timerButtonTapped: (RBTimerButton *)btn
{
    [btn startTimer];
}

- (void)signUpBtnTapped: (id)sender
{
    [self.view endEditing:YES];
    if (self.accountTextField.text.length && self.passwordTextField.text.length && self.verifyCodeTextField.text.length)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
