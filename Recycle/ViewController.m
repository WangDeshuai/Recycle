//
//  ViewController.m
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    [self interNetJianCe];
    [self tableBar];
}
-(void)interNetJianCe{
    
   AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                [WINDOW showHUDWithText:@"未识别的网络" Type:ShowPhotoNo Enabled:YES];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                [WINDOW showHUDWithText:@"网络已断开连接" Type:ShowPhotoNo Enabled:YES];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                [WINDOW showHUDWithText:@"2G,3G,4G网络" Type:ShowPhotoYes Enabled:YES];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                [WINDOW showHUDWithText:@"wifi的网络" Type:ShowPhotoYes Enabled:YES];
                break;
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
}


-(void)tableBar
{
    
    UIWindow * widonw =[UIApplication sharedApplication].delegate.window;
    
    UITabBarController * tb =[UITabBarController new];
    widonw.rootViewController=tb;
    
    FirstVC * vc1 =[FirstVC new];
    
    UINavigationController *nav1 =[[UINavigationController alloc]initWithRootViewController:vc1];
    UIImage * image1 = [[UIImage imageNamed:@"s首页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * seimage1=[[UIImage imageNamed:@"首页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image1 selectedImage:seimage1];
    vc1.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    Information_publishVC * vc2 =[Information_publishVC new];
    UINavigationController *nav2 =[[UINavigationController alloc]initWithRootViewController:vc2];
    UIImage * image2 = [[UIImage imageNamed:@"s信息发布"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * seimage2=[[UIImage imageNamed:@"信息发布"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image2 selectedImage:seimage2];

    DiscoverVC * vc3 =[DiscoverVC new];
    UINavigationController *nav3 =[[UINavigationController alloc]initWithRootViewController:vc3];
    UIImage * image3 = [[UIImage imageNamed:@"发现"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * seimage3=[[UIImage imageNamed:@"s发现"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image3 selectedImage:seimage3];
   
    MYViewController * vc4 =[MYViewController new];
    UINavigationController *nav4 =[[UINavigationController alloc]initWithRootViewController:vc4];
    UIImage * image4 = [[UIImage imageNamed:@"我"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * seimage4=[[UIImage imageNamed:@"s我"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image4 selectedImage:seimage4];
    vc2.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    vc3.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    vc4.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    UITabBarController * tController = [[UITabBarController alloc]init];
    tController.viewControllers=@[nav1,nav2,nav3,nav4];
    widonw.rootViewController=tController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
