//
//  WHSendTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WHSendRole_Self          = 0, // 自己
    WHSendRole_Friend     = 1, // 朋友
    WHSendRole_Doctor     = 2, // 医生
} WHSendRole;

@interface WHSendTableViewCell : UITableViewCell


@property(nonatomic, strong) QMUILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView withRole:(WHSendRole)role;

@end

NS_ASSUME_NONNULL_END
