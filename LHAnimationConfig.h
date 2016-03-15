//
//  LHAnimationConfig.h
//  test
//
//  Created by 陈汉鑫 on 15/8/29.
//  Copyright (c) 2015年 陈汉鑫. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LHAnimationConfig : NSObject
/**
 库中动画名
 */
@property(strong,nonatomic) NSString * animationName;
/**
 动画周期
 */
@property(assign,nonatomic) NSTimeInterval duration;

+(instancetype) animationConfigWithName:(NSString *)animationName duration:(NSTimeInterval)duration;
@end
