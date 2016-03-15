//
//  LHCommon.h
//  test
//
//  Created by 陈汉鑫 on 15/9/17.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#ifndef LHCommon_h
#define LHCommon_h

/**
 自定义log函数
 */
#ifdef DEBUG
#define LHLog(...) NSLog(__VA_ARGS__)
#else 
#define LHLog(...)
#endif

/**
 宏定义配置文件常用分隔符
 */
#define LHSeparateStringComma @","


#endif /* LHCommon_h */
