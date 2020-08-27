//
//  GCPopMenuView.m
//  FBSnapshotTestCase
//
//  Created by yons on 2020/8/24.
//

#import "GCPopMenuView.h"
#import <GCAssistWindow/GCAssistWindowManager.h>
#import "GCPopMenuArrow.h"
#import "GCPopMenuCell.h"
#import "UIView+GC.h"

#define AssistWindow_PopMenu @"PopMenAssistWindow"
#define Cell_ID @"popMenuCellID"
@interface GCPopMenuView ()<UITableViewDelegate,UITableViewDataSource>
/// tableView
@property (nonatomic, strong) UITableView *tableView;
/// arrowView
@property (nonatomic, strong) GCPopMenuArrow *arrowView;
/// 数据源
@property (nonatomic, strong) NSMutableArray<GCPopMenuItem *> *itemArray;
/// config
@property (nonatomic, strong) GCPopMenuConfig *config;
@end

@implementation GCPopMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self refreshFrame];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithWhite:.0f alpha:0.3f];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)showWithConfig:(GCPopMenuConfig *)config{
    GCPopMenuConfig *oldConfig = self.config;
    self.config = config;
    self.arrowView.config = config;
    self.tableView.layer.cornerRadius = config.radius;
    //menu未销毁 config更新 手动更新frame
    if (oldConfig && ![_config isEqual:oldConfig]) {
        [self refreshFrame];
    }
    [[GCAssistWindowManager manager] makeKeyWindowWithRootViewController:self identifier:AssistWindow_PopMenu];
}
- (void)refreshFrame{
    UIWindow *window = [[GCAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect;
    if (self.config.souceView) {
        rect = [self.config.souceView convertRect:self.config.souceView.bounds toView:window];
    }else{
        if (self.config.souceRectBlock) {
            rect = self.config.souceRectBlock([[UIDevice currentDevice] orientation]);
        }else{
            rect = self.config.souceRect;
        }
    }
    switch (self.config.arrowDirection) {
        case GCPopMenuArrowDirectionUP:
        {
            [self upFrame:rect];
        }
            break;
        case GCPopMenuArrowDirectionLeft:
        {
            [self leftFrame:rect];
        }
            break;
        case GCPopMenuArrowDirectionRight:
        {
            [self rightFrame:rect];
        }
            break;
        case GCPopMenuArrowDirectionDown:
        {
            [self downFrame:rect];
        }
            break;
        default:
            break;
    }
}
- (void)upFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    //tableView
    CGFloat tableViewX = x + (width - self.config.menuWidth) / 2;
    CGFloat tableViewY = y + height + self.config.arrowHeight + self.config.arrowInterval;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuMaxHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x + (width - self.config.arrowWidth) / 2;
    CGFloat arrowY = y + height + self.config.arrowInterval;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)rightFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat height = rect.size.height;
    //tableView
    CGFloat tableViewX = x - self.config.menuWidth - self.config.arrowWidth - self.config.arrowInterval;
    CGFloat tableViewY = y - self.config.menuMaxHeight / 2 + height / 2;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuMaxHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x - self.config.arrowInterval - self.config.arrowWidth;
    CGFloat arrowY = y - self.config.arrowHeight / 2 + height / 2;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)leftFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    //tableView
    CGFloat tableViewX = x + width + self.config.arrowWidth + self.config.arrowInterval;
    CGFloat tableViewY = y - self.config.menuMaxHeight / 2 + height / 2;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuMaxHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x + width + self.config.arrowInterval;
    CGFloat arrowY = y - self.config.arrowHeight / 2 + height / 2;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)downFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    //tableView
    CGFloat tableViewX = x + (width - self.config.menuWidth) / 2;
    CGFloat tableViewY = y - self.config.arrowHeight - self.config.arrowInterval - self.config.menuMaxHeight;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuMaxHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x + (width - self.config.arrowWidth) / 2;
    CGFloat arrowY = y - self.config.arrowInterval - self.config.arrowHeight;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)refreshTableViewFrame{
    CGFloat menuHeight = self.itemArray.count * self.config.itemHeight;
    if (menuHeight < self.config.menuMaxHeight) {
        if (self.config.arrowDirection == GCPopMenuArrowDirectionDown) {
            self.tableView.frame = CGRectMake(self.tableView.x, self.tableView.y + (self.config.menuMaxHeight - menuHeight), self.tableView.width, menuHeight);
        }else{
            self.tableView.frame = CGRectMake(self.tableView.x, self.tableView.y, self.tableView.width, menuHeight);
        }
    }
    if (!self.config.targetView && (self.config.targetRect.size.width == 0 || self.config.targetRect.size.height == 0)) {
        return;
    }
    UIWindow *window = [[GCAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect;
    if (self.config.targetView) {
        rect = [self.config.targetView convertRect:self.config.targetView.bounds toView:window];
    }else{
        rect = self.config.targetRect;
    }
    CGFloat targetX = rect.origin.x;
    CGFloat targetY = rect.origin.y;
    CGFloat minX = targetX + self.config.menuInterval / 2;
    if (self.tableView.minX < minX) {
        self.tableView.frame = CGRectMake(minX, self.tableView.y, self.tableView.width, self.tableView.height);
    }
    CGFloat maxX = targetX + rect.size.width - self.config.menuInterval / 2;
    if (self.tableView.maxX > maxX) {
        self.tableView.frame = CGRectMake(rect.origin.x + rect.size.width  - self.tableView.width - 6, self.tableView.y, self.tableView.width, self.tableView.height);
    }
    CGFloat minY = targetY + self.config.menuInterval / 2;
    if (self.tableView.minY < minY) {
        self.tableView.frame = CGRectMake(self.tableView.x, minY, self.tableView.width, self.tableView.height);
    }
    CGFloat maxY = targetY + rect.size.height - self.config.menuInterval / 2;
    if (self.tableView.maxY > maxY) {
        self.tableView.frame = CGRectMake(self.tableView.x, maxY - self.tableView.height, self.tableView.width, self.tableView.height);
    }
}
- (void)refreshArrowViewFrame{
    if (!self.config.targetView && (self.config.targetRect.size.width == 0 || self.config.targetRect.size.height == 0)) {
        return;
    }
    UIWindow *window = [[GCAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect;
    if (self.config.targetView) {
        rect = [self.config.targetView convertRect:self.config.targetView.bounds toView:window];
    }else{
        rect = self.config.targetRect;
    }
    CGFloat targetX = rect.origin.x;
    CGFloat targetY = rect.origin.y;
    CGFloat minX = targetX + self.config.menuInterval;
    if (self.arrowView.x < minX) {
        self.arrowView.frame = CGRectMake(minX, self.arrowView.y, self.config.arrowWidth, self.config.arrowHeight);
    }
    CGFloat maxX = targetX + rect.size.width - self.config.menuInterval;
    if (self.arrowView.maxX > maxX) {
        self.arrowView.frame = CGRectMake(rect.origin.x + rect.size.width - self.arrowView.width - 12, self.arrowView.y, self.config.arrowWidth, self.config.arrowHeight);
    }
    CGFloat minY = targetY + self.config.menuInterval;
    if (self.arrowView.minY < minY) {
        self.arrowView.frame = CGRectMake(self.arrowView.x, minY, self.config.arrowWidth, self.config.arrowHeight);
    }
    CGFloat maxY = targetY + rect.size.height - self.config.menuInterval;
    if (self.arrowView.maxY > maxY) {
        self.arrowView.frame = CGRectMake(self.arrowView.x, maxY - self.config.arrowHeight, self.config.arrowWidth, self.config.arrowHeight);
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[GCAssistWindowManager manager] deallocWindowWithIdentifier:AssistWindow_PopMenu];
}
#pragma mark -- 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.layer.masksToBounds = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GCPopMenuCell class] forCellReuseIdentifier:Cell_ID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (GCPopMenuArrow *)arrowView{
    if (!_arrowView) {
        _arrowView = [[GCPopMenuArrow alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_arrowView];
    }
    return _arrowView;
}
- (NSMutableArray<GCPopMenuItem *> *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}
#pragma mark -- addItem
- (void)addItemWithTitle:(NSString *)title image:(UIImage *)image block:(void(^)(void))block{
    GCPopMenuItem *item = [GCPopMenuItem itemWithTitle:title image:image block:block];
    [self.itemArray addObject:item];
}
- (void)addItemWithTitle:(NSString *)title imageUrl:(NSURL *)imageUrl block:(void(^)(void))block{
    GCPopMenuItem *item = [GCPopMenuItem itemWithTitle:title image:imageUrl block:block];
    [self.itemArray addObject:item];
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[GCAssistWindowManager manager] deallocWindowWithIdentifier:AssistWindow_PopMenu];
    GCPopMenuItem *item = self.itemArray[indexPath.row];
    if (item.block) {
        item.block();
    }
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GCPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_ID forIndexPath:indexPath];
    cell.item = self.itemArray[indexPath.row];
    cell.config = self.config;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.config.itemHeight;
}
- (void)dealloc{
    NSLog(@"dealloc %@",self);
}

@end
