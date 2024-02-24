//
//  WHDetailTableViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHDetailTableViewCell : UITableViewCell

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUILabel *text;
@property(nonatomic, strong) QMUIButton *mBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setPeopleModelWithModel:(WHPeopleModel *)peopleModel;

@end

NS_ASSUME_NONNULL_END
