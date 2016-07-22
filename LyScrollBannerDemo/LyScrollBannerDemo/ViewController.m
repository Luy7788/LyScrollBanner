//
//  ViewController.m
//  LyScrollBannerDemo
//
//  Created by Lying on 16/7/16.
//  Copyright © 2016年 Lying. All rights reserved.
//


#import "ViewController.h"
#import "LyScrollBanner.h"

@interface ViewController ()<LyScrollBannerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CGRect  rect = CGRectMake(0, 0, 320, 220);
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    LyScrollBanner *ScrollBanner = [LyScrollBanner LyScrollBannerWithFrame:rect
                                                            ImageNameArray:arr];
    ScrollBanner.delegate = self;
//    ScrollBanner.isCancelAutoNextPage = YES;
//    ScrollBanner.isCancelPageControl = YES;
//    ScrollBanner.isCancelInfiniteBanner = YES;
    [self.view addSubview:ScrollBanner];
    
    
    
    //url
    CGRect  rect1 = CGRectMake(0, 300, 320, 220);
    NSArray *arrHttp = @[@"http://pic9.nipic.com/20100909/3398346_111317208068_2.jpg",@"http://pic8.nipic.com/20100719/668573_214559007865_2.jpg",@"http://pic104.nipic.com/file/20160720/19451547_082719257000_2.jpg",@"http://pic104.nipic.com/file/20160720/19451547_082531991000_2.jpg"];

    LyScrollBanner *ScrollBanner1 = [LyScrollBanner LyScrollBannerWithFrame:rect1
                                                 ImagesArrayWtithNetworking:arrHttp
                                                       placeholderImageName:@"loading.jpg"];
    ScrollBanner1.delegate = self;
    [self.view addSubview:ScrollBanner1];
}




-(void)LyScrollBannerViewClickTag:(NSInteger)tag{
//    NSLog(@"indexpath item %d ",tag);
    [[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"点击了 item %d ",tag] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil]show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
