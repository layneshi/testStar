//
//  WHMouldTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHMouldTableViewCell : UITableViewCell

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) UIImageView *mImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
