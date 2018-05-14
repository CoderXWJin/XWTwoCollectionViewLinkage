//
//  XWCollectionViewCell.h
//  XWTwoCollectionViewLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWSubCategoryModel;
@interface XWCollectionViewCell : UICollectionViewCell
/** 模型  */
@property (nonatomic, strong)XWSubCategoryModel *model;
@end
