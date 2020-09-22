//
//  GCPopMenuCell.h
//  GCObjectDemo
//
//  Created by yons on 2020/8/20.
//  Copyright © 2020 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPopMenuItem.h"
#import "GCPopMenuConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCPopMenuCell : UITableViewCell
/// item
@property (nonatomic, strong) GCPopMenuItem *item;
/// config
@property (nonatomic, weak) GCPopMenuConfig *config;
/// 设置数据
/// @param item item
/// @param config config
- (void)setConfig:(GCPopMenuConfig *)config item:(GCPopMenuItem *)item;
@end

NS_ASSUME_NONNULL_END
