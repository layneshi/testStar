//
//  NSAttributedString+Add.h
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Add)

+ (NSMutableAttributedString *)kt_makeAttributedWithText:(NSString *)text
                                             keyWords:(NSArray *)keyWords
                                      normalTextColor:(UIColor *)normalTextColor
                                         keyWordColor:(UIColor *)keyWordColor
                                                 font:(UIFont *)font;

+ (NSMutableAttributedString *)makeAttributedWithText:(NSString *)text
                                             keyWords:(NSArray *)keyWords
                                             urlArray:(NSArray *)urlArray
                                      normalTextColor:(UIColor *)normalTextColor
                                         keyWordColor:(UIColor *)keyWordColor
                                                 font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
