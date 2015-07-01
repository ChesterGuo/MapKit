//
//  ViewController.m
//  MapKit
//
//  Created by tarena on 15/6/19.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRAnnotation.h"
@import MapKit;
@import CoreLocation;
@interface ViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
    [self addAnnotation];
}

- (void)addAnnotation
{
    TRAnnotation *annotation = [[TRAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(30.62, 104.03);
    annotation.title = @"Tarena";
    annotation.subtitle = @"SB";
    
    [_mapView addAnnotation:annotation];
}
- (void)createUI
{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    _locationManager = [[CLLocationManager alloc]init];
    _geocoder = [[CLGeocoder alloc]init];
    if (![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    _mapView.userTrackingMode =MKUserTrackingModeFollow ;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%@",userLocation);
    CLLocation *location = userLocation.location;
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *pm = [placemarks firstObject];
        NSLog(@"%@",pm.addressDictionary[@"City"]);
    }];
    MKCoordinateSpan span = MKCoordinateSpanMake(1, 0.5);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
