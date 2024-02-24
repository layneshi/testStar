//
//  WHSexTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SexType_Man         = 0, // 男
    SexType_Women     = 1, // 女
} SexType;

@interface WHSexTableViewCell : UITableViewCell


@property(nonatomic, strong) QMUILabel *warnLabel;
@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) BEMCheckBox *manBox;
@property(nonatomic, strong) QMUILabel *manLabel;
@property(nonatomic, strong) BEMCheckBox *womenBox;
@property(nonatomic, strong) QMUILabel *womenLabel;

@property(nonatomic, copy) void (^selectSex)(SexType type,BOOL isCheckOn);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
