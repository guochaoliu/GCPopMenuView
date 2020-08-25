//
//  GCPopMenuView.h
//  FBSnapshotTestCase
//
//  Created by yons on 2020/8/24.
//

#import <UIKit/UIKit.h>
#import "GCPopMenuConfig.h"


NS_ASSUME_NONNULL_BEGIN

@interface GCPopMenuView : UIViewController
/// 展示menu
/// @param config 配置
- (void)showWithConfig:(GCPopMenuConfig *)config;
/// 选择完成
@property (nonatomic, copy) void(^didSelectItem)(GCPopMenuItem *menuItem);

@end

NS_ASSUME_NONNULL_END
