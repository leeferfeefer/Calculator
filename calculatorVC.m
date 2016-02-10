//
//  calculatorVC.m
//  Calculator
//
//  Created by Lee Fincher on 2/7/16.
//  Copyright © 2016 Dan Fincher. All rights reserved.
//

#import "calculatorVC.h"


@interface calculatorVC () {
    
    //States
    BOOL adding;
    BOOL subtracting;
    BOOL multiplying;
    BOOL dividing;
    
    UIButton *previousOperationButton;
    UIButton *numberPressed;
    
    double total;
    NSString *feedback;
    
}

@end

@implementation calculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    total = 0.0;
    feedback = @"";
    
    self.feedbackTextView.text = feedback;
    self.resultTextView.text = @"0.0";
    
    
    //Borders
    [self addBorders];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - Button Methods
#pragma mark - Operations

- (IBAction)addButtonPressed:(UIButton *)sender {
    NSLog(@"Add Pressed");
    [self changePreviousOperation];
    adding = !adding;
    
    //Show/hide dividing state
    [self changeOperationStateOf:sender];
}
- (IBAction)subtractButtonPressed:(UIButton *)sender {
    NSLog(@"Subtract Pressed");
    [self changePreviousOperation];
    subtracting = !subtracting;
    
    //Show/hide dividing state
    [self changeOperationStateOf:sender];
}
- (IBAction)multiplyButtonPressed:(UIButton *)sender {
    NSLog(@"Multiply Pressed");
    [self changePreviousOperation];
    multiplying = !multiplying;

    //Show/hide dividing state
    [self changeOperationStateOf:sender];
}
- (IBAction)divideButtonPressed:(UIButton *)sender {
    NSLog(@"Divide Pressed");
    [self changePreviousOperation];
    dividing = !dividing;
    
    //Show/hide dividing state
    [self changeOperationStateOf:sender];
}
- (IBAction)equalsButtonPressed:(UIButton *)sender {
    NSLog(@"Equals Pressed");
    
    [self calculate];
}
-(void)calculate {
    if (adding) {
        total = [self add:total to:[numberPressed.titleLabel.text doubleValue]];
        NSLog(@"Adding: total is %f", total);
    } else if (subtracting) {
        total = [self subtract:total from:[numberPressed.titleLabel.text doubleValue]];
        NSLog(@"Subtracting: total is %f", total);
    } else if (multiplying) {
        total = [self multiply:total by:[numberPressed.titleLabel.text doubleValue]];
        NSLog(@"Multiplying: total is %f", total);
    } else if (dividing) {
        total = [self divide:total by:[numberPressed.titleLabel.text doubleValue]];
        NSLog(@"Dividing: total is %f", total);
    }
    [self updateResult];
}


#pragma mark - Numbers

- (IBAction)zeroButtonPressed:(UIButton *)sender {
    NSLog(@"Zero Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)oneButtonPressed:(UIButton *)sender {
    NSLog(@"One Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)twoButtonPressed:(UIButton *)sender {
    NSLog(@"Two Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)threeButtonPressed:(UIButton *)sender {
    NSLog(@"Three Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)fourButtonPressed:(UIButton *)sender {
    NSLog(@"Four Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)fiveButtonPressed:(UIButton *)sender {
    NSLog(@"Five Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)sixButtonPressed:(UIButton *)sender {
    NSLog(@"Six Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)sevenButtonPressed:(UIButton *)sender {
    NSLog(@"Seven Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)eightButtonPressed:(UIButton *)sender {
    NSLog(@"Eight Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}
- (IBAction)nineButtonPressed:(UIButton *)sender {
    NSLog(@"Nine Pressed");
    numberPressed = sender;
    [self updateFeedback:sender];
}


#pragma mark - Other

- (IBAction)clearButtonPressed:(UIButton *)sender {
    total = 0;
    feedback = @"";
    self.feedbackTextView.text = feedback;
    self.resultTextView.text = [NSString stringWithFormat:@"%f", total];
}

- (IBAction)backspaceButtonPressed:(UIButton *)sender {
}




#pragma mark - Helper Methods

-(void)updateResult{
    self.resultTextView.text = [NSString stringWithFormat:@"%f", total];
}
-(void)updateFeedback:(UIButton *)sender{
    if ([feedback isEqualToString:@""]) {
        feedback = sender.titleLabel.text;
    } else {
        if (adding) {
            feedback = [NSString stringWithFormat: @" %@ %@ %@", feedback, @"+", sender.titleLabel.text];
        } else if (subtracting) {
            feedback = [NSString stringWithFormat: @" %@ %@ %@", feedback, @"-", sender.titleLabel.text];
        } else if (multiplying) {
            feedback = [NSString stringWithFormat: @" %@ %@ %@", feedback, @"x", sender.titleLabel.text];
        } else if (dividing) {
            feedback = [NSString stringWithFormat: @" %@ %@ %@", feedback, @"/", sender.titleLabel.text];
        }
    }
    self.feedbackTextView.text = feedback;
}
-(void)addBorders{
    self.resultTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.resultTextView.layer.borderWidth = 1;
    self.resultTextView.layer.cornerRadius = 10;
    self.resultTextView.layer.masksToBounds = YES;
    self.feedbackTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.feedbackTextView.layer.borderWidth = 1;
    self.feedbackTextView.layer.cornerRadius = 10;
    self.feedbackTextView.layer.masksToBounds = YES;
    self.clearButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.clearButton.layer.borderWidth = 1;
    self.clearButton.layer.cornerRadius = 10;
    self.clearButton.layer.masksToBounds = YES;
    self.backspaceButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.backspaceButton.layer.borderWidth = 1;
    self.backspaceButton.layer.cornerRadius = 10;
    self.backspaceButton.layer.masksToBounds = YES;
    self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.cornerRadius = 10;
    self.addButton.layer.masksToBounds = YES;
    self.subtractButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.subtractButton.layer.borderWidth = 1;
    self.subtractButton.layer.cornerRadius = 10;
    self.subtractButton.layer.masksToBounds = YES;
    self.multiplyButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.multiplyButton.layer.borderWidth = 1;
    self.multiplyButton.layer.cornerRadius = 10;
    self.multiplyButton.layer.masksToBounds = YES;
    self.divideButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.divideButton.layer.borderWidth = 1;
    self.divideButton.layer.cornerRadius = 10;
    self.divideButton.layer.masksToBounds = YES;
    self.equalsButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.equalsButton.layer.borderWidth = 1;
    self.equalsButton.layer.cornerRadius = 10;
    self.equalsButton.layer.masksToBounds = YES;
    
    self.zeroButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.zeroButton.layer.borderWidth = 1;
    self.zeroButton.layer.cornerRadius = 10;
    self.zeroButton.layer.masksToBounds = YES;
    self.oneButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.oneButton.layer.borderWidth = 1;
    self.oneButton.layer.cornerRadius = 10;
    self.oneButton.layer.masksToBounds = YES;
    self.twoButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.twoButton.layer.borderWidth = 1;
    self.twoButton.layer.cornerRadius = 10;
    self.twoButton.layer.masksToBounds = YES;
    self.threeButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.threeButton.layer.borderWidth = 1;
    self.threeButton.layer.cornerRadius = 10;
    self.threeButton.layer.masksToBounds = YES;
    self.fourButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.fourButton.layer.borderWidth = 1;
    self.fourButton.layer.cornerRadius = 10;
    self.fourButton.layer.masksToBounds = YES;
    self.fiveButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.fiveButton.layer.borderWidth = 1;
    self.fiveButton.layer.cornerRadius = 10;
    self.fiveButton.layer.masksToBounds = YES;
    self.sixButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.sixButton.layer.borderWidth = 1;
    self.sixButton.layer.cornerRadius = 10;
    self.sixButton.layer.masksToBounds = YES;
    self.sevenButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.sevenButton.layer.borderWidth = 1;
    self.sevenButton.layer.cornerRadius = 10;
    self.sevenButton.layer.masksToBounds = YES;
    self.eightButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.eightButton.layer.borderWidth = 1;
    self.eightButton.layer.cornerRadius = 10;
    self.eightButton.layer.masksToBounds = YES;
    self.nineButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.nineButton.layer.borderWidth = 1;
    self.nineButton.layer.cornerRadius = 10;
    self.nineButton.layer.masksToBounds = YES;
}








#pragma mark - Operation State Methods

-(void)changeOperationStateOf:(UIButton *)sender {
    if (previousOperationButton) {
        [previousOperationButton.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    previousOperationButton = sender;
    [sender.layer setBorderWidth:2];
    [sender.layer setBorderColor:[UIColor redColor].CGColor];
}
-(void)changePreviousOperation{
    if (adding) {
        adding = !adding;
    } else if (subtracting) {
        subtracting = !subtracting;
    } else if (multiplying) {
        multiplying = !multiplying;
    } else if (dividing) {
        dividing = !dividing;
    }
}












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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
