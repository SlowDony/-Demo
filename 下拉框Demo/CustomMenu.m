//
//  CustomMenu.m
//  下拉框Demo
//
//  Created by tcrj on 15/11/19.
//  Copyright © 2015年 Dony. All rights reserved.
//

#import "CustomMenu.h"

#define TopToView 10.0f
#define LeftToView 10.0f
#define CellLineEdgeInsets UIEdgeInsetsMake(0,10,0,10)

#define customMenuId @"customMenu"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CustomMenu()

@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGFloat rowHeight;

@end
@implementation CustomMenu

-(instancetype)initWithDataArr:(NSArray *)dataArr orgin:(CGPoint)orgin width:(CGFloat)width rowHeight:(CGFloat)rowHeight{
    self =[super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        if (rowHeight<=0) {
            rowHeight=44;
        }
        self.backgroundColor =[UIColor clearColor];
        self.origin =orgin;
        self.rowHeight =rowHeight;
        self.arrData =[dataArr copy];
        self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(LeftToView, orgin.y+TopToView, width, rowHeight*dataArr.count) style:UITableViewStylePlain];
        self.tableView.delegate =self;
        self.tableView.dataSource=self;
        [self addSubview:self.tableView];
        self.tableView.backgroundColor =[UIColor colorWithWhite:0.2 alpha:1];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        //self.tableView.layer.cornerRadius=2;
        //self.tableView.bounces =NO;
        //self.tableView.separatorColor =[UIColor colorWithWhite:0.3 alpha:1];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:customMenuId];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    
    }
    return self;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}
-(void)dismissWithCompletion:(void (^)(CustomMenu *))completion{
    NSLog(@"compleation:%@",completion);
    __weak __typeof(self) weakSelf =self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha=0;
       //self.tableView.frame = CGRectMake(self.origin.x + LeftToView, self.origin.y + TopToView, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
       
        if(completion){
            completion(weakSelf);
        }
        if(weakSelf.dismiss){
            weakSelf.dismiss();
        }
    }];
}


#pragma mark -tableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrData.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"rowHeight:%f",self.rowHeight);
    return self.rowHeight;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:customMenuId];
    if (!cell) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMenuId];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor =[UIColor whiteColor];
    cell.textLabel.font =[UIFont systemFontOfSize:15];
    cell.textLabel.text =self.arrData[indexPath.row];
    if (self.arrImageName.count >indexPath.row) {
        cell.imageView.image =[UIImage imageNamed:self.arrImageName[indexPath.row]];
    }
    
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor=[UIColor blackColor];
    
    
    return cell;
}

#pragma mark -tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(customMenu:didSelectRowAtIndexPath:)]) {
        
        [self.delegate customMenu:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithCompletion:nil];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

}

- (void)drawRect:(CGRect)rect

{
    
    
    //    [colors[serie] setFill];
    
    //拿到当前视图准备好的画板
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,
                         LeftToView * 2.5, TopToView * 0.5);//设置起点
    
    CGContextAddLineToPoint(context,
                            LeftToView * 2, TopToView);
    
    CGContextAddLineToPoint(context,
                            LeftToView * 3, TopToView);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [self.tableView.backgroundColor setFill]; //设置填充色
    
    [self.tableView.backgroundColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
}




































/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
