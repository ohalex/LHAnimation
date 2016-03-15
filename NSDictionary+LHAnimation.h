//
//  NSString+LH.h
//  test
//
//  Created by 陈汉鑫 on 15/8/30.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LHAnimation)

/**
 *  通过文件路径来创建一个json对象
 *  @param filePath 文件路径
 *  @return json对象
 */

+(instancetype)objectFromJsonFilePath:(NSString*)filePath;
@end
