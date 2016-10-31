//
//  PinYinForObjc.h
//
//  Created by wuyiguang on 13-1-24.
//  Copyright (c) 2013年 yiguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanyuPinyinOutputFormat.h"
#import "PinyinHelper.h"

@interface PinYinForObjc : NSObject

/**
 *  转换为拼音
 *
 *  @param chinese 需要转化的字符串
 *
 *  @return 返回拼音
 */
+ (NSString *)chineseToPinYin:(NSString *)chinese;

/**
 *  转换为拼音首字母
 *
 *  @param chinese 需要转化的字符串
 *
 *  @return 返回字符串的首字母
 */
+ (NSString *)chineseToPinYinLetter:(NSString *)chinese;

@end
