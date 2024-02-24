//
//  WHPhoneCodeTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHPhoneCodeTableViewCell.h"

@implementation WHPhoneCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHPhoneCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHPhoneCodeTableViewCell description]];
    if (cell == nil) {
        cell = [[WHPhoneCodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHPhoneCodeTableViewCell description]];
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
    
    [bgView addSubview:self.name];
    [bgView addSubview:self.checkBox];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
       
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.mas_equalTo(16.5f);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.right.mas_equalTo(-17.5f);
        make.width.height.mas_equalTo(18.f);
    }];

}

#pragma mark - lazy
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
