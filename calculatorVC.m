//
//  calculatorVC.m
//  Calculator
//
//  Created by Lee Fincher on 2/7/16.
//  Copyright © 2016 Dan Fincher. All rights reserved.
//

#import "calculatorVC.h"


#define kBorderSize 2
#define kCornerRadius 10

@interface calculatorVC () {
    
    //States
    BOOL adding;
    BOOL subtracting;
    BOOL multiplying;
    BOOL dividing;
    
    BOOL isDecimal;
    
    
    UIButton *previousOperationButton;
    double numberPressedDouble;
    int exponent;
    
    NSString *feedback;
    double total;
}

@end

@implementation calculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Clear content
    [self clear];
    
    //Set borders
    [self addBorders];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - Button Methods
#pragma mark - Operations

- (IBAction)addButtonPressed:(UIButton *)sender {
    if ([self isNumberBeforeOperation]) {
        if (total == 0) {
            total = numberPressedDouble;
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        
        NSLog(@"Add Pressed");
        [self changePreviousOperation];
        adding = !adding;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        
        [self updateFeedbackWithNumber:0 andOperation:@"+"];

    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)subtractButtonPressed:(UIButton *)sender {
    if ([self isNumberBeforeOperation]) {
        if (total == 0) {
            total = numberPressedDouble;
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        
        NSLog(@"Subtract Pressed");
        [self changePreviousOperation];
        subtracting = !subtracting;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        
        [self updateFeedbackWithNumber:0 andOperation:@"-"];
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)multiplyButtonPressed:(UIButton *)sender {
    if ([self isNumberBeforeOperation]) {
        if (total == 0) {
            total = numberPressedDouble;
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        
        NSLog(@"Multiply Pressed");
        [self changePreviousOperation];
        multiplying = !multiplying;

        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        
        [self updateFeedbackWithNumber:0 andOperation:@"x"];
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)divideButtonPressed:(UIButton *)sender {
    if ([self isNumberBeforeOperation]) {
        if (total == 0) {
            total = numberPressedDouble;
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        
        NSLog(@"Divide Pressed");
        [self changePreviousOperation];
        dividing = !dividing;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        
        [self updateFeedbackWithNumber:0 andOperation:@"/"];
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)equalsButtonPressed:(UIButton *)sender {
    NSLog(@"Equals Pressed");
    [self calculate];
}



#pragma mark - Numbers

- (IBAction)zeroButtonPressed:(UIButton *)sender {
    NSLog(@"Zero Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)oneButtonPressed:(UIButton *)sender {
    NSLog(@"One Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)twoButtonPressed:(UIButton *)sender {
    NSLog(@"Two Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)threeButtonPressed:(UIButton *)sender {
    NSLog(@"Three Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)fourButtonPressed:(UIButton *)sender {
    NSLog(@"Four Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)fiveButtonPressed:(UIButton *)sender {
    NSLog(@"Five Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)sixButtonPressed:(UIButton *)sender {
    NSLog(@"Six Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)sevenButtonPressed:(UIButton *)sender {
    NSLog(@"Seven Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)eightButtonPressed:(UIButton *)sender {
    NSLog(@"Eight Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)nineButtonPressed:(UIButton *)sender {
    NSLog(@"Nine Pressed");
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}


#pragma mark - Other

- (IBAction)clearButtonPressed:(UIButton *)sender {
    [self clear];
}
- (IBAction)backspaceButtonPressed:(UIButton *)sender {
}
- (IBAction)decimalButtonPressed:(UIButton *)sender {
    NSLog(@"total is %f", total);
    NSLog(@"number pressed double is %f", numberPressedDouble);
    if (!isDecimal) {
        [self updateFeedbackWithNumber:@"." andOperation:nil];
        isDecimal = YES;
    }
}




#pragma mark - Helper Methods

-(void)updateResult{
    self.resultTextView.text = [NSString stringWithFormat:@"%f", total];
}
-(void)updateFeedbackWithNumber:(NSString *)number andOperation:(NSString *)operation {
    if (!operation) {
        if ([feedback isEqualToString:@""]) {
            feedback = [NSString stringWithFormat:@"%@", number];
        } else {
            feedback = [NSString stringWithFormat: @"%@%@", feedback, number];
        }
    } else {
        if (multiplying || dividing) {
            [self addParenthesesWithOperation:operation];
        } else {
            feedback = [NSString stringWithFormat: @" %@ %@ ", feedback, operation];
        }
    }
    self.feedbackTextView.text = feedback;
}
-(void)addBorders{
    self.resultTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.resultTextView.layer.borderWidth = kBorderSize;
    self.resultTextView.layer.cornerRadius = kCornerRadius;
    self.resultTextView.layer.masksToBounds = YES;
    self.feedbackTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.feedbackTextView.layer.borderWidth = kBorderSize;
    self.feedbackTextView.layer.cornerRadius = kCornerRadius;
    self.feedbackTextView.layer.masksToBounds = YES;
    self.clearButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.clearButton.layer.borderWidth = kBorderSize;
    self.clearButton.layer.cornerRadius = kCornerRadius;
    self.clearButton.layer.masksToBounds = YES;
    self.backspaceButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.backspaceButton.layer.borderWidth = kBorderSize;
    self.backspaceButton.layer.cornerRadius = kCornerRadius;
    self.backspaceButton.layer.masksToBounds = YES;
    self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.addButton.layer.borderWidth = kBorderSize;
    self.addButton.layer.cornerRadius = kCornerRadius;
    self.addButton.layer.masksToBounds = YES;
    self.subtractButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.subtractButton.layer.borderWidth = kBorderSize;
    self.subtractButton.layer.cornerRadius = kCornerRadius;
    self.subtractButton.layer.masksToBounds = YES;
    self.multiplyButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.multiplyButton.layer.borderWidth = kBorderSize;
    self.multiplyButton.layer.cornerRadius = kCornerRadius;
    self.multiplyButton.layer.masksToBounds = YES;
    self.divideButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.divideButton.layer.borderWidth = kBorderSize;
    self.divideButton.layer.cornerRadius = kCornerRadius;
    self.divideButton.layer.masksToBounds = YES;
    self.equalsButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.equalsButton.layer.borderWidth = kBorderSize;
    self.equalsButton.layer.cornerRadius = kCornerRadius;
    self.equalsButton.layer.masksToBounds = YES;
    self.decimalButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.decimalButton.layer.borderWidth = kBorderSize;
    self.decimalButton.layer.cornerRadius = kCornerRadius;
    self.decimalButton.layer.masksToBounds = YES;
    
    self.zeroButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.zeroButton.layer.borderWidth = kBorderSize;
    self.zeroButton.layer.cornerRadius = kCornerRadius;
    self.zeroButton.layer.masksToBounds = YES;
    self.oneButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.oneButton.layer.borderWidth = kBorderSize;
    self.oneButton.layer.cornerRadius = kCornerRadius;
    self.oneButton.layer.masksToBounds = YES;
    self.twoButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.twoButton.layer.borderWidth = kBorderSize;
    self.twoButton.layer.cornerRadius = kCornerRadius;
    self.twoButton.layer.masksToBounds = YES;
    self.threeButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.threeButton.layer.borderWidth = kBorderSize;
    self.threeButton.layer.cornerRadius = kCornerRadius;
    self.threeButton.layer.masksToBounds = YES;
    self.fourButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.fourButton.layer.borderWidth = kBorderSize;
    self.fourButton.layer.cornerRadius = kCornerRadius;
    self.fourButton.layer.masksToBounds = YES;
    self.fiveButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.fiveButton.layer.borderWidth = kBorderSize;
    self.fiveButton.layer.cornerRadius = kCornerRadius;
    self.fiveButton.layer.masksToBounds = YES;
    self.sixButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.sixButton.layer.borderWidth = kBorderSize;
    self.sixButton.layer.cornerRadius = kCornerRadius;
    self.sixButton.layer.masksToBounds = YES;
    self.sevenButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.sevenButton.layer.borderWidth = kBorderSize;
    self.sevenButton.layer.cornerRadius = kCornerRadius;
    self.sevenButton.layer.masksToBounds = YES;
    self.eightButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.eightButton.layer.borderWidth = kBorderSize;
    self.eightButton.layer.cornerRadius = kCornerRadius;
    self.eightButton.layer.masksToBounds = YES;
    self.nineButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.nineButton.layer.borderWidth = kBorderSize;
    self.nineButton.layer.cornerRadius = kCornerRadius;
    self.nineButton.layer.masksToBounds = YES;
}
-(void)calculate {
    NSLog(@"total before operation is %f", total);
    if (adding) {
        total = [self add:total to:numberPressedDouble];
    } else if (subtracting) {
        total = [self subtract:total from:numberPressedDouble];
    } else if (multiplying) {
        total = [self multiply:total by:numberPressedDouble];
        feedback = [NSString stringWithFormat:@"%@)", feedback];
        self.feedbackTextView.text = feedback;
    } else if (dividing) {
        total = [self divide:total by:numberPressedDouble];
        feedback = [NSString stringWithFormat:@"%@)", feedback];
        self.feedbackTextView.text = feedback;
    } else {
        total = numberPressedDouble;
    }
    NSLog(@"the numberpresseddouble is %f", numberPressedDouble);
    NSLog(@"total after operation is %f", total);
    isDecimal = NO;
    exponent = 0;
    numberPressedDouble = 0;
    [self updateResult];
    [self changePreviousOperation];
}
-(void)clear{
    isDecimal = NO;
    total = 0.0;
    exponent = 0;
    numberPressedDouble = 0.0;
    feedback = @"";
    self.feedbackTextView.text = @"";
    self.resultTextView.text = [NSString stringWithFormat:@"%f", total];
    
    [self changePreviousOperation];
}
-(void)checkForMultiDigitWithNumber:(double)buttonNumber{
    if (!isDecimal) {
        if (numberPressedDouble == 0.0) {
            numberPressedDouble = buttonNumber;
        } else {
            numberPressedDouble = numberPressedDouble*10 + buttonNumber;
        }
    } else {
        if (exponent == 0) {
            numberPressedDouble = numberPressedDouble + buttonNumber/10;
            exponent--;
        } else {
            exponent--;
            //take the button number and move over decimal places to the power of exponent
            numberPressedDouble = numberPressedDouble + buttonNumber*pow(10, exponent);
        }
    }
    
    NSLog(@"the number pressed double is %f", numberPressedDouble);
}
-(void)addParenthesesWithOperation:(NSString *)operation{
    feedback = [NSString stringWithFormat: @" (%@ %@ ", feedback, operation];
}
-(BOOL)isNumberBeforeOperation{
    return ![self.feedbackTextView.text isEqualToString:@""];
}
-(void)showErrorAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Whoops" message:@"You must enter a number before any operation." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - Operation State Methods

-(void)changeOperationStateOf:(UIButton *)sender {
    if (previousOperationButton) {
        [previousOperationButton.layer setBorderColor:[UIColor blackColor].CGColor];
    }
    previousOperationButton = sender;
    [sender.layer setBorderColor:[UIColor redColor].CGColor];
}
-(void)changePreviousOperation{
    if (adding) {
        adding = !adding;
        self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (subtracting) {
        subtracting = !subtracting;
        self.subtractButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (multiplying) {
        multiplying = !multiplying;
        self.multiplyButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (dividing) {
        dividing = !dividing;
        self.divideButton.layer.borderColor = [UIColor blackColor].CGColor;
    }
}










#pragma mark - Operations

#pragma mark - Addition

-(double)add:(double)number1 to:(double)number2{
    return number1 + number2;
}


#pragma mark - Subtraction

-(double)subtract:(double)number1 from:(double)number2{
    return number1 - number2;
}


#pragma mark - Multiplication

-(double)multiply:(double)number1 by:(double)number2{
    return number1 * number2;
}


#pragma mark - Division

-(double)divide:(double)number1 by:(double)number2{
    return number1/number2;
}



@end
