//
//  CAAnimation+LH.h
//  test
//
//  Created by 陈汉鑫 on 15/9/21.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LHAnimationProperty.h"
#import <UIKit/UIKit.h>
@interface CAAnimation (LH)

/**
 *  通过动画属性对象和animatableKeyPath来创建一个CAKeyframeAnimation对象,同时配置要执行动画的view的相关属性
 *  @param  view 要执行动画的view
 *  @param animationProperty 动画属性对象
 *  @param keypath 指定动画操作的layer属性
 *  return CAKeyframeAnimation对象
 */
+(CAKeyframeAnimation*)keyframeAnimationForView:(UIView *) view WithProperty:(LHAnimationProperty *)animationProperty withAnimatableKeyPath:(LHAnimatableKeyPath)keyPath;

@end
