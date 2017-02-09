//
//  UIImage+Image.h
//  LLPullEnlargement
//
//  Created by leileigege on 2017/2/9.
//  Copyright © 2017年 leileigege. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
