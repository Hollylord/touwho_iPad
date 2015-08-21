//
//  huodongViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "huodongViewController.h"
#import <AMap2DMap/MAMapKit/MAMapKit.h>
#import <AMapSearch/AMapSearchKit/AMapSearchAPI.h>
#import "customAnnotationView.h"
#import "popUpView.h"

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
    _searchAPI = [[AMapSearchAPI alloc] initWithSearchKey:@"a50e4a2d762f64b6a67ff794fc76c67e" Delegate:self];
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    request.city = @[@"深圳"];
    request.address = @"五和";
    [_searchAPI AMapGeocodeSearch:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -  搜索回调
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    AMapGeocode *geoCode = response.geocodes[0];
    
    //配置annotation
    _annotation = [[MAPointAnnotation alloc] init];
    _annotation.coordinate = CLLocationCoordinate2DMake(geoCode.location.latitude, geoCode.location.longitude);
    _annotation.title = @"工作地点";
    _annotation.subtitle = @"卫东龙商务大厦";
    [_map addAnnotation:_annotation];
    
}
//搜用户位置
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
        annotationView.image = [UIImage imageNamed:@"touhu"];
       
        
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
    //搜索
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

@end
