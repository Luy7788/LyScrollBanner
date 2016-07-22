# LyScrollBanner
简单使用方法

```

    CGRect  rect = CGRectMake(0, 0, 320, 220);
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    LyScrollBanner *ScrollBanner = [LyScrollBanner LyScrollBannerWithFrame:rect
                                                                 ImagesArray:arr];
    ScrollBanner.delegate = self;
    [self.view addSubview:ScrollBanner];
  
```

代理方法点击获取序号
```
-(void)LyScrollBannerViewClickTag:(NSInteger)tag;
```

![ScreenFlow.gif](https://github.com/Super-lying/LyScrollBanner/blob/master/ScreenFlow.gif)

.h 头文件
```
#import <UIKit/UIKit.h>

@protocol LyScrollBannerDelegate <NSObject>

//@optional
-(void)LyScrollBannerViewClickTag:(NSInteger)tag;

@end

@interface LyScrollBanner : UIView
/**
 *  初始化方法1 - dataSource为url的数组
 */
+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
            ImagesArrayWtithNetworking:(NSArray*)dataSource
                  placeholderImageName:(NSString *)placeholderImageName;

/**
 *  初始化方法2 - dataSource为本地imageName的数组
 */
+(instancetype)LyScrollBannerWithFrame:(CGRect)frame
                        ImageNameArray:(NSArray*)dataSource;

-(instancetype)initWithFrame:(CGRect)frame
             ImageNameArray:(NSArray *)dataSource;

@property(nonatomic ,assign)BOOL       isCancelAutoNextPage;//取消自动轮播
@property(nonatomic ,assign)BOOL       isCancelPageControl;//取消pagecontrol;
@property(nonatomic ,assign)BOOL       isCancelInfiniteBanner;//取消无限轮播

@property (nonatomic, weak)id <LyScrollBannerDelegate> delegate;

@end

```
