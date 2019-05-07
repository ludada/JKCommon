//
//  ViewController.m
//  JKCommonExample
//
//  Created by Sid on 2018/5/3.
//  Copyright © 2018 Sid. All rights reserved.
//

#import "ViewController.h"
#import "MPVolumeView+VolumeSlider.h"
#import "JKMacros.h"

@interface ViewController ()

@property (nonatomic, strong) MPVolumeView *volumnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    JKLog(@"%@", [self.volumnView volumeSlider]);
    [self.volumnView setVolume:0.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MPVolumeView *)volumnView {
    return _volumnView ?: (_volumnView = [[MPVolumeView alloc] init]);
}

@end
