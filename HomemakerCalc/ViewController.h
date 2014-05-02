//
//  ViewController.h
//  HomemakerCalc
//
//  Created by 森川 明 on 2014/04/12.
//  Copyright (c) 2014年 森川 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *CalcButton;
@property (weak, nonatomic) IBOutlet UITextField *CashText;
@property (weak, nonatomic) IBOutlet UITextField *PriceText;
@property (weak, nonatomic) IBOutlet UILabel *BugetLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *TaxinPrice;
@property (weak, nonatomic) IBOutlet UILabel *MonyLabel;
@property (weak, nonatomic) IBOutlet UILabel *RemainCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogTextLabel;


- (IBAction)CalicrationButton:(id)sender;
- (IBAction)BuyButton:(id)sender;
- (IBAction)DontBuyButton:(id)sender;
- (IBAction)ToListButton:(id)sender;

@end
