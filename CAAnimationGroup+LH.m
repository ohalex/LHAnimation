//
//  CAAnimationGroup+LH.m
//  test
//
//  Created by 陈汉鑫 on 15/9/21.
//  Copyright © 2015年 陈汉鑫. All rights reserved.
//

#import "CAAnimationGroup+LH.h"


@implementation CAAnimationGroup (LH)

/**
 *  通过动画属性对象来创建一个CAAnimationGroup对象,同时配置要执行动画的view的相关属性
 *  @param  view 要执行动画的view
 *  @param animationProperty 动画属性对象
 *  return CAAnimationGroup对象
 */

+(instancetype)animationGroupforView:(UIView *)view WithProperty:(LHAnimationProperty*)animationProperty
{
    NSMutableArray* animations= [NSMutableArray array];
    
    
    
        
    
    if (animationProperty.opacityPath) {
        
        CAKeyframeAnimation * animation =[CAAnimation keyframeAnimationForView:view WithProperty:animationProperty withAnimatableKeyPath:kLHLayerOpacity];
        

        [animations addObject:animation];
    }
    
    if (animationProperty.moveCGPath) {
        CAKeyframeAnimation * animation =[CAAnimation keyframeAnimationForView:view WithProperty:animationProperty withAnimatableKeyPath:kLHLayerMovePosition];
        
        [animations addObject:animation];
    }
     if (animationProperty.translation3dPath) {
        
        
        CAKeyframeAnimation * animation =[CAAnimation keyframeAnimationForView:view WithProperty:animationProperty withAnimatableKeyPath:kLHLayerTranslation3d];
        
        animation.additive =YES;
        
        [animations addObject:animation];
    }
    
    
    if (animationProperty.scale3dPath) {
        CAKeyframeAnimation * animation =[CAAnimation keyframeAnimationForView:view WithProperty:animationProperty withAnimatableKeyPath:kLHLayerScale3d];

        animation.additive =YES;
        
        [animations addObject:animation];
    }
    
    
    if (animationProperty.rotation3dPath) {
        CAKeyframeAnimation * animation =[CAAnimation keyframeAnimationForView:view WithProperty:animationProperty withAnimatableKeyPath:kLHLayerRotation3d];
       
        animation.additive =YES;
        
        [animations addObject:animation];
    }
    
    
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = animations;
    
    animationGroup.duration = animationProperty.animationConfig.duration;
    
    return animationGroup;
    
}

@end
