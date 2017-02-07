//
//  ViewController.m
//  下拉框Demo
//
//  Created by tcrj on 15/11/19.
//  Copyright © 2015年 Dony. All rights reserved.
//

#import "ViewController.h"
#import "CustomMenu.h"

@interface ViewController () <CustomMenuDelegate>
@property (nonatomic ,strong)CustomMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   self.navigationController.navigationBar.translucent=NO;
//    //self.navigationItem.title =@"哈哈";
//    //self.view.backgroundColor =[UIColor redColor];
    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc]initWithTitle:@"哈哈" style:UIBarButtonItemStyleDone target:self action:@selector(showMenu:)];
//    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"schoolListItem"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
//    self.navigationItem.leftBarButtonItem=leftItem;
    //self.navigationController.navigationBar.translucent = NO;
    //UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"schoolListItem.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}
#pragma mark -customMenu的delegate
-(void)customMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了:%ld",(long)indexPath.row);
}

-(void)showMenu:(UIBarButtonItem *)barButtonItem{
    __weak __typeof(self) weakSelf =self;
    
    if (!self.menu){
        self.menu=[[CustomMenu alloc]initWithDataArr:@[@"哈哈",@"呵呵",@"哦哦",@"意义"] orgin:CGPointMake(100, 0) width:200 rowHeight:44];
        _menu.delegate =self;
         _menu.arrImageName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png"];
        
        _menu.dismiss=^(){
            weakSelf.menu=nil;
        };
        
        [self.view addSubview:_menu];
    }
    else {
        [self.menu dismissWithCompletion:^(CustomMenu *object) {
            weakSelf.menu=nil;
            
        }];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"哈哈");
     __weak __typeof(self) weakSelf = self;
    if (!self.menu){
        self.menu=[[CustomMenu alloc]initWithDataArr:@[@"哈哈",@"呵呵",@"哦哦",@"意义"] orgin:CGPointMake(100, 0) width:125 rowHeight:44];
        _menu.delegate =self;
        _menu.dismiss =^(){
            weakSelf.menu =nil;
        };
         _menu.arrImageName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png"];
        [self.view addSubview:_menu];

    }else {
            [self.menu dismissWithCompletion:^(CustomMenu *object) {
                weakSelf.menu =nil;
            }];
    }
}





@end


































