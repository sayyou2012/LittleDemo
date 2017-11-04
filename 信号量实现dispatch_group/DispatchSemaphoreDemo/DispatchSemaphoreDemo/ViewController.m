//
//  ViewController.m
//  DispatchSemaphoreDemo
//  ****************************************************
//  使用信号量实现dispatch_group_t的功能
//  ****************************************************
//  Created by sayyou2012 on 2017/11/4.
//  Copyright © 2017年 sayyou2012. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.semaphore = dispatch_semaphore_create(0);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //将当前线程睡眠2秒,模拟耗时任务
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务1执行完毕");
        dispatch_semaphore_signal(_semaphore);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //将当前线程睡眠2秒,模拟耗时任务
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务2执行完毕");
        dispatch_semaphore_signal(_semaphore);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //将当前线程睡眠2秒,模拟耗时任务
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务3执行完毕");
        dispatch_semaphore_signal(_semaphore);
    });
    
    //wait 3次，目的是当任务1，2，3都完成后，才执行任务4
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"执行任务4");
    });
}

@end
