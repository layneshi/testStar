//
//  WHDetailTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHDetailTableViewCell.h"

@interface WHDetailTableViewCell ()

@end

@implementation WHDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHDetailTableViewCell description]];
    if (cell == nil) {
        cell = [[WHDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHDetailTableViewCell description]];
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
    [bgView addSubview:self.text];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.centerY.equalTo(self);
    }];
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
//        make.width.mas_equalTo(6.f);
//        make.height.mas_equalTo(10.f);
        make.centerY.equalTo(self);
    }];
    
    [self.mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.text.mas_left).offset(-10);
//        make.width.mas_equalTo(6.f);
        make.height.mas_equalTo(20.f);
        make.centerY.equalTo(self);
    }];
}

- (void)setPeopleModelWithModel:(WHPeopleModel *)peopleModel{
    
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

- (QMUILabel *)text{
    if (!_text) {
        _text = [QMUILabel new];
        _text.text = @"厘米";
        _text.textColor = ColorHex(@"#111111");
        _text.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _text;
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

@end
