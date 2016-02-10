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
