//
//  GCPopMenuViewController.m
//  GCPopMenuView_Example
//
//  Created by yons on 2020/8/24.
//  Copyright © 2020 guochaoliu. All rights reserved.
//

#import "GCPopMenuViewController.h"
#import <GCPopMenuView/GCPopMenuView.h>
#import <Masonry/Masonry.h>

#define Random_Color [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]
@interface GCPopMenuViewController ()
/// btn
@property (nonatomic, strong) UIButton *btn;
/// targetView
@property (nonatomic, strong) UIView *targetView;
/// <#注释#>
@property (nonatomic, strong) GCPopMenuConfig *config;
@end

@implementation GCPopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    [self.btn setTitle:@"moveBtn" forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor redColor]];
    [self.btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    self.targetView = [[UIView alloc] init];
    self.targetView.backgroundColor = [UIColor blueColor];
    self.targetView.hidden = YES;
    [self.view addSubview:self.targetView];
    [self.targetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    }];
    
    UIButton *targetBtn = [[UIButton alloc] init];
    [targetBtn setTitle:@"指定显示范围" forState:UIControlStateNormal];
    [targetBtn setBackgroundColor:[UIColor redColor]];
    [targetBtn addTarget:self action:@selector(targetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:targetBtn];
    [targetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
    }];
    [self.view bringSubviewToFront:self.btn];
    
    UIButton *upBtn = [[UIButton alloc] init];
    [upBtn setTitle:@"up" forState:UIControlStateNormal];
    [upBtn setBackgroundColor:Random_Color];
    [upBtn addTarget:self action:@selector(upBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upBtn];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"left" forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:Random_Color];
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"right" forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:Random_Color];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    UIButton *downBtn = [[UIButton alloc] init];
    [downBtn setTitle:@"down" forState:UIControlStateNormal];
    [downBtn setBackgroundColor:Random_Color];
    [downBtn addTarget:self action:@selector(downBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(targetBtn.mas_left);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(targetBtn.mas_right);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftBtn.mas_left);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightBtn.mas_right);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];

    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIImage *image = [UIImage imageNamed:@"icon"];
        GCPopMenuItem *item = [GCPopMenuItem itemWithTitle:@"测试title" image:image userinfo:nil];
        [itemArray addObject:item];
    }
    self.config = [[GCPopMenuConfig alloc] init];
    self.config.itemArray = itemArray;
    self.config.souceView = self.btn;
    self.config.menuWidth = 160;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point= [touch locationInView:self.view];
    self.btn.frame = CGRectMake(point.x - 40, point.y - 40, 80, 80);
}
- (void)targetBtn:(UIButton *)btn{
    self.targetView.hidden = !self.targetView.hidden;
    if (self.targetView.hidden) {
        self.config.targetView = nil;
    }else{
        self.config.targetView = self.targetView;
    }
}
- (void)upBtn{
    self.config.arrowDirection = GCPopMenuArrowDirectionUP;
    GCPopMenuView *menu = [[GCPopMenuView alloc] init];
    [menu showWithConfig:self.config];
}
- (void)leftBtn{
    self.config.arrowDirection = GCPopMenuArrowDirectionLeft;
    GCPopMenuView *menu = [[GCPopMenuView alloc] init];
    [menu showWithConfig:self.config];
}
- (void)rightBtn{
    self.config.arrowDirection = GCPopMenuArrowDirectionRight;
    GCPopMenuView *menu = [[GCPopMenuView alloc] init];
    [menu showWithConfig:self.config];
}
- (void)downBtn{
    self.config.arrowDirection = GCPopMenuArrowDirectionDown;
    GCPopMenuView *menu = [[GCPopMenuView alloc] init];
    [menu showWithConfig:self.config];
}
@end
