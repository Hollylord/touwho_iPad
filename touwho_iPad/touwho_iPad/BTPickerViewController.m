//
//  BTPickerViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "BTPickerViewController.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2


@interface BTPickerViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation BTPickerViewController
{
    UIPickerView *picker;
    NSInteger componentsOfPicker;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}
- (instancetype)initWithPlist:(NSString *)plistFile numberOfComponents:(NSInteger)components{
    self = [super initWithNibName:@"BTPickerViewController" bundle:nil];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:plistFile ofType:@"plist"];
        areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        componentsOfPicker = components;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获得所有0、1、2等key
    NSArray *components = [areaDic allKeys];
    //把第一层key排序
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    //获得省 数组
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    
    
    //把0转换成 "0"
    NSString *index = [sortedArray objectAtIndex:0];
    //取出省里面第一个对象 "北京市"
    NSString *selected = [province objectAtIndex:0];
    //取出第一个city这个字典  "北京市"这个字典
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    //获得city所有key
    NSArray *cityArray = [dic allKeys];
    if (cityArray.count != 0) {
        NSMutableArray *cityTmp = [NSMutableArray array];
        for (int i = 0; i < cityArray.count; i ++) {
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:i]]];

            [cityTmp addObject:[[cityDic allKeys] firstObject]];
        }
        
        //城市数组
        city = [[NSArray alloc] initWithArray: cityTmp];
        
        if (city.count != 0 ) {
            NSString *selectedCity = [city objectAtIndex: 0];

            //区数组
            district = [[NSArray alloc] initWithArray:[[dic objectForKey:@"0"] objectForKey:selectedCity]];
        }
        
    }
    
    
    picker = self.pickerView;
    picker.delegate = self;
    picker.dataSource = self;
    
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    selectedProvince = [province objectAtIndex: 0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return componentsOfPicker;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        
        city = [[NSArray alloc] initWithArray: array];

        
        if (sortedArray.count != 0) {
            NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
            [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
            [picker reloadComponent: CITY_COMPONENT];
            
            if (componentsOfPicker > DISTRICT_COMPONENT) {
                [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
                [picker reloadComponent: DISTRICT_COMPONENT];
            }
            
            
            
        }
        

    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        if (cityKeyArray.count != 0) {
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
            
            if (componentsOfPicker > DISTRICT_COMPONENT) {
                [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
                [picker reloadComponent: DISTRICT_COMPONENT];
            }
            
        }
        
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)] ;
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)] ;
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}



#pragma mark - 按钮点击
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)confirm:(UIBarButtonItem *)sender {
    NSInteger components = picker.numberOfComponents;
    
    NSInteger row = [picker selectedRowInComponent:0];
    NSString *p = province[row];
    
    NSString *p2;
    NSString *p3;
    NSString *title;
    
    title = [NSString stringWithFormat:@"%@",p];
    
    if (components > 1) {
        NSInteger row2 = [picker selectedRowInComponent:1];
        p2 = city[row2];
        title = [NSString stringWithFormat:@"%@,%@",p,p2];
    }
    
    if (components > 2) {
        NSInteger row3 = [picker selectedRowInComponent:2];
        p3 = district[row3];
        title = [NSString stringWithFormat:@"%@,%@,%@",p,p2,p3];
    }
    
    
    if (self.regionPickerBlock) {
        self.regionPickerBlock(title);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
