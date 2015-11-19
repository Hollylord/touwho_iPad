//
//  huodongViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//
/// 系统自带的地图也会有偏差

#import "huodongViewController.h"
#import <AMap2DMap/MAMapKit/MAMapKit.h>
#import "customAnnotationView.h"
#import "popUpView.h"
#import <AMapSearchKit/AMapSearchKit.h>


#define MAPAPIKEY @"a50e4a2d762f64b6a67ff794fc76c67e";

@interface huodongViewController () <MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_map;
    MAPointAnnotation *_annotation;
    AMapSearchAPI *_searchAPI;

}
@end

@implementation huodongViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //地图设置
    [MAMapServices sharedServices].apiKey = MAPAPIKEY;
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _map = mapView;
    _map.delegate = self;
    
    MACoordinateRegion customRegion = MACoordinateRegionMake(_map.centerCoordinate, MACoordinateSpanMake(0.1, 0.1));
    [_map setRegion:customRegion animated:YES];
    _map.showsUserLocation = YES;
    [_map setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:mapView];
    
    
    //搜索设置
    [AMapSearchServices sharedServices].apiKey = MAPAPIKEY;
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
 
    request.address = self.model.mAddress;
    NSLog(@"%@",self.model.mAddress);
    [_searchAPI AMapGeocodeSearch:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TalkingData trackPageBegin:@"地图页"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"地图页"];
}

#pragma mark -  搜索回调
//搜地址回调
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
    AMapGeocode *geoCode = response.geocodes[0];
    
    //通过AMapGeocodeSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strGeocodes = @"";
    for (AMapTip *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
    NSLog(@"Geocode: %@", result);
    
    //配置annotation
    _annotation = [[MAPointAnnotation alloc] init];
    _annotation.coordinate = CLLocationCoordinate2DMake(geoCode.location.latitude, geoCode.location.longitude);
    _annotation.title = @"活动地点";
    _annotation.subtitle = self.model.mAddress;
    [_map addAnnotation:_annotation];
    
}

//搜地理经纬度回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    _map.userLocation.subtitle = response.regeocode.formattedAddress;
    NSLog(@"%@",response.regeocode.formattedAddress);
    
}

#pragma mark - annotationView
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reusedID = @"annotation";
        customAnnotationView *annotationView = (customAnnotationView *)[_map dequeueReusableAnnotationViewWithIdentifier:reusedID];
        if (annotationView == nil) {
            annotationView = [[customAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusedID];
            
        }
        annotationView.image = [UIImage imageNamed:@"zuobiao"];
       
        
        return annotationView;
    }
    else {
        
    }
    return nil;
    
}

// 当添加annotationview时调用，不要用didselect方法来判断
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    customAnnotationView *annotationView = views[0];
    annotationView.selected = YES;
}



#pragma mark - 用户位置更新调用
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (_map.userLocation.subtitle != nil) {
        return ;
    }
    //搜索地理经纬度
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    
    //获得用户坐标
    AMapGeoPoint *userLocation1 = [[AMapGeoPoint alloc] init];
    userLocation1.longitude = userLocation.location.coordinate.longitude;
    userLocation1.latitude = userLocation.location.coordinate.latitude;
    
    if (userLocation1 != nil) {
        request.location = userLocation1;
        [_searchAPI AMapReGoecodeSearch:request];

        
    }
    
    
}

#pragma mark - 分享
- (void)share{
    //用这个方法设置url跳转的网页，若是用自定义分享界面则设置全部url不行
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:@"http://www.baidu.com"];
    //设置分享的 title
    [UMSocialData defaultData].title = @"回音必项目分享";
    
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self.splitViewController
                                         appKey:@"5602081a67e58ec377001b17"
                                      shareText:@""
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina]
                                       delegate:nil];
    
    
    
}

@end
