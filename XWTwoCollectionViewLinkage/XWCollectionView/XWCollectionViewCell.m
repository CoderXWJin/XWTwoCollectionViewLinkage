//
//  XWCollectionViewCell.m
//  XWTwoCollectionViewLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import "XWCollectionViewCell.h"
#import "XWCollectionCategoryModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XWCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation XWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.width - 4)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageV];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(2, self.frame.size.width + 2, self.frame.size.width - 4, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}

- (void)setModel:(XWSubCategoryModel *)model
{
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.name.text = model.name;
}


@end

