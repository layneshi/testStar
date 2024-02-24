//
//  WHNormalListTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHNormalListTableViewCell : UITableViewCell

@property(nonatomic, strong) QMUILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
