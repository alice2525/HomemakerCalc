//
//  ViewController.m
//  HomemakerCalc
//
//  Created by 森川 明 on 2014/04/12.
//  Copyright (c) 2014年 森川 明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//使う物の準備
int Cash;
const float Tax = 1.08f;
int taxinPriceNum;
int Mony;
int BuyCount = 0;
NSArray *BuyArray;
NSMutableArray *BuyLogArray;
NSString *inputCashText;
NSString *inputPriceText;
NSString *LogText;
NSString *TotalLog;
NSString *DateString;
NSString *BuyString;
NSString *CountString;
UIAlertView *alert;
UIAlertView *cantBuyAlert;
UIAlertView *coutionAlert;
UIAlertView *logAleart;
NSUserDefaults *Save;


//アプリが起動された直後に呼ばれるところ
- (void)viewDidLoad
{
    //キーボードを隠す処理の準備
    [super viewDidLoad];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //テキスト入力フォーム付きアラート
    //初期化と設定
    alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"購入する商品名を入力して下さい。"
                                      delegate:self cancelButtonTitle:@"やっぱりやめる。" otherButtonTitles:@"購入！", nil];
    
    //アラートダイアログにフォーム設定
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    
    cantBuyAlert =
    [[UIAlertView alloc] initWithTitle:@"買えません。" message:@"お金が足らんよ。"
                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    coutionAlert =[[UIAlertView alloc] initWithTitle:@"注意" message:@"計算ボタンを押して下さい。"
                                            delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    //購入力Array準備
    BuyArray = [NSArray arrayWithObjects:nil];
    BuyLogArray = [NSMutableArray array];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"yyyy/MM/dd";
    DateString = [df stringFromDate:[NSDate date]];
    
    //アプリケーションを終了してもデータを保持する
    Save = [NSUserDefaults standardUserDefaults];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearText{
    //フォームのクリア
    _PriceText.text = @"";
    _TaxinPrice.text = @"";
    _RemainCashLabel.text = @"";
    _LogTextLabel.text = @"";
    
    taxinPriceNum = 0;
}

//キーボードを隠す処理
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

- (IBAction)CalicrationButton:(id)sender {
    //ボタンを押されたら計算
    
    //予算項目
    NSMutableString *budgetText = [_CashText.text mutableCopy];
    Cash = [budgetText intValue];
    
    //商品価格項目
    NSMutableString *inputPriceText = [_PriceText.text mutableCopy];
    taxinPriceNum = [inputPriceText intValue] * Tax;
    _TaxinPrice.text = [NSString stringWithFormat:@"%d円", taxinPriceNum];
    
    
    //計算結果項目
    Mony = Cash - taxinPriceNum;
    _RemainCashLabel.text = [NSString stringWithFormat:@"%d円", Mony];
    //予算金額より商品金額が高い場合、残金ラベルを赤文字にする
    if(Mony <= 0){
        _RemainCashLabel.textColor = [UIColor redColor];
    }else{
        _RemainCashLabel.textColor = [UIColor blackColor];
    }
}

//購入ボタンの処理
- (IBAction)BuyButton:(id)sender {
    //①購入ボタンが押される前に計算処理を行ったか
    if(taxinPriceNum == 0){
        [coutionAlert show];
    }else{
        //②予算金額が商品購入価格を上回っていないか
        if(Mony <= 0)
        {
            [cantBuyAlert show];
            _LogTextLabel.text = @"買えませんでした。";
        }else{
            //③購入確定
            [alert show];
        }
    }
}

- (IBAction)DontBuyButton:(id)sender {
    //商品購入を行わない場合はフォームをクリア
    [self clearText];
}


//購入ボタンを押した後の処理
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //購入ログ表示
        LogText = [[[alert textFieldAtIndex:0] text] mutableCopy];
        _LogTextLabel.text = [NSString stringWithFormat:@"%@ を購入しました",LogText];
        TotalLog = [NSString stringWithFormat:@"%@\n%@を購入しました。\n商品金額:%d円\n残金:%d円",DateString,LogText,taxinPriceNum,Mony];
        //ログをArrayで残す
        [BuyLogArray insertObject:TotalLog atIndex:BuyCount];
        NSLog(@"%@",BuyLogArray[BuyCount]);
        
        //フォームのクリア
        [self clearText];
        
        //所持金計算
        Cash = Mony;
        _CashText.text= [NSString stringWithFormat:@"%d円", Mony];
        BuyCount =  BuyCount+1;
        
        //キーボードを隠す
        [self closeSoftKeyboard];
    }else{
        //キーボードを隠す
        [self closeSoftKeyboard];
    }
}

//購入履歴の処理
- (IBAction)ToListButton:(id)sender {
    //ログから購入履歴データを取得し、アラートで表示
    logAleart =[[UIAlertView alloc] initWithTitle:@"購入履歴" message:TotalLog delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [logAleart show];
}

@end
