//
//  LyCollectionViewCell.h
//  LyScrollViewDemo
//
//  Created by Lying on 16/7/16.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LyCollectionViewCell : UICollectionViewCell


-(void)setLycollectionViewCellWithImage:(NSString *)imageName
                       placeholderImage:(NSString *)placeholderImage
                       isNeedNetworking:(BOOL)isNeedNetworking;


@end
