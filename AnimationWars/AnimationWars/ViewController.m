//
//  ViewController.m
//  AnimationWars
//
//  Created by qianpanpan on 2020/3/5.
//  Copyright © 2020 MengLA. All rights reserved.
//

#import "ViewController.h"
#import "NexViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
}


- (IBAction)clickBtn:(id)sender {
    NexViewController *vc = [NexViewController new];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:true];
}


@end
