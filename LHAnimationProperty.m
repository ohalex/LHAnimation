//
//  LHAnimationProperty.m
//  test
//
//  Created by 陈汉鑫 on 15/8/7.
//  Copyright (c) 2015年 陈汉鑫. All rights reserved.
//

#import "LHAnimationProperty.h"
#import "NSDictionary+LHAnimation.h"

@implementation LHAnimationProperty

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"the property %@ is not defined ",key);
    
    
}
-(instancetype) initWithAnimationCofig:(LHAnimationConfig *)config propertyDictionary:(NSDictionary *)dict
{
    
    self.animationConfig  = config;
    [self setValuesForKeysWithDictionary:dict];
    
    return self;
}

/**
 *  通过动画库文件路径和LHAnimationConfig对象来初始化LHAnimationProperty对象
 *  @param searchPath 动画库文件路径
 *  @param animationConfig 动画配置对象
 */

-(instancetype)initWithAnimationConfig:(LHAnimationConfig*)animationConfig forSearchPath:(NSString*)searchPath
{
    
        
    NSDictionary * animationsPropertyDict= [NSDictionary objectFromJsonFilePath:searchPath];
    if (!animationsPropertyDict) {
        return nil;
    }
    
    NSDictionary * animationPropertyDict = animationsPropertyDict[animationConfig.animationName];
    if (!animationPropertyDict) {
        return nil;
    }
    
    
    self.animationConfig= animationConfig;
    
    [self setValuesForKeysWithDictionary:animationPropertyDict];
    
    
    
    
    
    
    
    return self;
}

+(instancetype)animationPropertyWithAnimationConfig:(LHAnimationConfig *)config propertyDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithAnimationCofig:config propertyDictionary:dict];
}


+(instancetype)animationPropertyWithAnimationName:(LHAnimationConfig*)animationConfig forSearchPath:(NSString*)searchPath
{
    
    LHAnimationProperty * animationProperty= [[LHAnimationProperty alloc]initWithAnimationConfig:animationConfig forSearchPath:searchPath];
    return animationProperty;
}
@end
