//
//  PhotoNewsCollectionViewCell.m
//  SouLuo1.0
//
//  Created by ls on 15/9/23.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "PhotoNewsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PhotoNewsModel.h"
@interface PhotoNewsCollectionViewCell ()

@property (nonatomic , strong)UIImageView *photoImg;

@property (nonatomic , strong)UILabel *titleLabel;
//内容
@property (nonatomic , strong)UITextView *textView;

@end

@implementation PhotoNewsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        
        self.photoImg = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -180)];
        _photoImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_photoImg];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 64-180, SCREEN_WIDTH - 20, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;
        
//        NSDictionary *attributes = @{
//                                     NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:[UIColor whiteColor]
//                                     };
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 64- 150, SCREEN_WIDTH - 20, 140)];
        _textView.backgroundColor = [UIColor blackColor];
        _textView.textColor = [UIColor whiteColor];
//        self.textView.attributedText = [[NSAttributedString alloc]initWithString:@"" attributes:attributes];
        [_textView setEditable:NO];
        [self.contentView addSubview:_textView];
        
    }
    return self;
}

-(void)setPhotoNewsModel:(PhotoNewsModel *)photoNewsModel{
    
    
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:photoNewsModel.imgurl]];
    [_titleLabel setText:photoNewsModel.setname];
    _textView.text = photoNewsModel.note;
   // NSLog(@"imgtitle = %@",_textView.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
