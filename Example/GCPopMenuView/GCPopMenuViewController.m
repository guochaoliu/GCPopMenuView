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
/// menu
@property (nonatomic, strong) GCPopMenuView *menu;
/// showImage
@property (nonatomic, assign) BOOL showImage;
@end

@implementation GCPopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.showImage = YES;
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    [self.btn setTitle:@"moveBtn" forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor redColor]];
//    [self.btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BarItem" style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"无图" style:UIBarButtonItemStylePlain target:self action:@selector(noImageAction)];
    
    UIButton *targetBtn = [[UIButton alloc] init];
    [targetBtn setTitle:@"指定范围" forState:UIControlStateNormal];
    [targetBtn setBackgroundColor:[UIColor redColor]];
    [targetBtn addTarget:self action:@selector(targetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:targetBtn];
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
    
    [targetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/5.0);
        make.height.mas_equalTo(44);
    }];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(targetBtn.mas_left);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/5.0);
        make.height.mas_equalTo(44);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(targetBtn.mas_right);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/5.0);
        make.height.mas_equalTo(44);
    }];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftBtn.mas_left);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/5.0);
        make.height.mas_equalTo(44);
    }];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightBtn.mas_right);
        make.centerY.equalTo(targetBtn.mas_centerY);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/5.0);
        make.height.mas_equalTo(44);
    }];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point= [touch locationInView:self.view];
    self.btn.frame = CGRectMake(point.x - 40, point.y - 40, 80, 80);
}
- (void)noImageAction{
    self.showImage = !self.showImage;
}
- (void)barItemAction:(UIBarButtonItem *)item{
    GCPopMenuConfig *config = [[GCPopMenuConfig alloc] init];
    config.menuWidth = 160;
    [config setSouceRectBlock:^CGRect(UIDeviceOrientation orientation) {
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            {
                return CGRectMake(self.view.bounds.size.width - 67 - 12, 20, item.width, 44);
            }
                break;
            case UIDeviceOrientationPortraitUpsideDown:
            {
                return CGRectMake(self.view.bounds.size.width - 67 - 12, 20, item.width, 44);
            }
                break;
            case UIDeviceOrientationLandscapeLeft:
            {
                return CGRectMake(self.view.bounds.size.width - 67 - 12, 0, item.width, 44);
            }
                break;
            case UIDeviceOrientationLandscapeRight:
            {
                return CGRectMake(self.view.bounds.size.width - 67 - 12, 0, item.width, 44);
            }
                break;
            default:
                break;
        }
        return CGRectMake(self.view.bounds.size.width - 67 - 12, 20, item.width, 44);
    }];
    config.arrowDirection = GCPopMenuArrowDirectionRight;
    config.targetView = self.view;
    [self addItem];
    [self.menu showWithConfig:config];
}
- (void)targetBtn:(UIButton *)btn{
    self.targetView.hidden = !self.targetView.hidden;
}
- (void)upBtn{
    GCPopMenuConfig *config = [[GCPopMenuConfig alloc] init];
    config.menuWidth = 160;
    config.souceView = self.btn;
    config.arrowDirection = GCPopMenuArrowDirectionUP;
    config.automaticMenuWidth = YES;
    if (!self.showImage) {
        config.iconWidth = 0;
    }
    if (!self.targetView.hidden) {
        config.targetView = self.targetView;
    }
    [self addItem];
    [self.menu showWithConfig:config];
}
- (void)leftBtn{
    GCPopMenuConfig *config = [[GCPopMenuConfig alloc] init];
    config.menuWidth = 160;
    config.souceView = self.btn;
    config.arrowDirection = GCPopMenuArrowDirectionLeft;
    config.automaticMenuWidth = YES;
    if (!self.showImage) {
        config.iconWidth = 0;
    }
    if (!self.targetView.hidden) {
        config.targetView = self.targetView;
    }
    [self addItem];
    [self.menu showWithConfig:config];
}
- (void)rightBtn{
    GCPopMenuConfig *config = [[GCPopMenuConfig alloc] init];
    config.menuWidth = 160;
    config.souceView = self.btn;
    config.arrowDirection = GCPopMenuArrowDirectionRight;
    if (!self.showImage) {
        config.iconWidth = 0;
    }
    if (!self.targetView.hidden) {
        config.targetView = self.targetView;
    }
    [self addItem];
    [self.menu showWithConfig:config];
}
- (void)downBtn{
    __weak typeof(self) weakSelf = self;
    self.menu = [[GCPopMenuView alloc] init];
    GCPopMenuConfig *config = [[GCPopMenuConfig alloc] init];
    config.menuWidth = 160;
    config.souceView = self.btn;
    config.arrowDirection = GCPopMenuArrowDirectionDown;
    if (!self.showImage) {
        config.iconWidth = 0;
    }
    if (!self.targetView.hidden) {
        config.targetView = self.targetView;
    }
    UIImage *image = [UIImage imageNamed:@"icon"];
    [self.menu addItemWithTitle:@"测试title" image:image block:^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [weakSelf presentViewController:alertVC animated:YES completion:^{

        }];
    }];
    [self.menu showWithConfig:config];
}
- (void)addItem{
    self.menu = [[GCPopMenuView alloc] init];
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 5; i ++) {
        UIImage *image;
        if (self.showImage) {
            image = [UIImage imageNamed:@"icon"];
        }
        [self.menu addItemWithTitle:@"测试title" image:image block:^{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择完成" message:[NSString stringWithFormat:@"%d",i] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }]];
            [weakSelf presentViewController:alertVC animated:YES completion:^{

            }];
        }];
    }
}
@end
