//
//  FNTransition.h
//  AnimationWars
//
//  Created by qianpanpan on 2020/3/5.
//  Copyright © 2020 MengLA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FNTransitionType){
    FNTransitionPush = 0,
    FNTransitionPop,
} ;


@interface FNTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) FNTransitionType type;
@end

NS_ASSUME_NONNULL_END
