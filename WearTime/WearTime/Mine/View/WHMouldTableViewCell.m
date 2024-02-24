//
//  WHMouldTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHMouldTableViewCell.h"
#import "BEMCheckBox.h"

@interface WHMouldTableViewCell () <BEMCheckBoxDelegate>

@property(nonatomic, strong) BEMCheckBox *checkBox;

@end

@implementation WHMouldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHMouldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHMouldTableViewCell description]];
    if (cell == nil) {
        cell = [[WHMouldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHMouldTableViewCell description]];
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
    [bgView addSubview:self.mImageView];
    [bgView addSubview:self.checkBox];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13.5f);
        make.top.mas_equalTo(17.f);
//        make.height.mas_equalTo(15.f);
    }];
    
    [self.mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13.5f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15.f);
        make.bottom.mas_equalTo(-11.f);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.equalTo(self.titleLabel);
        make.width.height.mas_equalTo(18.f);
    }];
}

#pragma mark -- BEMCheckBoxDelegate
- (void)didTapCheckBox:(BEMCheckBox *)checkBox{

}

#pragma mark -- lazy
- (BEMCheckBox *)checkBox {
    if (nil == _checkBox) {
        _checkBox = [BEMCheckBox new];
        _checkBox.onTintColor = WHBaseTextColor;
        _checkBox.onCheckColor = WHBaseTextColor;
        _checkBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        _checkBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
        _checkBox.boxType = BEMBoxTypeSquare;
        _checkBox.delegate = self;
    }
    return _checkBox;
}

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = Font(15.f);
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}

- (UIImageView *)mImageView{
    if (!_mImageView) {
        _mImageView = [UIImageView new];
        _mImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _mImageView;
}

@end
