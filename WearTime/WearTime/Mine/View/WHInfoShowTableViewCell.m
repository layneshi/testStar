//
//  WHInfoShowTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHInfoShowTableViewCell.h"

@interface WHInfoShowTableViewCell ()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) QMUILabel *userName;
@property(nonatomic, strong) QMUILabel *userPhone;
@property(nonatomic, strong) UIImageView *rightImageView;

@end

@implementation WHInfoShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHInfoShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHInfoShowTableViewCell description]];
    if (cell == nil) {
        cell = [[WHInfoShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHInfoShowTableViewCell description]];
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
    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView addSubview:self.iconImageView];
    [bgView addSubview:self.userName];
    [bgView addSubview:self.userPhone];
    [bgView addSubview:self.rightImageView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17.5f);
        make.width.height.mas_equalTo(59.f);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_top).offset(5.f);
        make.left.equalTo(self.iconImageView.mas_right).offset(15.f);
    }];
    
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(10.f);
        make.left.equalTo(self.iconImageView.mas_right).offset(15.f);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-16.5f);
        make.centerY.equalTo(bgView);
        make.width.mas_equalTo(6.f);
        make.height.mas_equalTo(10.f);
    }];
}

- (void)setModel:(WHUserModel *)userModel{
    self.userName.text = userModel.username;
    self.userPhone.text = userModel.phone;
}

#pragma mark -- lazy
- (QMUILabel *)userName{
    if (!_userName) {
        _userName = [QMUILabel new];
        _userName.text = @"用户名称展示";
        _userName.font = [UIFont boldSystemFontOfSize:17.f];
        _userName.textColor = ColorHex(@"#111111");
    }
    return _userName;
}

- (QMUILabel *)userPhone{
    if (!_userPhone) {
        _userPhone = [QMUILabel new];
        _userPhone.text = @"138******89";
        _userPhone.font = Font(15.f);
        _userPhone.textColor = ColorHex(@"#111111");
    }
    return _userPhone;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        [_iconImageView setImage:[UIImage imageNamed:@"avator"]];
    }
    return _iconImageView;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        [_rightImageView setImage:[UIImage imageNamed:@"rightImage"]];
    }
    return _rightImageView;
}

@end
