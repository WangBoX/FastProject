//
//  UIBasicCell.m
//  ZJHJ
//
//  Created by WBO on 2016/11/22.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "UIBasicCell.h"

@implementation UIBasicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:228.0/255.0 alpha:1];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
