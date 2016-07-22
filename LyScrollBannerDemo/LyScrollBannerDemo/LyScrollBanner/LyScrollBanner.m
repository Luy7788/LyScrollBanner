//
//  LyScrollBanner.m
//  LyScrollBannerDemo
//
//  Created by Lying on 16/7/16.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define TimeInterval 3

#import "LyScrollBanner.h"
#import "LyCollectionViewCell.h"


@interface LyScrollBanner ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>//

@property (nonatomic ,strong)UICollectionView   *collectionView;
@property (nonatomic ,strong)NSMutableArray     *imagesArray;
@property (nonatomic ,strong)NSString           *placeholderImage;
@property (nonatomic ,assign)BOOL               isNetworkding;
@property (nonatomic ,strong)UIPageControl      *pageControl;
@property (nonatomic ,strong)NSTimer            *timer;

@end

@implementation LyScrollBanner

+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
            ImagesArrayWtithNetworking:(NSArray*)dataSource
                  placeholderImageName:(NSString *)placeholderImageName{
    
    LyScrollBanner *lySrollBanner = [[LyScrollBanner alloc]initWithFrame:frame ImagesArray:dataSource placeholderImage:placeholderImageName];
    return lySrollBanner;
}

+(instancetype)LyScrollBannerWithFrame:(CGRect)frame ImageNameArray:(NSArray*)dataSource{
    
    LyScrollBanner *lyScrollBanner = [[LyScrollBanner alloc]initWithFrame:frame ImageNameArray:dataSource];
    return lyScrollBanner;
}

-(instancetype)initWithFrame:(CGRect)frame
                 ImagesArray:(NSArray *)dataSource
            placeholderImage:(NSString *)placeholderImage{
    if(self = [super initWithFrame:frame]){
        self.imagesArray = [NSMutableArray arrayWithArray:dataSource];
        self.placeholderImage = placeholderImage;
        self.isNetworkding = YES;
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame ImageNameArray:(NSArray *)dataSource{
    
    if(self = [super initWithFrame:frame]){
        self.imagesArray = [NSMutableArray arrayWithArray:dataSource];
        self.isNetworkding = NO;
        [self initView];
    }
    return self;
}



-(void)initView{

    [self setBackgroundColor:[UIColor clearColor]];
    
    
    if(self.isCancelInfiniteBanner == NO){
        [self.imagesArray insertObject:self.imagesArray[self.imagesArray.count-1] atIndex:0];
        [self.imagesArray insertObject:self.imagesArray[0+1] atIndex:self.imagesArray.count];
    }
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize  = CGSizeMake(self.frame.size.width, self.frame.size.height);
    flowLayout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collection = [[UICollectionView  alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.pagingEnabled = YES;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    [collection registerNib:[UINib nibWithNibName:@"LyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LyCollectionViewCell"];
    
    collection.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [collection setBackgroundColor:[UIColor clearColor]];
    self.collectionView = collection;
    [self addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0 , self.frame.size.height - 30, self.frame.size.width, 20)];
    [self addSubview:self.pageControl];
    self.pageControl.currentPage = 0;
    if(self.isCancelInfiniteBanner == NO){
        self.pageControl.numberOfPages = self.imagesArray.count - 2;
    }
    else{
        self.pageControl.numberOfPages = self.imagesArray.count;
    }
    
    [self setupCollectionView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(self.isCancelAutoNextPage == NO){
            
            self.timer = [NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
            [self.timer fire];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];//mainRunLoop
        }
    });
    
}


-(void)nextPage:(NSTimer *)timer{
    
    int page = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    page ++;
    
    if(self.isCancelInfiniteBanner == NO){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else{
        
        if (page == self.imagesArray.count) {
            page = 0;
        }

        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

//当用户开始拖拽的时候就调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    if(self.isCancelAutoNextPage == NO)
        [self.timer invalidate];
}

//当用户停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(self.isCancelAutoNextPage == NO){
        
        self.timer = [NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];//mainRunLoop
    }

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;

//    NSLog(@"scrollViewDidScroll page:%d",page);
    
    if(self.isCancelInfiniteBanner == NO){
        
        if(page == self.imagesArray.count-1 && scrollView.contentOffset.x >= scrollView.contentSize.width - scrollView.frame.size.width - 30){
            //最后一张
            page = 0+1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
        }else if (page == 0 && scrollView.contentOffset.x <= 30){
//            //第一张
            page = self.imagesArray.count-2;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        
        self.pageControl.currentPage = page -1;
        
    }else{
        
        self.pageControl.currentPage = page;
    }
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imagesArray.count ;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"indexpath row%i item%i",indexPath.row,indexPath.item);
    
    LyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LyCollectionViewCell" forIndexPath:indexPath];
    [cell setLycollectionViewCellWithImage:self.imagesArray[indexPath.item] placeholderImage:self.placeholderImage isNeedNetworking:self.isNetworkding];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if([self.delegate respondsToSelector:@selector(LyScrollBannerViewClickTag:)]){
        if(self.isCancelInfiniteBanner == NO){
            
            [self.delegate LyScrollBannerViewClickTag:indexPath.item -1];
        }else{
            
            [self.delegate LyScrollBannerViewClickTag:indexPath.item];
        }
    }
}


-(void)setupCollectionView{
    
    if(self.isCancelInfiniteBanner == NO)
        //有无限轮播
        [self.collectionView  scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    else
        [self.collectionView  scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

-(void)setIsCancelAutoNextPage:(BOOL)isCancelAutoNextPage{
    
    _isCancelAutoNextPage = isCancelAutoNextPage;
    if(isCancelAutoNextPage == NO){
        //自动定时翻页
        /*
        [self.timer invalidate];
        self.timer = [NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
        [self.timer fire];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        */

    }else{
        //取消自动翻页
        [self.timer invalidate];
        self.timer = nil;
            
        self.pageControl.currentPage = 0;
    }
    
    [self setupCollectionView];
}


-(void)setIsCancelPageControl:(BOOL)isCancelPageControl{
    _isCancelPageControl = isCancelPageControl;
    if(_isCancelPageControl == NO){
        self.pageControl.hidden = NO;
    }else{
        //隐藏
        self.pageControl.hidden = YES;
    }
}

-(void)setIsCancelInfiniteBanner:(BOOL)isCancelInfiniteBanner{
    
    if(self.isCancelInfiniteBanner == isCancelInfiniteBanner)
        return;
    _isCancelInfiniteBanner = isCancelInfiniteBanner;
    if(isCancelInfiniteBanner == NO){
        [self.imagesArray insertObject:self.imagesArray[self.imagesArray.count-1] atIndex:0];
        [self.imagesArray insertObject:self.imagesArray[0+1] atIndex:self.imagesArray.count];
    }else{
        //取消无限轮播
        [self.imagesArray removeObjectAtIndex:0];
        [self.imagesArray removeObjectAtIndex:self.imagesArray.count-1];
        
        [self setupCollectionView];
    }
    
    [self.collectionView reloadData];
}


@end
