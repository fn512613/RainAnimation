//
//  FNTransition.m
//  AnimationWars
//
//  Created by qianpanpan on 2020/3/5.
//  Copyright © 2020 MengLA. All rights reserved.
//

#import "FNTransition.h"

@implementation FNTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (self.type) {
        case FNTransitionPush:
            [self pushAnimation:transitionContext];
            break;
        case FNTransitionPop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //目标ViewController的view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //当前ViewController的View
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //容器View
    UIView *containerView = [transitionContext containerView];
    //添加目标view到最底层
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    CGSize size = toView.frame.size;
    NSMutableArray *snapshots = [NSMutableArray array];
    
    //x轴元素个数
    CGFloat xFactor = 10.0f;
    
    //y轴元素个数
    CGFloat yFactor = xFactor * size.height / size.width;
    //获取被分割的View
    UIView *fromViewSnapshot = fromView;
    for (CGFloat x = 0; x < size.width; x+= size.width / xFactor) {
        for (CGFloat y = 0; y<size.height; y+= size.height/yFactor) {
            //获取每个小View的frame
            CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
            //使用截图的方法保存View
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            //添加小View到containerView
            [containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    //把fromView放入底层
    [containerView sendSubviewToBack:fromView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        for (UIView *view in snapshots) {
            CGFloat xOffset = [self randomFloatBetween:-100 and:100];
            CGFloat yOffset = containerView.frame.size.height;
            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
            /*
             CGAffineTransformScale
             1.进行变换的矩阵
             2.x方向缩放s倍数
             3.y方向缩放倍数
             
             CGAffineTransformMakeRotation
             旋转弧度
             */
            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10 and:10]), 0.01, 0.01);
            
        }
    }completion:^(BOOL finished) {
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    CGSize size = toView.frame.size;
    NSMutableArray *snapshots = [NSMutableArray new];
    NSMutableArray *frameShots = [NSMutableArray new];
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    UIView *fromViewSnapshot = toView;
    
    for (CGFloat x=0; x < size.width; x+= size.width / xFactor) {
        @autoreleasepool{
            for (CGFloat y=0; y < size.height; y+= size.height / yFactor) {
                CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
                
                UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                snapshot.frame = CGRectMake([self randomFloatBetween:snapshotRegion.origin.x-130 and:snapshotRegion.origin.x+130], [self randomFloatBetween:fromView.frame.size.height-120 and:fromView.frame.size.height+120], 0, 0);
                snapshot.alpha = 0.0;
                [containerView addSubview:snapshot];
                [snapshots addObject:snapshot];
                [frameShots addObject:[NSValue valueWithCGRect:snapshotRegion]];
            }
        }
    }
    toView.hidden = true;
    [containerView sendSubviewToBack:fromView];
    // animate
    [UIView animateWithDuration:1.2 animations:^{
        
        for (int i =0 ; i<snapshots.count; i++) {
            @autoreleasepool{
                UIView *view = snapshots[i];
                CGRect rect = [frameShots[i] CGRectValue];
                
                view.frame = rect;
                view.alpha = 1;
                view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 1, 1);
            }
        }
    } completion:^(BOOL finished) {
        toView.hidden = false;
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        [frameShots removeAllObjects];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//获取随机数
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end
