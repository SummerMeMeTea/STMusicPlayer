//
//  RBSignInVC.m
//  Master
//
//  Created by Lan on 2017/6/1.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import "RBSignInVC.h"
#import "Masonry.h"
#import "RBThemeConfig.h"
#import "RBTextView.h"
#import "UIImage+RBAdd.h"
#import "RBSignInManager.h"
#import "RBSignUpVC.h"
#import "RBRetrievePasswordVC.h"

@interface RBSignInVC ()

@property(nonatomic, weak) UITextField *accountTextField;
@property(nonatomic, weak) UITextField *passwordTextField;

@end

@implementation RBSignInVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //demo
    self.view.backgroundColor = [UIColor lightGrayColor];

    CGFloat leftWidth = 66;
    CGFloat padding = 22;
    CGFloat height = 50;
    
    RBTextView *accountTextView = ({
        RBTextView *view = [RBTextView textViewWithLeftWidth:leftWidth padding:15 image:[UIImage rbImageWithColor:[UIColor redColor]] title:nil placeHolder:@"填写账号"];
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
        RBTextView *view = [RBTextView textViewWithLeftWidth:leftWidth padding:15 image:[UIImage rbImageWithColor:[UIColor redColor]] title:nil placeHolder:@"填写密码"];
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
    
    UIButton *signInBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(signInBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordTextView.mas_bottom).offset(padding/2);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(height);
    }];
    
    UIButton *signUpBtn = ({
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(signUpBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signInBtn.mas_bottom).offset(padding/2);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(signInBtn.mas_left);
    }];
    
    UIButton *retrieveBtn = ({
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(retrieveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    [retrieveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signInBtn.mas_bottom).offset(padding/2);
        make.height.mas_equalTo(height);
        make.right.mas_equalTo(signInBtn.mas_right);
    }];
    
    //bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage rbImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage rbImageWithColor:[UIColor clearColor]];
    //text
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnTapped:)];
    UIBarButtonItem *item = self.navigationItem.leftBarButtonItem;
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [RBThemeConfig navigationItemFont]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [RBThemeConfig navigationItemFont]} forState:UIControlStateHighlighted];
}

#pragma mark - Event

- (void)cancelBtnTapped: (id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)signInBtnTapped: (id)sender
{
    [self.view endEditing:YES];
    if (self.accountTextField.text.length && self.passwordTextField.text.length)
    {
        [RBSignInManager manager].accountAvailable = YES;
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)signUpBtnTapped: (id)sender
{
    [self.view endEditing:YES];
    [self.navigationController pushViewController:[RBSignUpVC new] animated:YES];
}

- (void)retrieveBtnTapped: (id)sender
{
    [self.view endEditing:YES];
    [self.navigationController pushViewController:[RBRetrievePasswordVC new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
