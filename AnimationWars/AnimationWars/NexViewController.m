//
//  NexViewController.m
//  AnimationWars
//
//  Created by qianpanpan on 2020/3/5.
//  Copyright © 2020 MengLA. All rights reserved.
//

#import "NexViewController.h"
#import "FNTransition.h"
@interface NexViewController ()
@property (nonatomic, strong) FNTransition *transitionAnimation;
@end

@implementation NexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg2"].CGImage;
}

- (void)dealloc{
    NSLog(@"leave");
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.type = FNTransitionPush;
    }else if (operation == UINavigationControllerOperationPop){
        self.transitionAnimation.type = FNTransitionPop;
    }
    return self.transitionAnimation;
}


- (FNTransition *)transitionAnimation{
    if (_transitionAnimation == nil) {
        _transitionAnimation = [FNTransition new];
    }
    return _transitionAnimation;
}
@end
