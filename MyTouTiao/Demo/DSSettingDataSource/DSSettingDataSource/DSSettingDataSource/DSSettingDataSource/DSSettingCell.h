//
//  DSSettingCell.h
//  DSSettingDataSource
//
//  Created by HelloAda on 2018/4/24.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSSettingItem.h"
#import "DSSettingCellProtocol.h"
@interface DSSettingCell : UITableViewCell<DSSettingCellProtocol>

//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//设置数据
- (void)refreshData:(DSSettingItem *)item tableView:(UITableView *)tableView;

@end

