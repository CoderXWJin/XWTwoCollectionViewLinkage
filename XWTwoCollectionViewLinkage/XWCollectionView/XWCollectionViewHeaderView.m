//
//  XWCollectionViewHeaderView.m
//  XWTwoCollectionViewLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import "XWCollectionViewHeaderView.h"
//屏幕尺寸
#define DeviceWidth [[UIScreen mainScreen]bounds].size.width
#define DeviceHight [[UIScreen mainScreen]bounds].size.height
#define XWRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@implementation XWCollectionViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        
        self.blue = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, 8, 20)];
        self.blue.backgroundColor = [UIColor blueColor];
        [self addSubview:self.blue];
        
        
        self.backgroundColor = XWRGBAColor(240, 240, 240, 0.6);
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(22, 5, DeviceWidth - 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor lightGrayColor];
        [self addSubview:self.title];
    }
    return self;
}


@end

