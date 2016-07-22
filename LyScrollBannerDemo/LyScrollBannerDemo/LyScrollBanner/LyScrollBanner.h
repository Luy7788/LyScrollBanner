//
//  LyScrollBanner.h
//  LyScrollBannerDemo
//
//  Created by Lying on 16/7/16.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LyScrollBannerDelegate <NSObject>

//@optional
-(void)LyScrollBannerViewClickTag:(NSInteger)tag;

@end


@interface LyScrollBanner : UIView
/**
 *  初始化方法1 - dataSource为url的数组
 */
+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
            ImagesArrayWtithNetworking:(NSArray*)dataSource
                  placeholderImageName:(NSString *)placeholderImageName;

/**
 *  初始化方法2 - dataSource为本地imageName的数组
 */
+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
                        ImageNameArray:(NSArray*)dataSource;


-(instancetype)initWithFrame:(CGRect)frame
             ImageNameArray:(NSArray *)dataSource;


@property(nonatomic ,assign)BOOL       isCancelAutoNextPage;//取消自动轮播
@property(nonatomic ,assign)BOOL       isCancelPageControl;//取消pagecontrol;
@property(nonatomic ,assign)BOOL       isCancelInfiniteBanner;//取消无限轮播


@property (nonatomic, weak)id <LyScrollBannerDelegate> delegate;

@end
