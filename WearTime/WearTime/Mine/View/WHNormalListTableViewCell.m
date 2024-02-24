//
//  WHNormalListTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHNormalListTableViewCell.h"

@implementation WHNormalListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHNormalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHNormalListTableViewCell description]];
    if (cell == nil) {
        cell = [[WHNormalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHNormalListTableViewCell description]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = [UIColor clearColor];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    [bgView addSubview:self.titleLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.5f);
        make.centerY.equalTo(self);
//        make.height.mas_equalTo(15.f);
    }];
}

#pragma mark -- lazy

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}

@end
