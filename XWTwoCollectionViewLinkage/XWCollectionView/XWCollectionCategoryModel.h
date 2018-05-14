//
//  XWCollectionCategoryModel.h
//  XWTwoCollectionViewLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWCollectionCategoryModel : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *subcategories;

@end
@interface XWSubCategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end
