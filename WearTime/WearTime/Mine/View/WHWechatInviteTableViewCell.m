//
//  WHWechatInviteTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHWechatInviteTableViewCell.h"

@interface WHWechatInviteTableViewCell ()



@end

@implementation WHWechatInviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHWechatInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHWechatInviteTableViewCell description]];
    if (cell == nil) {
        cell = [[WHWechatInviteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHWechatInviteTableViewCell description]];
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
    
    [bgView addSubview:self.iconImageView];
    [bgView addSubview:self.name];
    [bgView addSubview:self.checkBox];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.width.height.mas_equalTo(25.f);
        make.left.mas_equalTo(20.f);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
//        make.width.height.mas_equalTo(25.f);
        make.left.equalTo(self.iconImageView.mas_right).offset(13.5f);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.right.mas_equalTo(-17.5f);
        make.width.height.mas_equalTo(18.f);
    }];

}

#pragma mark - lazy
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.layer.cornerRadius = 5.f;
    }
    return _iconImageView;
}

- (QMUILabel *)name{
    if (!_name) {
        _name = [QMUILabel new];
        _name.font = Font(14.f);
        _name.textColor = ColorHex(@"#111111");
    }
    return _name;
}

- (BEMCheckBox *)checkBox {
    if (nil == _checkBox) {
        _checkBox = [BEMCheckBox new];
        _checkBox.onTintColor = WHBaseTextColor;
        _checkBox.onCheckColor = WHBaseTextColor;
        _checkBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        _checkBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return _checkBox;
}

@end
