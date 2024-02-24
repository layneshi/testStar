//
//  WHListsTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHListsTableViewCell : UITableViewCell

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) BEMCheckBox *checkBox;

@property(nonatomic, copy) void (^cellPress)(void);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
