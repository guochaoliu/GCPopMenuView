//
//  GCPopMenuCell.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/20.
//  Copyright © 2020 yons. All rights reserved.
//

#import "GCPopMenuCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface GCPopMenuCell ()
//** imageView *//
@property (nonatomic, strong) UIImageView *iconImageView;
//** label *//
@property (nonatomic, strong) UILabel *titleLabel;
//** bottomLineView *//
@property (nonatomic, strong) UIView *bottomLineView;
@end
@implementation GCPopMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIView *selectedView = [[UIView alloc] init];
    self.selectedBackgroundView = selectedView;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode = UIViewContentModeScaleToFill;
    self.iconImageView.clipsToBounds = YES;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bottomLineView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(Item_Interval);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(Item_Interval);
        make.right.equalTo(self.contentView.mas_right).offset(- Item_Interval);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(0.3f);
    }];
}
- (void)setConfig:(GCPopMenuConfig *)config item:(GCPopMenuItem *)item{
    self.config = config;
    self.item = item;
}
- (void)setItem:(GCPopMenuItem *)item{
    _item = item;
    self.titleLabel.text = item.title;
    if (item.image) {
        self.iconImageView.image = item.image;
    }
    if (item.imageUrl) {
        [self.imageView sd_setImageWithURL:item.imageUrl];
    }
    if ((!item.image && !item.imageUrl) || self.config.iconWidth <= 0) {
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
    }else{
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(Item_Interval);
            make.width.mas_equalTo(self.config.iconWidth);
            make.height.mas_equalTo(self.config.iconWidth);
        }];
    }
}
- (void)setConfig:(GCPopMenuConfig *)config{
    _config = config;
    self.backgroundColor = self.config.itemBackgroundColor;
    self.bottomLineView.backgroundColor = self.config.lineColor;
    self.titleLabel.textColor = self.config.titleColor;
    self.titleLabel.font = [UIFont systemFontOfSize:self.config.titleFont];
}

@end
