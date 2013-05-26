//
//  ViewController.m
//  MSScrollViewDemo
//
//  Created by Shim Minseok on 13. 5. 26..
//  Copyright (c) 2013 Shim Minseok All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) MSScrollView *myScrollView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    self.myScrollView = [[MSScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _myScrollView.contentSize = CGSizeMake(320*10, IS_IPHONE_5?568:480);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.backgroundColor = [UIColor whiteColor];
    for(int i = 0; i<10; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){320*i,0,320,IS_IPHONE_5?568:480}];
        view.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/100.0f green:(arc4random()%100)/100.0f blue:(arc4random()%100)/100.0f alpha:1.0f];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        CGRect rect = label.frame;
        rect.origin.y = view.frame.size.height / 2 - 100;
        label.frame = rect;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"Test Page %d", i+1];
        label.font = [UIFont systemFontOfSize:22.0f];
        label.textAlignment =NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        [_myScrollView addSubview:view];
    }
    
    [self.view addSubview:_myScrollView];
    [_myScrollView setPageControl:CGPointMake(160,IS_IPHONE_5?520:430)];
    
    _myScrollView.didscroll = ^(BOOL isDecelerating, ScrollViewDirection direction, ScrollViewAction action)
    {
        NSLog(@"didScroll | isDecelerating:%d, direction:%d, action:%d", isDecelerating, direction, action);
    };
    
    _myScrollView.beginDragging = ^{
        
        NSLog(@"beginDragging");
    };
    _myScrollView.endDragging = ^{
        
        NSLog(@"endDragging");
        
    };
    _myScrollView.beginDecelerating = ^{
        
        NSLog(@"beginDecelerating");
        
    };
    _myScrollView.endDecelerating = ^{
        
        NSLog(@"endDecelerating");
        
    };
    
    [super viewDidLoad];
}

@end
