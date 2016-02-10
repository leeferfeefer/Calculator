//
//  calculatorVC.h
//  Calculator
//
//  Created by Lee Fincher on 2/7/16.
//  Copyright © 2016 Dan Fincher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calculatorVC : UIViewController <UITextViewDelegate>



//---------------------------------------------------------
//Text View Properties
//---------------------------------------------------------
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;

//---------------------------------------------------------
//Button Properties
//---------------------------------------------------------
//Operations
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *subtractButton;
@property (strong, nonatomic) IBOutlet UIButton *multiplyButton;
@property (strong, nonatomic) IBOutlet UIButton *divideButton;
@property (strong, nonatomic) IBOutlet UIButton *equalsButton;
//Numbers
@property (strong, nonatomic) IBOutlet UIButton *zeroButton;
@property (strong, nonatomic) IBOutlet UIButton *oneButton;
@property (strong, nonatomic) IBOutlet UIButton *twoButton;
@property (strong, nonatomic) IBOutlet UIButton *threeButton;
@property (strong, nonatomic) IBOutlet UIButton *fourButton;
@property (strong, nonatomic) IBOutlet UIButton *fiveButton;
@property (strong, nonatomic) IBOutlet UIButton *sixButton;
@property (strong, nonatomic) IBOutlet UIButton *sevenButton;
@property (strong, nonatomic) IBOutlet UIButton *eightButton;
@property (strong, nonatomic) IBOutlet UIButton *nineButton;
//Other
@property (strong, nonatomic) IBOutlet UIButton *clearButton;


//---------------------------------------------------------
//Button Methods
//---------------------------------------------------------
//Operations
- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)subtractButtonPressed:(UIButton *)sender;
- (IBAction)multiplyButtonPressed:(UIButton *)sender;
- (IBAction)divideButtonPressed:(UIButton *)sender;
- (IBAction)equalsButtonPressed:(UIButton *)sender;
//Numbers
- (IBAction)zeroButtonPressed:(UIButton *)sender;
- (IBAction)oneButtonPressed:(UIButton *)sender;
- (IBAction)twoButtonPressed:(UIButton *)sender;
- (IBAction)threeButtonPressed:(UIButton *)sender;
- (IBAction)fourButtonPressed:(UIButton *)sender;
- (IBAction)fiveButtonPressed:(UIButton *)sender;
- (IBAction)sixButtonPressed:(UIButton *)sender;
- (IBAction)sevenButtonPressed:(UIButton *)sender;
- (IBAction)eightButtonPressed:(UIButton *)sender;
- (IBAction)nineButtonPressed:(UIButton *)sender;
//Other
- (IBAction)clearButtonPressed:(UIButton *)sender;




@end
