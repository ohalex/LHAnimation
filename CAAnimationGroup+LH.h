//
//  CAAnimationGroup+LH.h
//  test
//
//  Created by 陈汉鑫 on 15/9/21.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CAAnimation+LH.h"

@interface CAAnimationGroup (LH)
/**
 *  通过动画属性对象来创建一个CAAnimationGroup对象,同时配置要执行动画的view的相关属性
 *  @param  view 要执行动画的view
 *  @param animationProperty 动画属性对象
 *  return CAAnimationGroup对象
 */
+(instancetype)animationGroupforView:(UIView *)view WithProperty:(LHAnimationProperty*)animationProperty;
@end
