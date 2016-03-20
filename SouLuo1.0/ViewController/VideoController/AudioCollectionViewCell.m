//
//  AudioCollectionViewCell.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudioCollectionViewCell.h"
#import "AudiotListModel.h"
#import "UIImageView+WebCache.h"
@implementation AudioCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _cnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10,RATIO_HEIGHT*10, RATIO_WIDTH*335,RATIO_HEIGHT*30)];
//        [_cnameLabel setBackgroundColor:[UIColor magentaColor]];
        [self.contentView addSubview:_cnameLabel];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, RATIO_HEIGHT*40, RATIO_WIDTH*355, 1)];
        [_label setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_label];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(RATIO_WIDTH*275, RATIO_HEIGHT*10, RATIO_WIDTH*50, RATIO_HEIGHT*30);
        [_button setTitle:@"进入" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_button setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_button];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*320, RATIO_HEIGHT*14, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
//        [_imageView setBackgroundColor:[UIColor redColor]];
        [_imageView setImage:[UIImage imageNamed:@"xyg.png"]];
        [self.contentView addSubview:_imageView];
        
        _buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonOne setFrame:CGRectMake(RATIO_WIDTH*6, RATIO_HEIGHT*50,RATIO_WIDTH*110, RATIO_HEIGHT*220)];
//        [_buttonOne setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_buttonOne];
        
        _imgsrcOne = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*10, RATIO_WIDTH*100, RATIO_WIDTH*100)];
//        [_imgsrcOne setBackgroundColor:[UIColor redColor]];
        _imgsrcOne.layer.cornerRadius = RATIO_WIDTH*100/2.;
        _imgsrcOne.layer.masksToBounds = YES;
        _imgsrcOne.layer.borderWidth = 1;
        _imgsrcOne.layer.borderColor = [[UIColor grayColor]CGColor];
        [_buttonOne addSubview:_imgsrcOne];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = CGRectMake(RATIO_WIDTH*36,RATIO_HEIGHT*38,RATIO_WIDTH*30,RATIO_WIDTH*30);
        [_button1 setBackgroundColor:[UIColor blackColor]];
        [_button1 setAlpha:0.8];
        _button1.layer.cornerRadius = RATIO_WIDTH*30/2;
        [self.imgsrcOne addSubview:_button1];
        
        _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*7, RATIO_HEIGHT*6, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
        [_imageView1 setUserInteractionEnabled:YES];
        [_imageView1 setImage:[UIImage imageNamed:@"播放1.png"]];
        [_button1 addSubview:_imageView1];
        
        _tnameLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*125, RATIO_WIDTH*100, RATIO_HEIGHT*30)];
//        [_tnameLabelOne setBackgroundColor:[UIColor cyanColor]];
        [_tnameLabelOne setFont:[UIFont systemFontOfSize:13]];
        [_tnameLabelOne setTextAlignment:NSTextAlignmentCenter];
        _tnameLabelTwo.numberOfLines = 2;
        [_buttonOne addSubview:_tnameLabelOne];
        
        _titleLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*160, RATIO_WIDTH*100, RATIO_HEIGHT*50)];
//        [_titleLabelOne setBackgroundColor:[UIColor blueColor]];
        [_titleLabelOne setFont:[UIFont systemFontOfSize:12]];
        [_titleLabelOne setTextColor:[UIColor lightGrayColor]];
        _titleLabelOne.numberOfLines = 2;
        [_buttonOne addSubview:_titleLabelOne];
        
        _buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonTwo setFrame:CGRectMake(RATIO_WIDTH*123, RATIO_HEIGHT*50, RATIO_WIDTH*110, RATIO_HEIGHT*220)];
//        [_buttonTwo setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_buttonTwo];
        
        _imgsrcTwo = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*10, RATIO_WIDTH*100, RATIO_WIDTH*100)];
//        [_imgsrcTwo setBackgroundColor:[UIColor redColor]];
        _imgsrcTwo.layer.cornerRadius = RATIO_WIDTH*100/2;
        _imgsrcTwo.layer.masksToBounds = YES;
        _imgsrcTwo.layer.borderWidth = 1;
        _imgsrcTwo.layer.borderColor = [[UIColor grayColor]CGColor];
        [_buttonTwo addSubview:_imgsrcTwo];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = CGRectMake(RATIO_WIDTH*36,RATIO_HEIGHT*38,RATIO_WIDTH*30,RATIO_WIDTH*30);
        [_button2 setBackgroundColor:[UIColor blackColor]];
        [_button2 setAlpha:0.8];
        _button2.layer.cornerRadius = RATIO_WIDTH*30/2;
        [self.imgsrcTwo addSubview:_button2];
    
        _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*7, RATIO_HEIGHT*6, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
        [_imageView2 setUserInteractionEnabled:YES];
        [_imageView2 setImage:[UIImage imageNamed:@"播放1.png"]];
        [_button2 addSubview:_imageView2];
        
        _tnameLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*125, RATIO_WIDTH*100, RATIO_HEIGHT*30)];
//        [_tnameLabelTwo setBackgroundColor:[UIColor cyanColor]];
        [_tnameLabelTwo setFont:[UIFont systemFontOfSize:13]];
        [_tnameLabelTwo setTextAlignment:NSTextAlignmentCenter];
        _tnameLabelTwo.numberOfLines = 2;
        [_buttonTwo addSubview:_tnameLabelTwo];
        
        _titleLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*160, RATIO_WIDTH*100, RATIO_HEIGHT*50)];
//        [_titleLabelTwo setBackgroundColor:[UIColor blueColor]];
        [_titleLabelTwo setFont:[UIFont systemFontOfSize:12]];
        [_titleLabelTwo setTextColor:[UIColor lightGrayColor]];
        _titleLabelTwo.numberOfLines = 2;
        [_buttonTwo addSubview:_titleLabelTwo];
        
        _buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonThree setFrame:CGRectMake(RATIO_WIDTH*240, RATIO_HEIGHT*50, RATIO_WIDTH*110, RATIO_HEIGHT*220)];
//        [_buttonThree setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_buttonThree];
        
        _imgsrcThree = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*10, RATIO_WIDTH*100, RATIO_WIDTH*100)];
//        [_imgsrcThree setBackgroundColor:[UIColor redColor]];
        _imgsrcThree.layer.cornerRadius = RATIO_WIDTH*100/2;
        _imgsrcThree.layer.masksToBounds = YES;
        _imgsrcThree.layer.borderWidth = 1;
        _imgsrcThree.layer.borderColor = [[UIColor grayColor]CGColor];
        [_buttonThree addSubview:_imgsrcThree];
        
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.frame = CGRectMake(RATIO_WIDTH*36,RATIO_HEIGHT*38,RATIO_WIDTH*30,RATIO_WIDTH*30);
        [_button3 setBackgroundColor:[UIColor blackColor]];
        [_button3 setAlpha:0.8];
        _button3.layer.cornerRadius = RATIO_WIDTH*30/2;
        [self.imgsrcThree addSubview:_button3];
        
        _imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*7, RATIO_HEIGHT*6, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
        [_imageView3 setUserInteractionEnabled:YES];
        [_imageView3 setImage:[UIImage imageNamed:@"播放1.png"]];
        [_button3 addSubview:_imageView3];
        
        _tnameLabelThree = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*125, RATIO_WIDTH*100, RATIO_HEIGHT*30)];
//        [_tnameLabelThree setBackgroundColor:[UIColor cyanColor]];
        [_tnameLabelThree setFont:[UIFont systemFontOfSize:13]];
        [_tnameLabelThree setTextAlignment:NSTextAlignmentCenter];
        _tnameLabelThree.numberOfLines = 2;
        [_buttonThree addSubview:_tnameLabelThree];
        
        _titleLabelThree = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*160, RATIO_WIDTH*100, RATIO_HEIGHT*50)];
//        [_titleLabelThree setBackgroundColor:[UIColor blueColor]];
        [_titleLabelThree setFont:[UIFont systemFontOfSize:12]];
        [_titleLabelThree setTextColor:[UIColor lightGrayColor]];
        _titleLabelThree.numberOfLines = 2;
        [_buttonThree addSubview:_titleLabelThree];
        
    }
    return self;
}

-(void)Info:(AudiocListModel *)model;
{
    self.cnameLabel.text = model.cname;
    
    AudiotListModel *listModel1 = [model.tlist objectAtIndex:0];
    [self.imgsrcOne sd_setImageWithURL:[NSURL URLWithString:listModel1.imgsrc]placeholderImage:[UIImage imageNamed:@"占112-92"]];
    self.titleLabelOne.text = listModel1.title;
    self.tnameLabelOne.text = listModel1.tname;
    AudiotListModel *listModel2 = [model.tlist objectAtIndex:1];
    [self.imgsrcTwo sd_setImageWithURL:[NSURL URLWithString:listModel2.imgsrc]placeholderImage:[UIImage imageNamed:@"占112-92"]];
    self.titleLabelTwo.text = listModel2.title;
    self.tnameLabelTwo.text = listModel2.tname;
    AudiotListModel *listModel3 = [model.tlist objectAtIndex:2];
    [self.imgsrcThree sd_setImageWithURL:[NSURL URLWithString:listModel3.imgsrc]placeholderImage:[UIImage imageNamed:@"占112-92"]];
    self.titleLabelThree.text = listModel3.title;
    self.tnameLabelThree.text = listModel3.tname;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
