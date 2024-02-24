//
//  WHSendTableViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/9.
//

#import "WHSendTableViewCell.h"

@interface WHSendTableViewCell ()

@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UIView *line3;
@property(nonatomic, strong) UIView *line4;
@property(nonatomic, strong) UIView *line5;

@property(nonatomic, strong) QMUILabel *nameLabel;
@property(nonatomic, strong) QMUITextField *nameField;

@property(nonatomic, strong) QMUILabel *phoneLabel;
@property(nonatomic, strong) QMUIButton *phoneBtn;;
@property(nonatomic, strong) QMUITextField *phoneField;

@property(nonatomic, strong) QMUILabel *mailLabel;
@property(nonatomic, strong) QMUITextField *mailField;

@property(nonatomic, strong) QMUILabel *wechatLabel;
@property(nonatomic, strong) QMUITextField *wechatField;

@property(nonatomic, assign) WHSendRole role;
@property(nonatomic, strong) QMUIButton *addBtn;

@end

@implementation WHSendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView withRole:(WHSendRole)role{
    WHSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WHSendTableViewCell description]];
    if (cell == nil) {
        cell = [[WHSendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WHSendTableViewCell description] withRole:role];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withRole:(WHSendRole)role{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.role = role;
        [self UPdateText];
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
    [bgView addSubview:self.line1];
    [bgView addSubview:self.line2];
    [bgView addSubview:self.line3];
    [bgView addSubview:self.line4];
    
    [bgView addSubview:self.nameLabel];
    [bgView addSubview:self.nameField];
    
    [bgView addSubview:self.phoneBtn];
    [bgView addSubview:self.phoneLabel];
    [bgView addSubview:self.phoneField];
    
    [bgView addSubview:self.mailLabel];
    [bgView addSubview:self.mailField];
    
    [bgView addSubview:self.wechatField];
    [bgView addSubview:self.wechatLabel];
    
    [bgView addSubview:self.line5];
    [bgView addSubview:self.addBtn];

    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.mas_equalTo(15.5f);
//        make.height.mas_equalTo(15.f);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15.f);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(0.5f);
    }];
    
    if (self.role == WHSendRole_Self) {
        self.nameLabel.hidden = YES;
        self.nameField.hidden = YES;
    } else {
        self.nameLabel.hidden = NO;
        self.nameField.hidden = NO;
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.top.equalTo(self.line1.mas_bottom).offset(20.5f);
            make.width.mas_equalTo(45.f);
        }];
        
        [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(30.f);
            make.centerY.equalTo(self.nameLabel);
            make.right.equalTo(bgView);
            make.height.mas_equalTo(80.f);
        }];
        
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(15.f);
            make.right.equalTo(bgView);
            make.height.mas_equalTo(0.5f);
        }];
    }
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        if (_role == WHSendRole_Self) {
            make.top.equalTo(self.line1.mas_bottom).offset(20.5f);
        } else {
            make.top.equalTo(self.line2.mas_bottom).offset(20.5f);
        }
        make.width.mas_equalTo(60.f);
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(20.f);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(12.f);
        make.centerY.equalTo(self.phoneLabel);
    }];
    
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = ColorHex(@"#eeeeee");
    [bgView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5f);
        make.height.mas_equalTo(24.f);
        make.left.equalTo(self.phoneBtn.mas_right).offset(10.f);
        make.centerY.equalTo(self.phoneLabel);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_right).offset(10.f);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(80.f);
        make.centerY.equalTo(self.phoneLabel);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(15.f);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.equalTo(self.line3.mas_bottom).offset(20.5f);
        make.width.mas_equalTo(45.f);
    }];
    
    [self.mailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mailLabel.mas_right).offset(30.f);
        make.centerY.equalTo(self.mailLabel);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(80.f);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.equalTo(self.mailLabel.mas_bottom).offset(15.f);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18.f);
        make.top.equalTo(self.line4.mas_bottom).offset(20.5f);
        make.width.mas_equalTo(45.f);
    }];
    
    [self.wechatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wechatLabel.mas_right).offset(30.f);
        make.centerY.equalTo(self.wechatLabel);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(80.f);
    }];
    
    if (_role == WHSendRole_Friend) {
        
        [self.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.top.equalTo(self.wechatLabel.mas_bottom).offset(15.f);
            make.right.equalTo(bgView);
            make.height.mas_equalTo(0.5f);
        }];
        
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.top.equalTo(self.line5.mas_bottom).offset(20.5f);
            make.width.mas_equalTo(80.f);
            make.height.mas_equalTo(32.f);
        }];
    }
}

- (void)UPdateText{
    switch (_role) {
        case WHSendRole_Self:
        {
            self.titleLabel.text = @"发送给自己";
            self.wechatField.placeholder = @"输入自己的微信";
        }
            break;
            
        case WHSendRole_Friend:
        {
            self.titleLabel.text = @"发送给好友";
            self.wechatField.placeholder = @"输入好友的微信";
        }
            break;
            
        case WHSendRole_Doctor:
        {
            self.titleLabel.text = @"发送给医生";
            self.wechatField.placeholder = @"输入医生的微信";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- lazy
- (UIView *)line1{
    if (!_line1) {
        _line1 = [UIView new];
        _line1.backgroundColor = ColorHex(@"#eeeeee");
    }
    return _line1;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [UIView new];
        _line2.backgroundColor = ColorHex(@"#eeeeee");
    }
    return _line2;
}

- (UIView *)line3{
    if (!_line3) {
        _line3 = [UIView new];
        _line3.backgroundColor = ColorHex(@"#eeeeee");
    }
    return _line3;
}

- (UIView *)line4{
    if (!_line4) {
        _line4 = [UIView new];
        _line4.backgroundColor = ColorHex(@"#eeeeee");
    }
    return _line4;
}

- (UIView *)line5{
    if (!_line5) {
        _line5 = [UIView new];
        _line5.backgroundColor = ColorHex(@"#eeeeee");
    }
    return _line5;
}

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}

- (QMUILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [QMUILabel new];
        _nameLabel.font = Font(14.f);
        _nameLabel.textColor = ColorHex(@"#111111");
        _nameLabel.text = @"姓名:";
    }
    return _nameLabel;
}

- (QMUITextField *)nameField{
    if (!_nameField) {
        _nameField = [QMUITextField new];
        _nameField.placeholderColor = ColorHex(@"#999999");
        _nameField.font = Font(14.f);
        _nameField.placeholder = @"请输入姓名";
    }
    return _nameField;
}

- (QMUILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [QMUILabel new];
        _phoneLabel.font = Font(14.f);
        _phoneLabel.textColor = ColorHex(@"#111111");
        _phoneLabel.text = @"手机号:";
    }
    return _phoneLabel;
}

- (QMUITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [QMUITextField new];
        _phoneField.placeholderColor = ColorHex(@"#999999");
        _phoneField.font = Font(14.f);
        _phoneField.placeholder = @"请输入手机号";
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneField;
}

- (QMUILabel *)mailLabel{
    if (!_mailLabel) {
        _mailLabel = [QMUILabel new];
        _mailLabel.font = Font(14.f);
        _mailLabel.textColor = ColorHex(@"#111111");
        _mailLabel.text = @"邮箱:";
    }
    return _mailLabel;
}

- (QMUITextField *)mailField{
    if (!_mailField) {
        _mailField = [QMUITextField new];
        _mailField.placeholderColor = ColorHex(@"#999999");
        _mailField.font = Font(14.f);
        _mailField.placeholder = @"请输入邮箱";
        _mailField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _mailField;
}

- (QMUILabel *)wechatLabel{
    if (!_wechatLabel) {
        _wechatLabel = [QMUILabel new];
        _wechatLabel.font = Font(14.f);
        _wechatLabel.textColor = ColorHex(@"#111111");
        _wechatLabel.text = @"微信:";
    }
    return _wechatLabel;
}

- (QMUITextField *)wechatField{
    if (!_wechatField) {
        _wechatField = [QMUITextField new];
        _wechatField.placeholderColor = ColorHex(@"#999999");
        _wechatField.font = Font(14.f);
    }
    return _wechatField;
}

- (QMUIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"+86" forState:UIControlStateNormal];
        [_phoneBtn setImage:[UIImage imageNamed:@"sendArrow"] forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = Font(14.f);
        [_phoneBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _phoneBtn.imagePosition = QMUIButtonImagePositionRight;
    }
    return _phoneBtn;
}

- (QMUIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+ 添加" forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:WHBaseTextColor];
//        [_addBtn setImage:[UIImage imageNamed:@"sendArrow"] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = Font(15.f);
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _addBtn.imagePosition = QMUIButtonImagePositionRight;
        _addBtn.layer.cornerRadius = 5.f;
    }
    return _addBtn;
}

@end
