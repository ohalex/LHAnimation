//
//  LHAnimationConfig.m
//  test
//
//  Created by 陈汉鑫 on 15/8/29.
//  Copyright (c) 2015年 陈汉鑫. All rights reserved.
//

#import "LHAnimationConfig.h"

@implementation LHAnimationConfig

+(instancetype) animationConfigWithName:(NSString *)animationName  duration:(NSTimeInterval)duration
{
    
    LHAnimationConfig * animConfig = [[self alloc]init];
    animConfig.animationName = animationName;
    
    animConfig.duration =  duration;
    
    return animConfig;
}

@end
