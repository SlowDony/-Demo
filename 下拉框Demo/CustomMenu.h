//
//  CustomMenu.h
//  下拉框Demo
//
//  Created by tcrj on 15/11/19.
//  Copyright © 2015年 Dony. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomMenuDelegate <NSObject>

- (void)customMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

typedef void(^Dismiss) (void);

@interface CustomMenu : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)id<CustomMenuDelegate> delegate;

@property (nonatomic,strong)NSArray *arrData;
@property (nonatomic,strong)NSArray *arrImageName;

@property (nonatomic,copy)Dismiss dismiss;

-(instancetype)initWithDataArr:(NSArray *)dataArr orgin:(CGPoint)orgin width:(CGFloat)width rowHeight:(CGFloat)rowHeight;
-(void)dismissWithCompletion:(void (^)(CustomMenu * object))completion;



@end







































