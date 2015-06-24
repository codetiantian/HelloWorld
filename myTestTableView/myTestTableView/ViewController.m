//
//  ViewController.m
//  myTestTableView
//
//  Created by Elaine on 15--19.
//  Copyright (c) 2015年 yinuo. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define mainSize [UIScreen mainScreen].bounds.size
#define dataCount 20

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (assign, nonatomic) BOOL isLoaded;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.isLoaded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainSize.width, 10)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isLoaded) {
        [self changeCell:cell forRowAtIndexPath:indexPath];
        
        if (indexPath.section == dataCount - 1) {
            self.isLoaded = YES;
        }
    } else {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            moveAnimation.fromValue = [NSValue valueWithCGPoint:cell.layer.position];
            
            CGPoint toPoint = cell.layer.position;
            toPoint.x -= 20;
            moveAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
            moveAnimation.duration = 0.5;
            
            [cell.layer addAnimation:moveAnimation forKey:@"cbLayerMove"];
        });
    }
}

- (void)changeCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGRect rect = cell.frame;
        rect.origin.x = mainSize.width;
        cell.frame = rect;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * indexPath.section * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7];
        
        CGRect rect = cell.frame;
        rect.origin.x = - 20;
        cell.frame = rect;
        
        [UIView commitAnimations];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.1 * indexPath.section + 0.8) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = cell.frame;
        rect.origin.x = 0;
        cell.frame = rect;
        
        [UIView commitAnimations];
    });

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIndex = @"cellIndex";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIndex];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndex];
    }
    
    cell.backgroundColor = [UIColor greenColor];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"-------%li", indexPath.section);
}

@end
