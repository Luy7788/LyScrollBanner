//
//  LyCollectionViewCell.m
//  LyScrollViewDemo
//
//  Created by Lying on 16/7/16.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import "LyCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LyCollectionViewCell

-(void)setLycollectionViewCellWithImage:(NSString *)imageName
                       placeholderImage:(NSString *)placeholderImage
                       isNeedNetworking:(BOOL)isNeedNetworking{
    
    if(isNeedNetworking == NO){
    
        [self.imageView setImage:[UIImage imageNamed:imageName]];
    
    }else{
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:placeholderImage]];
    }
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
}

@end
