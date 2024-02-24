//
//  WHMainTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHMainTableViewCell.h"

@interface WHMainTableViewCell ()

@property(nonatomic, strong) UIImageView *rightImageView;

@end

@implementation WHMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHMainTableViewCell description]];
    if (cell == nil) {
        cell = [[WHMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHMainTableViewCell description]];
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
//    bgView.layer.cornerRadius = 8.f;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView addSubview:self.iconImageView];
    [bgView addSubview:self.userName];
    [bgView addSubview:self.rightImageView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.height.mas_equalTo(27.5f);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15.f);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-16.5f);
        make.centerY.equalTo(bgView);
        make.width.mas_equalTo(6.f);
        make.height.mas_equalTo(10.f);
    }];
}

#pragma mark -- lazy
- (QMUILabel *)userName{
    if (!_userName) {
        _userName = [QMUILabel new];
        _userName.text = @"用户名称展示";
        _userName.font = Font(15.f);
        _userName.textColor = ColorHex(@"#111111");
    }
    return _userName;
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
