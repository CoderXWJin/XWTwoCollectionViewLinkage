//
//  ViewController.m
//  XWTwoCollectionViewLinkageLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import "ViewController.h"
#import "XWCollectionViewFlowLayout.h"
#import "XWCollectionViewCell.h"
#import "XWCollectionViewHeaderView.h"
#import "XWSegmentTitleView.h"
#import "XWCollectionCategoryModel.h"
#import "XWPageContentView.h"
#import "NSObject+XWProperty.h"
#define DeviceWidth [[UIScreen mainScreen]bounds].size.width
#define DeviceHight [[UIScreen mainScreen]bounds].size.height
#define XWRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define XWGlobaBg XWRGBAColor(253, 212, 49, 1.0);
@interface ViewController () <UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,XWPageContentViewDelegate,XWSegmentTitleViewDelegate>{
    
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic, strong) XWPageContentView *pageContentView;
@property (nonatomic, strong) XWSegmentTitleView *titleView;
@property (nonatomic, strong) NSMutableArray  *titleArr;
@end

static NSString * const JGCollectionTableCellId = @"XWCollectionTableCellId";
static NSString * const JGCollectionCellId = @"XWCollectionCellId";
static NSString * const JGCollectionViewHeaderId = @"XWCollectionViewHeaderId";

@implementation ViewController

#pragma mark - 懒加载 -
-(NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
        
    }
    return _titleArr;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas
{
    if (!_collectionDatas)
    {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

//- (UITableView *)tableView
//{
//    if (!_tableView)
//    {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, kDeviceHight)];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableFooterView = [UIView new];
//        _tableView.rowHeight = 55;
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorColor = [UIColor clearColor];
//        [_tableView registerClass:[JGLeftTableViewCell class] forCellReuseIdentifier:JGCollectionTableCellId];
//    }
//    return _tableView;
//}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        XWCollectionViewFlowLayout *flowlayout = [[XWCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 4;
        //上下间距
        flowlayout.minimumLineSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 , 52 + 64, DeviceWidth - 4, DeviceHight - 64 -4-50) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //  flowlayout.sectionHeadersPinToVisibleBounds = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册cell
        [_collectionView registerClass:[XWCollectionViewCell class] forCellWithReuseIdentifier:JGCollectionCellId];
        _collectionView.bounces = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 300   , 0);
        
        //注册分区头标题
        [_collectionView registerClass:[XWCollectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JGCollectionViewHeaderId];
        
    }
    return _collectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollDown = YES ;
    self.title = @"仿支付宝更多页面联动";
    //创建表格
    [self createTable];
    //加载数据
    [self loadData];
}

//创建表格
- (void)createTable {
    
    //   [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}

//加载数据
- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    
    for (NSDictionary *dict in categories) {
        [self.titleArr addObject:dict[@"name"]];
        XWCollectionCategoryModel *model = [XWCollectionCategoryModel objectWithDictionary:dict];
        [self.dataSource addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (XWSubCategoryModel *s_model in model.subcategories) {
            
            [datas addObject:s_model];
        }
        [self.collectionDatas addObject:datas];
    }
    self.titleView = [[XWSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, 50) titles:self.titleArr delegate:self indicatorType:XWIndicatorTypeEqualTitle];
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:16];
    self.titleView.titleSelectColor = [UIColor blueColor];
    [self.view addSubview:self.titleView];
    self.titleView.backgroundColor = [UIColor whiteColor];
    //[self.tableView reloadData];
    [self.collectionView reloadData];
    // [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

//#pragma mark - UITableView DataSource Delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    JGLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGCollectionTableCellId forIndexPath:indexPath];
//  J
//    cell.name.text = model.name;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    _selectIndex = indexPath.row;
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//
//}
- (void)XWSegmentTitleView:(XWSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    // _selectIndex = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:endIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    
}
#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XWCollectionCategoryModel *model = self.dataSource[section];
    
    return model.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JGCollectionCellId forIndexPath:indexPath];
    XWSubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    cell.model = model;
    cell.backgroundColor = XWGlobaBg;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((DeviceWidth - 4 - 4 * 3 ) / 4, (DeviceWidth  - 4 -  4 * 3)  / 4 + 30);
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
        reuseIdentifier = JGCollectionViewHeaderId;
    }
    
    XWCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XWCollectionCategoryModel *model = self.dataSource[indexPath.section];
        view.title.text = model.name;
    }
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(DeviceWidth, 30);
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

//// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.titleView setSelectIndex:index];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

