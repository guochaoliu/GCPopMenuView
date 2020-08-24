//
//  GCViewController.m
//  GCPopMenuView
//
//  Created by guochaoliu on 08/24/2020.
//  Copyright (c) 2020 guochaoliu. All rights reserved.
//

#import "GCViewController.h"
#import <Masonry/Masonry.h>
#import "GCPopMenuViewController.h"

@interface GCViewController ()<UITableViewDelegate,UITableViewDataSource>
/// tableView
@property (nonatomic, strong) UITableView *tableView;
/// dataArray
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    self.dataArray = @[
        @"up",
        @"left",
        @"right",
        @"down"
    ];
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GCPopMenuViewController *vc = [[GCPopMenuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
@end
