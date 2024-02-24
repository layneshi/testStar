//
//  WHSexTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHSexTableViewCell.h"

@interface WHSexTableViewCell () <BEMCheckBoxDelegate>

@end

@implementation WHSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHSexTableViewCell description]];
    if (cell == nil) {
        cell = [[WHSexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHSexTableViewCell description]];
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
    [bgView addSubview:self.manBox];
    [bgView addSubview:self.manLabel];
    [bgView addSubview:self.womenBox];
    [bgView addSubview:self.womenLabel];
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
    
    [self.womenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-17.5f);
        make.centerY.equalTo(self);
    }];
    
    [self.womenBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.womenLabel.mas_left).offset(-1.5);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20.f);
    }];
    
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.womenBox.mas_left).offset(-20.f);
        make.centerY.equalTo(self);
    }];
    
    [self.manBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.manLabel.mas_left).offset(-1.5);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20.f);
    }];
    
    [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(15.f);
        make.centerY.equalTo(self);
    }];
    
    self.warnLabel.hidden = YES;
}

#pragma mark -- BEMCheckBoxDelegate
- (void)didTapCheckBox:(BEMCheckBox *)checkBox{
    if (checkBox.tag == SexType_Man && checkBox.on) {
        self.womenBox.on = NO;
    } else if (checkBox.tag == SexType_Women && checkBox.on) {
        self.manBox.on = NO;
    }

    if (self.selectSex) {
        self.selectSex(checkBox.tag,checkBox.state);
    }
}

#pragma mark -- lazy
- (BEMCheckBox *)manBox {
    if (nil == _manBox) {
        _manBox = [BEMCheckBox new];
        _manBox.onTintColor = WHBaseTextColor;
        _manBox.onCheckColor = WHBaseTextColor;
        _manBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        _manBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
        _manBox.boxType = BEMBoxTypeSquare;
        _manBox.tag = SexType_Man;
        _manBox.delegate = self;
    }
    return _manBox;
}

- (BEMCheckBox *)womenBox {
    if (nil == _womenBox) {
        _womenBox = [BEMCheckBox new];
        _womenBox.onTintColor = WHBaseTextColor;
        _womenBox.onCheckColor = WHBaseTextColor;
        _womenBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        _womenBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
        _womenBox.boxType = BEMBoxTypeSquare;
        _womenBox.tag = SexType_Women;
        _womenBox.delegate = self;
    }
    return _womenBox;
}

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.text = @"性别(必填)";
        _titleLabel.textColor = ColorHex(@"#111111");
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _titleLabel;
}

- (QMUILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [QMUILabel new];
        _warnLabel.text = @"请选择性别";
        _warnLabel.textColor = ColorHex(@"#ED2D17");
        _warnLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _warnLabel;
}

- (QMUILabel *)manLabel{
    if (!_manLabel) {
        _manLabel = [QMUILabel new];
        _manLabel.text = @"男";
        _manLabel.textColor = ColorHex(@"#111111");
        _manLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _manLabel;
}

- (QMUILabel *)womenLabel{
    if (!_womenLabel) {
        _womenLabel = [QMUILabel new];
        _womenLabel.text = @"女";
        _womenLabel.textColor = ColorHex(@"#111111");
        _womenLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _womenLabel;
}

@end
