//
//  ZHQBasicTableViewController.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHQBasicTableViewController : UITableViewController

@property (nonatomic, copy) NSString *list_id;
@property (nonatomic, strong) UIViewController *parentController;
@end
