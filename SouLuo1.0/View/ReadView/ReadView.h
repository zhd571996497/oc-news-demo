//
//  ReadView.h
//  SouLuo1.0
//
//  Created by ls on 15/9/10.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseView.h"

@interface ReadView : BaseView

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * modelArray;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)BOOL refresh;

@end
