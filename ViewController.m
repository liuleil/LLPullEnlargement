//
//  ViewController.m
//  LLPullEnlargement
//
//  Created by leileigege on 2017/2/9.
//  Copyright © 2017年 leileigege. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"
#define HEADER_VIEW_HEIGHT 200
#define SEG_VIEW_HEIGHT 44
#define MIN_HEADER_HEIGHT 64
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.offsetY = -(HEADER_VIEW_HEIGHT + SEG_VIEW_HEIGHT);
    self.tab.contentInset = UIEdgeInsetsMake(HEADER_VIEW_HEIGHT + SEG_VIEW_HEIGHT, 0, 0, 0);
    
    
}
- (void)setNavBar {
    // 设置导航栏透明,我们可以使用透明颜色创建UIImage赋值背景图片,如果这个颜色的透明度是发生改变的,就能达到导航栏由不透明到透明的过程
    UIImage *img = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:img];
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"标题";
    
    [titleLab sizeToFit];
    self.navigationItem.titleView = titleLab;
 
}
#pragma mark - UIUIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    CGFloat dy = currentOffsetY - self.offsetY;
    CGFloat height = HEADER_VIEW_HEIGHT - dy;
    if (height <= MIN_HEADER_HEIGHT) {
        height = MIN_HEADER_HEIGHT;
    }
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,height);
    self.segView.frame = CGRectMake(0, self.headerView.frame.size.height, SCREEN_WIDTH, SEG_VIEW_HEIGHT);
    self.headerImgView.center = self.headerView.center;
    
    CGFloat alph = dy / (HEADER_VIEW_HEIGHT - MIN_HEADER_HEIGHT);
    if (alph >= 1) {
        alph = 0.99;
    }
    //处理透明颜色
    UIColor *color = [UIColor colorWithWhite:1 alpha:alph];
    
    UIImage *img = [UIImage imageWithColor:color];
    
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:img];
    //self.navigationItem.titleView.backgroundColor = color;
    self.navigationItem.titleView.alpha = alph;
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


@end
