//
//  NSString+LH.m
//  test
//
//  Created by 陈汉鑫 on 15/8/30.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import "NSDictionary+LHAnimation.h"

@implementation NSDictionary (LHAnimation)

/**
 *  通过文件路径来创建一个json对象
 *  @param filePath 文件路径
 *  @return json对象
 */
+(instancetype)objectFromJsonFilePath:(NSString*)filePath{
    NSError * error;
    NSData * jsonData =[NSData dataWithContentsOfFile:filePath];
    
    if (jsonData==nil) {
        return nil;
    }
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    return jsonObject;
}
@end
