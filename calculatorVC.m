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
    
    BOOL justAddedParantheses;
    
    UIButton *previousOperationButton;
    double numberPressedDouble;
    int exponent;
    
    NSString *feedback;
    double total;
    
    NSMutableArray *previousOperation;
}

@end

@implementation calculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init
    previousOperation = [NSMutableArray new];

    //Clear content
    [self clear];
    
    //Set borders
    [self addBorders];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self clear];
}








#pragma mark - Button Methods
#pragma mark - Operations

- (IBAction)addButtonPressed:(UIButton *)sender {
    NSLog(@"Add Pressed");
    if ([self isNumberBeforeOperation]) {
        
        [self changePreviousOperation];
        adding = !adding;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        [self updateFeedbackWithNumber:0 andOperation:@"+"];
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        if (total == 0) {
            total = numberPressedDouble;
        } else {
            //in case of double operation
            if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") +"]) {
                total = [self add:total to:numberPressedDouble];
            }
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)subtractButtonPressed:(UIButton *)sender {
    NSLog(@"Subtract Pressed");
    if ([self isNumberBeforeOperation]) {
        
        [self changePreviousOperation];
        subtracting = !subtracting;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        [self updateFeedbackWithNumber:0 andOperation:@"-"];
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        if (total == 0) {
            total = numberPressedDouble;
        } else {
            //in case of double operation
            if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") -"]) {
                total = [self subtract:numberPressedDouble from:total];
            }
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)multiplyButtonPressed:(UIButton *)sender {
    NSLog(@"Multiply Pressed");
    if ([self isNumberBeforeOperation]) {
    
        [self changePreviousOperation];
        multiplying = !multiplying;

        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        [self updateFeedbackWithNumber:0 andOperation:@"x"];
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        if (total == 0) {
            total = numberPressedDouble;
        } else {
            //in case of double operation
            if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") x"]) {
                total = [self multiply:numberPressedDouble by:total];
            }
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)divideButtonPressed:(UIButton *)sender {
    NSLog(@"Divide Pressed");
    if ([self isNumberBeforeOperation]) {

        [self changePreviousOperation];
        dividing = !dividing;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        [self updateFeedbackWithNumber:0 andOperation:@"/"];
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        if (total == 0) {
            total = numberPressedDouble;
        } else {
            //in case of double operation
            if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") /"]) {
                total = [self divide:total by:numberPressedDouble];
            }
        }
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
    } else {
        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)equalsButtonPressed:(UIButton *)sender {
    NSLog(@"Equals Pressed");
    if (![[feedback substringWithRange:NSMakeRange([feedback length]-1, 1)] isEqualToString:@")"]) {
        feedback = [NSString stringWithFormat:@"%@)", feedback];
        self.feedbackTextView.text = feedback;
        justAddedParantheses = NO;
        [self calculate];
        [self updateResult];
        [self changePreviousOperation];
    }
}



#pragma mark - Numbers

- (IBAction)zeroButtonPressed:(UIButton *)sender {
    NSLog(@"Zero Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)oneButtonPressed:(UIButton *)sender {
    NSLog(@"One Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)twoButtonPressed:(UIButton *)sender {
    NSLog(@"Two Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)threeButtonPressed:(UIButton *)sender {
    NSLog(@"Three Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)fourButtonPressed:(UIButton *)sender {
    NSLog(@"Four Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)fiveButtonPressed:(UIButton *)sender {
    NSLog(@"Five Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)sixButtonPressed:(UIButton *)sender {
    NSLog(@"Six Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)sevenButtonPressed:(UIButton *)sender {
    NSLog(@"Seven Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)eightButtonPressed:(UIButton *)sender {
    NSLog(@"Eight Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}
- (IBAction)nineButtonPressed:(UIButton *)sender {
    NSLog(@"Nine Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
}


#pragma mark - Other

- (IBAction)clearButtonPressed:(UIButton *)sender {
    [self clear];
}
- (IBAction)backspaceButtonPressed:(UIButton *)sender {
    [self removeOuterParantheses];
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
            feedback = [NSString stringWithFormat:@"%@%@", feedback, number];
        }
    } else {
        feedback = [NSString stringWithFormat: @"%@ %@ ", feedback, operation];
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
        total = [self add:numberPressedDouble to:total];
        [previousOperation addObject:@"add"];
        [previousOperation addObject:[NSNumber numberWithDouble:numberPressedDouble]];
    } else if (subtracting) {
        total = [self subtract:numberPressedDouble from:total];
        [previousOperation addObject:@"subtract"];
        [previousOperation addObject:[NSNumber numberWithDouble:numberPressedDouble]];
    } else if (multiplying) {
        total = [self multiply:total by:numberPressedDouble];
        [previousOperation addObject:@"multiply"];
        [previousOperation addObject:[NSNumber numberWithDouble:numberPressedDouble]];
    } else if (dividing) {
        total = [self divide:total by:numberPressedDouble];
        [previousOperation addObject:@"divide"];
        [previousOperation addObject:[NSNumber numberWithDouble:numberPressedDouble]];
    }
    NSLog(@"total after operation is %f", total);
}
-(void)clear{
    [previousOperation removeAllObjects];
    isDecimal = NO;
    justAddedParantheses = NO;
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
        NSLog(@"no decimal");
        if (numberPressedDouble == 0.0) {
            NSLog(@"was zero");
            numberPressedDouble = buttonNumber;
        } else {
            NSLog(@"now increase by 10");
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
-(void)addParentheses {
    feedback = [NSString stringWithFormat:@"(%@", feedback];
}
-(void)removeOuterParantheses {
    
    //If not in middle of operation
    if (![self isInOperation]) {
        NSString *temp = [feedback copy];
        NSString *parameter = @")";
        //Find how many operations have been made based on ()
        NSInteger count = [temp length] - [[temp stringByReplacingOccurrencesOfString:parameter withString:@""] length];
        count /= [parameter length];
        
        //If only one operation
        if (count == 1) {
            [self clear];
        } else {
            //Remove outer parantheses
            NSUInteger start = 1;
            feedback = [feedback substringWithRange:NSMakeRange(start, [feedback length]-(start+1))];
            //Remove whats left of last operation
            feedback = [feedback substringWithRange:NSMakeRange(0, [feedback rangeOfString:@")" options:NSBackwardsSearch].location+1)];
            self.feedbackTextView.text = feedback;
            
            //Undo operation - performs like a stack
            double lastNumber = [[previousOperation lastObject] doubleValue];
            [previousOperation removeLastObject];
            NSString *lastOperation = [previousOperation lastObject];
            [previousOperation removeLastObject];
            
            if ([lastOperation isEqualToString:@"add"]) {
                total = [self subtract:lastNumber from:total];
            } else if ([lastOperation isEqualToString:@"subtract"]) {
                total = [self add:lastNumber to:total];
            } else if ([lastOperation isEqualToString:@"multiply"]) {
                total = [self divide:total by:lastNumber];
            } else if ([lastOperation isEqualToString:@"divide"]) {
                total = [self multiply:total by:lastNumber];
            }
            [self updateResult];
        }
    } else {
        
    }
}
-(BOOL)isNumberBeforeOperation{
    return ![self.feedbackTextView.text isEqualToString:@""];
}
-(BOOL)isInOperation{
    return adding || subtracting || multiplying || dividing;
}
-(void)showErrorAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Whoops" message:@"You must enter a number before any operation." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(NSString *)reverseString:(NSString *)reverseString{
    NSMutableString *reversedString = [NSMutableString new];
    NSInteger index = [reverseString length];
    while (index > 0) {
        index--;
        NSRange range = NSMakeRange(index, 1);
        [reversedString appendString:[reverseString substringWithRange:range]];
    }
    return reversedString;
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
    return number2 - number1;
}


#pragma mark - Multiplication

-(double)multiply:(double)number1 by:(double)number2{
    return number1 * number2;
}


#pragma mark - Division

-(double)divide:(double)number2 by:(double)number1{
    return number2/number1;
}



@end
