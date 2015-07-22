//
//  CircleNodeView.m
//  AddPassword
//
//  Created by huangxiong on 15/7/13.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import "CircleNodeView.h"

@implementation CircleNodeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = [UIColor purpleColor].CGColor;
        self.isSelected = NO;
    }
    
    return self;
}

//- (UIImage *) imageWithRect: (CGRect) rect {
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGContextRef ctx = CGBitmapContextCreate(nil, rect.size.width, rect.size.height, 8, 4 * rect.size.width, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
//    
//    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
//    
//    return [UIImage imageWithCGImage: imageRef];
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat locatons[] = {0.2, 0.9, 0.3};
    
    CGFloat components[] = {0.4, 0.5, 0.3, 0.8,
                            0.8, 0.13, 0.55, 0.9,
                            0.1, 0, 0.3, 0.5};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locatons, 3);
    
    CGPoint start = CGPointZero;
    CGPoint end = end = CGPointMake(self.frame.size.width, self.frame.size.height);;
    
    
    CGContextDrawLinearGradient(ctx, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
}


@end
