//
//  WHNumPadView.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHNumPadView.h"
#import "WHPhoneCollectionViewCell.h"




//1:  身高输入规则：人体身高区间范围定义为：50-230cm;
//
//2：输入超出定义范围的数字；会提示您填写的有误，请重新填写；同时“确认键盘”属于灰色不可点击状态；；
//
//3：输入第一个不合理数字的时候就会提醒：您填入的有误，请重新填写；同时等待两秒钟时间，清空内容；然后光标跳动可以重新输入；
//
//4：“放弃”按钮；一直是蓝色可以点击状态。
//
//5、身高和体重通过算法得出大致合理的区间范围，不在范围内提醒身高体重不合理



//注释
//1:  体重输入规则：人体体重区间范围定义为：5-1000斤;
//
//2：输入超出定义范围的单数或数组；会提示您填写的有误，请重新填写；同时“确认键盘”属于灰色不可点击状态；；
//
//3：输入第一个不合理数字的时候就会提醒：您填入的有误，请重新填写；同时等待两秒钟时间，清空内容；然后光标跳动可以重新输入；
//
//4：在输入正确的内容后，点击“确认”后，提示语消失；
//
//5：“放弃”按钮；一直是蓝色可以点击状态。
//
//6、身高和体重通过算法得出大致合理的区间范围，不在范围内提醒身高体重不合理





@interface WHNumPadView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong) NSArray *titleArr;

@end

@implementation WHNumPadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WHPhoneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WHPhoneCollectionViewCell description] forIndexPath:indexPath];
    [cell.mBtn1 setTitle:self.titleArr[indexPath.row] forState:UIControlStateNormal];
    @weakify(self)
    cell.pressNumBtn = ^{
        @strongify(self)
        [self pressNumWitnRow:indexPath.row];
    };
    if (indexPath.row == 3 ) {
        [cell .mBtn1 setBackgroundColor:WHBaseTextColor];
        [cell.mBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [cell .mBtn1 setBackgroundColor:ColorHex(@"#e9e9eb")];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self pressNumWitnRow:indexPath.row];
}

- (void)pressNumWitnRow:(NSInteger)row{
    NSString *selectTiele = self.titleArr[row];
    if ([selectTiele isEqualToString:@"放弃"]) {
        if (self.giveUpAction) {
            self.giveUpAction();
        }
    } else if ([selectTiele isEqualToString:@"确认"]) {
        if (self.confirmAction) {
            self.confirmAction();
        }
    } else {
        if (self.selectNum){
            self.selectNum(selectTiele);
        }

    }
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[WHPhoneCollectionViewCell class] forCellWithReuseIdentifier:[WHPhoneCollectionViewCell description]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (nil == _flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(90.f, 50.f);
        _flowLayout.minimumLineSpacing = 1.f;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    }
    return _flowLayout;
}

- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
        _titleArr = @[@"1",@"4",@"7",@"放弃",@"2",@"5",@"8",@"0",@"3",@"6",@"9",@"确认"];
    }
    return _titleArr;
}

@end


