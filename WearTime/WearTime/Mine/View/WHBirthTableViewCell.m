//
//  WHBirthTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHBirthTableViewCell.h"

@interface WHBirthTableViewCell ()


@property(nonatomic, strong) UIImageView *icon;

@end


@implementation WHBirthTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHBirthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHBirthTableViewCell description]];
    if (cell == nil) {
        cell = [[WHBirthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHBirthTableViewCell description]];
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
    [bgView addSubview:self.mBtn];
    [bgView addSubview:self.icon];
    [bgView addSubview:self.warnLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.centerY.equalTo(self);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.5);
        make.width.mas_equalTo(6.f);
        make.height.mas_equalTo(10.f);
        make.centerY.equalTo(self);
    }];
    
    [self.mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.icon.mas_left).offset(-10);
//        make.width.mas_equalTo(6.f);
        make.height.mas_equalTo(20.f);
        make.centerY.equalTo(self);
    }];
    
    [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(15.f);
        make.centerY.equalTo(self);
    }];
}

#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.text = @"性别(必填)";
        _titleLabel.textColor = ColorHex(@"#111111");
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _titleLabel;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        [_icon setImage:[UIImage imageNamed:@"rightImage"]];
    }
    return _icon;
}

- (QMUIButton *)mBtn{
    if (!_mBtn) {
        _mBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_mBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_mBtn setTitleColor:ColorHex(@"#999999") forState:UIControlStateNormal];
        _mBtn.titleLabel.font = Font(14.f);
    }
    return _mBtn;
}

- (QMUILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [QMUILabel new];
        _warnLabel.text = @"请选择出生日期";
        _warnLabel.textColor = ColorHex(@"#ED2D17");
        _warnLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _warnLabel.hidden = YES;
    }
    return _warnLabel;
}


@end
