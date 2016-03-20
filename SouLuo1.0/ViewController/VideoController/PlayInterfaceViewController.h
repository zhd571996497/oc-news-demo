//
//  PlayInterfaceViewController.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseViewController.h"
#import "AudiotListModel.h"

@interface PlayInterfaceViewController : BaseViewController
@property (nonatomic ,retain)NSString *mp3url;
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,retain)AudiotListModel * model;
@end
