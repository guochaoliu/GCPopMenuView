//
//  GCPopMenuView.m
//  FBSnapshotTestCase
//
//  Created by yons on 2020/8/24.
//

#import "GCPopMenuView.h"
#import "DHAssistWindowManager.h"
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
/// config
@property (nonatomic, strong) GCPopMenuConfig *config;
@end

@implementation GCPopMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self refreshFrame];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithWhite:.0f alpha:0.3f];
    self.tableView = [self configTableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    self.arrowView = [self configArrowView];
    [self.view addSubview:self.arrowView];
}
- (UITableView *)configTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.config.menuWidth, self.config.menuHeight)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.layer.cornerRadius = self.config.radius;
    tableView.layer.masksToBounds = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[GCPopMenuCell class] forCellReuseIdentifier:Cell_ID];
    return tableView;
}
- (GCPopMenuArrow *)configArrowView{
    GCPopMenuArrow *arrowView = [[GCPopMenuArrow alloc] initWithFrame:CGRectMake(0, 0, self.config.arrowWidth, self.config.arrowHeight)];
    arrowView.config = self.config;
    return arrowView;
}
- (void)refreshFrame{
    UIWindow *window = [[DHAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect = self.config.souceView?[self.config.souceView convertRect:self.config.souceView.bounds toView:window]:self.config.souceRect;
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
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x + (width - self.config.arrowWidth) / 2;
    CGFloat arrowY = y + height + self.config.arrowInterval;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)leftFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat height = rect.size.height;
    //tableView
    CGFloat tableViewX = x - self.config.menuWidth - self.config.arrowWidth - self.config.arrowInterval;
    CGFloat tableViewY = y - self.config.menuHeight / 2 + height / 2;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuHeight);
    //更新tableViewFrame
    [self refreshTableViewFrame];
    //arrowView
    CGFloat arrowX = x - self.config.arrowInterval - self.config.arrowWidth;
    CGFloat arrowY = y - self.config.arrowHeight / 2 + height / 2;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, self.config.arrowWidth, self.config.arrowHeight);
    //更新arrowViewFrame
    [self refreshArrowViewFrame];
}
- (void)rightFrame:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    //tableView
    CGFloat tableViewX = x + width + self.config.arrowWidth + self.config.arrowInterval;
    CGFloat tableViewY = y - self.config.menuHeight / 2 + height / 2;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuHeight);
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
    CGFloat tableViewY = y - self.config.arrowHeight - self.config.arrowInterval - self.config.menuHeight;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.config.menuWidth, self.config.menuHeight);
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
    if (!self.config.targetView) {
        return;
    }
    UIWindow *window = [[DHAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect = [self.config.targetView convertRect:self.config.targetView.bounds toView:window];
    CGFloat targetX = rect.origin.x;
    CGFloat targetY = rect.origin.y;
    CGFloat minX = targetX + self.config.menuInterval / 2;
    if (self.tableView.minX < minX) {
        self.tableView.frame = CGRectMake(minX, self.tableView.y, self.config.menuWidth, self.config.menuHeight);
    }
    CGFloat maxX = rect.size.width - self.config.menuInterval / 2;
    if (self.tableView.maxX > maxX) {
        self.tableView.frame = CGRectMake(self.config.targetView.maxX - self.tableView.width - 6, self.tableView.y, self.config.menuWidth, self.config.menuHeight);
    }
    CGFloat minY = targetY + self.config.menuInterval / 2;
    if (self.tableView.minY < minY) {
        self.tableView.frame = CGRectMake(self.tableView.x, minY, self.config.menuWidth, self.config.menuHeight);
    }
    CGFloat maxY = rect.origin.y + rect.size.height - self.config.menuInterval / 2;
    if (self.tableView.maxY > maxY) {
        self.tableView.frame = CGRectMake(self.tableView.x, maxY - self.tableView.height, self.config.menuWidth, self.config.menuHeight);
    }
}
- (void)refreshArrowViewFrame{
    if (!self.config.targetView) {
        return;
    }
    UIWindow *window = [[DHAssistWindowManager manager] getWindowWithIdentifier:AssistWindow_PopMenu];
    CGRect rect = [self.config.targetView convertRect:self.config.targetView.bounds toView:window];
    CGFloat targetX = rect.origin.x;
    CGFloat targetY = rect.origin.y;
    CGFloat minX = targetX + self.config.menuInterval;
    if (self.arrowView.x < minX) {
        self.arrowView.frame = CGRectMake(minX, self.arrowView.y, self.config.arrowWidth, self.config.arrowHeight);
    }
    CGFloat maxX = targetX + rect.size.width - self.config.menuInterval;
    if (self.arrowView.maxX > maxX) {
        self.arrowView.frame = CGRectMake(self.config.targetView.maxX - self.arrowView.width - 12, self.arrowView.y, self.config.arrowWidth, self.config.arrowHeight);
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
- (void)showWithConfig:(GCPopMenuConfig *)config{
    self.config = config;
    [self setupUI];
    [[DHAssistWindowManager manager] makeKeyWindowWithRootViewController:self identifier:AssistWindow_PopMenu];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[DHAssistWindowManager manager] deallocAssistWindowWithIdentifier:AssistWindow_PopMenu animation:YES completion:^(BOOL finish) {
        
    }];
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[DHAssistWindowManager manager] deallocAssistWindowWithIdentifier:AssistWindow_PopMenu animation:YES completion:^(BOOL finish) {
        
    }];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.config.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GCPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_ID forIndexPath:indexPath];
    cell.item = self.config.itemArray[indexPath.row];
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
