//
//  WHWechatInviteTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHWechatInviteTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) QMUILabel *name;
@property(nonatomic, strong) BEMCheckBox *checkBox;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
