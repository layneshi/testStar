//
//  WHPhoneCollectionViewCell.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHPhoneCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) QMUIButton *mBtn1;

@property(nonatomic, copy) void (^pressNumBtn)(void);

@end

NS_ASSUME_NONNULL_END
