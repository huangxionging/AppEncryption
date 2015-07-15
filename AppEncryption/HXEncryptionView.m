//
//  HXEncryptionView.m
//  AppEncryption
//
//  Created by huangxiong on 15/7/15.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import "HXEncryptionView.h"
#import "HXLinear.h"

@implementation HXEncryptionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 10.0);
    
    for (NSInteger index = 0; index < _linearArray.count; ++index) {
        HXLinear *linear = _linearArray[index];
        CGContextMoveToPoint(ctx, linear.start.x, linear.start.y);
        CGContextAddLineToPoint(ctx, linear.end.x, linear.end.y);
    }
    
    if (_isRed == YES) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    }
    else {
        CGContextSetStrokeColorWithColor(ctx, [UIColor yellowColor].CGColor);
    }
    
    CGContextStrokePath(ctx);
}


@end
