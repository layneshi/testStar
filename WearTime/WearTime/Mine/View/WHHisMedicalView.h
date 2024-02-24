//
//  WHHisMedicalView.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHHisMedicalView : UIView

@property(nonatomic, strong) NSArray *hisArr;

- (void)reloadTableViewWithaArr:(NSArray *)arr;

@property(nonatomic, copy) void (^backWithArr)(NSArray *array);

@end

NS_ASSUME_NONNULL_END
