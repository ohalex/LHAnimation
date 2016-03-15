//
//  LHAnimationProperty.h
//  test
//
//  Created by 陈汉鑫 on 15/8/7.
//  Copyright (c) 2015年 陈汉鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "LHAnimationConfig.h"


/**
 时间函数类型：系统自带或自定义
 */
typedef enum LHTimeFunctionType{
    LHTimeFunctionTypeSystem=0,
    LHTimeFunctionTypeCubicBezeir
} LHTimeFunctionType;
/**
 系统自带时间曲线函数对应字符串数组
 */

#define LHSystemTimeFunctionList @[@"easeIn",@"easeOut",@"easeInEaseOut",@"linear",@"default"]
/**
 默认anchorPoint
 */
#define  LHDefaultAnchorPoint  CGPointMake(0.5, 0.5)



/**
 可用keyPath的枚举列表，指定动画对layer的某个属性操作
 */
typedef NS_ENUM(NSUInteger, LHAnimatableKeyPath) {
    kLHLayerOpacity=0,
    kLHLayerTranslation3d,
    kLHLayerScale3d,
    kLHLayerRotation3d,
    kLHLayerMovePosition
};


@interface LHAnimationProperty : NSObject



/**
 动画配置
 */
@property(strong,nonatomic) LHAnimationConfig * animationConfig;

/**
 总体时间函数
 */
@property(copy,nonatomic) NSString * timeFunction;

/**
 帧间时间函数
 */
@property(strong,nonatomic) NSArray * keyFrameTimingFunctions;
/**
 帧间时间函数类型
 */
@property(assign,nonatomic) LHTimeFunctionType frameTimingFunctionsType ;
/**
 帧时间点数组
 */
@property(strong,nonatomic) NSArray * timePoints;
/**
 透明度变化路径值
 */
@property(strong,nonatomic) NSArray * opacityPath;
/**
 平移位置变换路径
 */
@property(strong,nonatomic) NSArray * translation3dPath;
/**
 旋转变换路径
 */
@property(strong,nonatomic) NSArray * rotation3dPath;
/**
 缩放变换路径
 */
@property(strong,nonatomic) NSArray * scale3dPath;
/**
 曲线位置变换路径
 */
@property(strong,nonatomic) NSArray * moveCGPath;
/**
 视点距离
 */
@property(assign,nonatomic) CGFloat perspective;
/**
 锚点
 */
@property(assign,nonatomic) NSString * anchorPoint;
/**
 *  通过动画库文件路径和LHAnimationConfig对象来初始化LHAnimationProperty对象
 *  @param searchPath 动画库文件路径
 *  @param animationConfig 动画配置对象
 */



+(instancetype)animationPropertyWithAnimationName:(LHAnimationConfig*)animationConfig forSearchPath:(NSString*)searchPath;

+(instancetype)animationPropertyWithAnimationConfig:(LHAnimationConfig *)config propertyDictionary:(NSDictionary *)dict;
@end
