//
//  CAAnimation+LH.m
//  test
//
//  Created by 陈汉鑫 on 15/9/21.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import "CAAnimation+LH.h"
#import "LHCommon.h"

#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation CAAnimation (LH)

/**
 *  通过动画属性对象和animatableKeyPath来创建一个CAKeyframeAnimation对象,同时配置要执行动画的view的相关属性
 *  @param  view 要执行动画的view
 *  @param animationProperty 动画属性对象
 *  @param keypath 指定动画操作的layer属性
 *  return CAKeyframeAnimation对象
 */
+(CAKeyframeAnimation*)keyframeAnimationForView:(UIView *) view WithProperty:(LHAnimationProperty *)animationProperty withAnimatableKeyPath:(LHAnimatableKeyPath)keyPath
{
    
    if (animationProperty.anchorPoint != nil) {
        CGPoint anchorPoint =  CGPointFromString(animationProperty.anchorPoint);
        
        if (!CGPointEqualToPoint(anchorPoint,LHDefaultAnchorPoint)&& view !=nil) {
            
            
            CGRect oldFrame = view.frame;
            view.layer.anchorPoint =  anchorPoint;
            view.frame = oldFrame;
        }

    }
    
    
    CAKeyframeAnimation * animation =[CAKeyframeAnimation animation];
    
    switch (keyPath) {
        case kLHLayerOpacity:
            animation.keyPath =@"opacity";
            if (![animationProperty.opacityPath isKindOfClass:[NSArray class]]) {
                return nil;
            }
            animation.values =animationProperty.opacityPath;
            
            break;
        case kLHLayerTranslation3d:
        {
            animation.keyPath = @"transform";
            if (![animationProperty.translation3dPath isKindOfClass:[NSArray class]]) {
                return nil;
            }
            NSMutableArray * translation3dValues = [NSMutableArray array];
            
            for (NSString * translation3dStatus in animationProperty.translation3dPath) {
                NSArray * components = [translation3dStatus componentsSeparatedByString:LHSeparateStringComma];
                if ([components count]!=3) {
                    return  nil;
                }
                CGFloat tx = [components[0] floatValue];
                CGFloat ty = [components[1] floatValue];
                CGFloat tz = [components[2] floatValue];
                
                NSValue * value = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(tx, ty, tz)];
                [translation3dValues addObject:value];
            }
            
            animation.values = translation3dValues;
            
            
        }
            break;
        case kLHLayerScale3d:
        {
            if (![animationProperty.scale3dPath isKindOfClass:[NSArray class]]) {
                return  nil;
            }
           
            animation.keyPath =@"transform";
            NSMutableArray * scale3dValues = [NSMutableArray array];
           
            for (NSString * scale3dStatus in animationProperty.scale3dPath) {
                NSArray * components =[scale3dStatus componentsSeparatedByString:LHSeparateStringComma];
                if ([components count]!=3) {
                    return nil;
                }
                CGFloat sx = [components[0] floatValue];
                CGFloat sy = [components[1] floatValue];
                CGFloat sz = [components[2] floatValue];
                
                NSValue * value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(sx, sy, sz)];
                
                [scale3dValues addObject:value];
            }
            
            animation.values = scale3dValues;
            
        }
            break;
        case kLHLayerRotation3d:
        {
            if (![animationProperty.rotation3dPath isKindOfClass:[NSArray class]]) {
                
                return nil;
            }
           
            animation.keyPath =@"transform";
            NSMutableArray * rotation3dValues = [NSMutableArray array];
            
            for (NSString * rotation3dStatus in animationProperty.rotation3dPath) {
                NSArray * components =[rotation3dStatus componentsSeparatedByString:LHSeparateStringComma];
               
                if ([components count]!=4) {
                    return nil;
                }
               
                CGFloat angle = degreesToRadians([components[3] floatValue]);
                CGFloat rx = [components[0] floatValue];
                CGFloat ry = [components[1] floatValue];
                CGFloat rz = [components[2] floatValue];
                
                CATransform3D transform3d = CATransform3DIdentity;
                if (animationProperty.perspective) {
                    transform3d.m34 = -1.0/(animationProperty.perspective);
                    
                    
                }
               
                view.layer.zPosition = MAX(view.bounds.size.width, view.bounds.size.height);
                transform3d = CATransform3DRotate(transform3d,angle, rx, ry, rz);
                NSValue * value = [NSValue valueWithCATransform3D:transform3d];
                
                [rotation3dValues addObject:value];
            }
            
            animation.values = rotation3dValues;
            
        }
            break;
       
        case kLHLayerMovePosition:
        {
            if (![animationProperty.moveCGPath isKindOfClass:[NSArray class]]) {
                return nil;
            }
            
            animation.keyPath = @"position";
            CGMutablePathRef movePath = CGPathCreateMutable();
            
            for (NSString * positionStatus in animationProperty.moveCGPath) {
                NSArray * components = [positionStatus componentsSeparatedByString:LHSeparateStringComma];
                
                //如果是移动路径的起点
                if ([components count]==3 &&[components[0] isEqualToString:@"S"]) {
                    CGPoint startPoint = CGPointMake([components[1] floatValue], [components[2] floatValue]);
                    CGPathMoveToPoint(movePath, NULL, startPoint.x, startPoint.y);
                }
                //移动路径是直线
                else if ([components count] ==2  ) {
                    
                    
                    CGPoint endPoint = CGPointMake([components[0] floatValue], [components[1] floatValue]);
                    CGPathAddLineToPoint(movePath, NULL, endPoint.x, endPoint.y);
                    
                }
                //移动路径是bezier曲线
                else if ([components count] == 6){
                    
                    CGPoint ctlPoint1 = CGPointMake([components[0] floatValue], [components[1] floatValue]);
                    CGPoint ctlPoint2 = CGPointMake([components[2] floatValue], [components[3] floatValue]);
                    CGPoint endPoint = CGPointMake([components[4] floatValue], [components[5] floatValue]);
                    
                    
                    CGPathAddCurveToPoint(movePath, NULL, ctlPoint1.x, ctlPoint1.y, ctlPoint2.x, ctlPoint2.y, endPoint.x, endPoint.y);
                    
                }
                else {
                    CFRelease(movePath);
                    return nil;
                    
                }
            
            }
            
            animation.path = movePath;
            CFRelease(movePath);
           
            
        }
        
            break;
        default:
            return nil;
            
    }
   
    
    
    if ([animationProperty.timePoints isKindOfClass:[NSArray class]]) {
        animation.keyTimes = animationProperty.timePoints;
    }
    
    animation.duration =animationProperty.animationConfig.duration;
    
    if ([animationProperty.keyFrameTimingFunctions isKindOfClass:[NSArray class]]) {
        
        animation.timingFunctions = [self createTimingFunctionsWithArray:animationProperty.keyFrameTimingFunctions forType:animationProperty.frameTimingFunctionsType];
    }
    
    if ([animationProperty.timeFunction isKindOfClass:[NSString class]]&&
        [LHSystemTimeFunctionList containsObject:animationProperty.timeFunction]) {
        
        animation.timingFunction = [CAMediaTimingFunction functionWithName:animationProperty.timeFunction];
    }
    return animation;
}

#pragma mark - 创建时间曲线函数对象数组
/**
 *  通过时间函数类型（自定义或系统自带）和对应的时间函数配置数据数组来创建时间函数对象数组
 *  @param timingArray 时间函数配置数据数组
 *  @param type 时间函数类型
 *  return 时间函数对象数组
 */
+ (NSArray *)createTimingFunctionsWithArray:(NSArray*)timingArray forType:(LHTimeFunctionType)type
{
    
    if (!timingArray) {
        return nil;
    }
    
    NSMutableArray * timeFunctions=[NSMutableArray array];
    
    switch (type) {
            //系统自带时间曲线
        case LHTimeFunctionTypeSystem:
            for (__strong NSString * timeFun in timingArray) {
                
                if (![LHSystemTimeFunctionList containsObject:timeFun]) {
                    timeFun = [LHSystemTimeFunctionList lastObject];
                    LHLog(@"Invalid given system timeFunction name!");
                }
                
                
                CAMediaTimingFunction  *f  =  [CAMediaTimingFunction functionWithName:timeFun];
                [timeFunctions addObject:f];
                
            }
            break;
            //自定义bezier时间曲线
        case LHTimeFunctionTypeCubicBezeir:
            for (NSString* cubicBezier in timingArray) {
                CAMediaTimingFunction* f =[self createTimeFunctionWithCubicBezierString:cubicBezier];
                [timeFunctions addObject:f];
            }
            break;
        default:
            break;
    }
    return timeFunctions;
}

/**
 *  通过cubicBezier控制点字符串来创建时间函数对象
 *  @param cubicBezierString 时间控制点字符串
 *  return 时间函数对象
 */
+(CAMediaTimingFunction *) createTimeFunctionWithCubicBezierString:(NSString*)cubicBezierString
{
    
    CAMediaTimingFunction  *timeFunction ;
    NSArray* cubicBezierPoints= [cubicBezierString componentsSeparatedByString:LHSeparateStringComma];
    CGFloat x1=[cubicBezierPoints[0] floatValue];
    CGFloat y1=[cubicBezierPoints[1] floatValue];
    CGFloat x2=[cubicBezierPoints[2] floatValue];
    CGFloat y2=[cubicBezierPoints[3] floatValue];
    
    timeFunction=[CAMediaTimingFunction functionWithControlPoints:x1 :y1 :x2 :y2];
    
    return timeFunction;
    
    
    
}

@end
