//
//  ViewController.m
//  CardLayoutSample
//
//  Created by Sanchit Kumar Singh on 6/30/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "ViewController.h"
#import "CardCollectionView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong,nonatomic) CardCollectionView *cardCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSArray *imageArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"47916_1600x1200-wallpaper-cb1355864269.jpg"],[UIImage imageNamed:@"1174862_10154539898531416_508279385867067007_n.png"],[UIImage imageNamed:@"6190387_1600x1200.jpg"],[UIImage imageNamed:@"6648650_1600x1200.jpg"],[UIImage imageNamed:@"6701983_1600x1200.jpg"],[UIImage imageNamed:@"13254022_10154715210646416_414817459037305087_n.jpg"],[UIImage imageNamed:@"13263917_10154706246946416_1025325315483057777_n.png"], nil];
    self.cardCollectionView = [[CardCollectionView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 170) data:imageArray];
    self.cardCollectionView.layout.sliderValue=self.slider.value;
    [self.view addSubview:self.cardCollectionView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (IBAction)slider:(id)sender {
    [self.cardCollectionView setFrame:CGRectMake(0, 250-self.slider.value, self.view.frame.size.width, 170+self.slider.value)];
    [self.cardCollectionView.layout invalidateLayout];
    self.cardCollectionView.layout.sliderValue=self.slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
