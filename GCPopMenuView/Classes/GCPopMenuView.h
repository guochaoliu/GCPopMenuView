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
/// 展示无icon menu
/// @param title title
/// @param block block
- (void)addItemWithTitle:(NSString *)title block:(void(^)(void))block;
/// 添加Item
/// @param title title
/// @param image image
/// @param block block
- (void)addItemWithTitle:(NSString *)title image:(UIImage *)image block:(void(^)(void))block;
/// 添加Item
/// @param title title
/// @param imageUrl imageurl
/// @param block block
- (void)addItemWithTitle:(NSString *)title imageUrl:(NSURL *)imageUrl block:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
