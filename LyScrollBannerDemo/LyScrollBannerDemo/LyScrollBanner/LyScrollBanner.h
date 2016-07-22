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

+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
            ImagesArrayWtithNetworking:(NSArray*)dataSource
                  placeholderImageName:(NSString *)placeholderImageName;


+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
                           ImagesArray:(NSArray*)dataSource;

-(instancetype)initWithFrame:(CGRect)frame
                 ImagesArray:(NSArray *)dataSource;


@property(nonatomic ,assign)BOOL       isCancelAutoNextPage;
@property(nonatomic ,assign)BOOL       isCancelPageController;
@property(nonatomic ,assign)BOOL       isCancelInfiniteBanner;//取消无限轮播


@property (nonatomic, weak)id <LyScrollBannerDelegate> delegate;

@end
