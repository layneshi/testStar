//
//  WHListsTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHListsTableViewCell.h"

@interface WHListsTableViewCell () <BEMCheckBoxDelegate>

@end

@implementation WHListsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WHListsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHListsTableViewCell description]];
    if (cell == nil) {
        cell = [[WHListsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHListsTableViewCell description]];
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
    [bgView addSubview:self.checkBox];
    
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
    
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(18.f);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)];
    [self addGestureRecognizer:tap];
}

- (void)pressAction:(UIGestureRecognizer *)tap{
    if (self.cellPress) {
        self.cellPress();
    }
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
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}


@end
