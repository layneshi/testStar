//
//  NSAttributedString+Add.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "NSAttributedString+Add.h"

@implementation NSAttributedString (Add)

+ (NSMutableAttributedString *)kt_makeAttributedWithText:(NSString *)text
                                             keyWords:(NSArray *)keyWords
                                      normalTextColor:(UIColor *)normalTextColor
                                         keyWordColor:(UIColor *)keyWordColor
                                                 font:(UIFont *)font {
    return [self makeAttributedWithText:text keyWords:keyWords urlArray:@[] normalTextColor:normalTextColor keyWordColor:keyWordColor font:font];
}

+ (NSMutableAttributedString *)makeAttributedWithText:(NSString *)text
                                             keyWords:(NSArray *)keyWords
                                             urlArray:(NSArray *)urlArray
                                      normalTextColor:(UIColor *)normalTextColor
                                         keyWordColor:(UIColor *)keyWordColor
                                                 font:(UIFont *)font {
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:text
                                                                                      attributes:@{NSForegroundColorAttributeName:normalTextColor,
                                                                                                   NSFontAttributeName:font
                                                                                                   }];
    for (NSInteger index = 0; index < keyWords.count; index ++ ) {
        NSString *keyWord = keyWords[index];
        NSString *url =  index < urlArray.count ? urlArray[index] : @"";
        NSRange textRange = [text rangeOfString:keyWord];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:keyWordColor,NSFontAttributeName:font}
                              range:textRange];
        if (url.length > 0) {
            [attributedText addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:url]} range:textRange];
        }
        
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];


    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    return attributedText;
}



@end
