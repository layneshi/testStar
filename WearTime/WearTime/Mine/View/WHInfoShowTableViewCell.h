//
//  WHInfoShowTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHInfoShowTableViewCell : UITableViewCell

- (void)setModel:(WHUserModel *)userModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
