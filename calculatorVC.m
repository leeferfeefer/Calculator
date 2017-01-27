//
//  calculatorVC.m
//  Calculator
//
//  Created by Lee Fincher on 2/7/16.
//  Copyright © 2016 Dan Fincher. All rights reserved.
//






/*
 
 
    This is my app! 
 
    I decided to create a calculator that shows the user what steps they have taken in order to get the result that is displayed.
    By including parantheses, the user can easily see (by reading right to left) how they got their answer. 
    The app also includes a backspace button that allows the user to quickly go back one operation.
 
    Enjoy! :)
 
 
    NOTE:
        -This app runs best on iphone 6/6 plus
        -App runs on iphone 4 and 5, but with minor UI issues (constraints)
 
 
*/

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
    
    BOOL makeNegative;
    
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
    
    self.resultTextView.editable = NO;
    self.resultTextView.selectable = NO;
    self.feedbackTextView.editable = NO;
    self.feedbackTextView.selectable = NO;
    

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


/*
    These 4 methods are responsible for carrying out the 4 operations (add, subtract, multiply, divide)
    They correspond to the respective buttons being pressed
    If pressed and the feedback text view is not empty (when a number has been entered first:
     - They take care of updating the feedback text view (the operation, parantheses, and UI)
     - Changes operation state
     - Carries out the operation so that numbers do not get missed or incorrectly calculated (double operation)
     - Changes the isDecimal boolean value to false
 
    If pressed and the feedback text view IS empty, a UIAlertController appears and states that a number must be inputted beforehand
*/
- (IBAction)addButtonPressed:(UIButton *)sender {
//    NSLog(@"Add Pressed");
    if ([self isNumberBeforeOperation]) {
        
        [self changePreviousOperation];
        adding = !adding;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        if ([self.feedbackTextView.text length] > 2) {
            if (![[feedback substringFromIndex:[feedback length]-2] isEqualToString:@"+ "]) {
                [self updateFeedbackWithNumber:0 andOperation:@"+"];
                if (total == 0) {
                    total = numberPressedDouble;
                } else {
                    //in case of double operation
                    if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") +"]) {
                        total = [self add:total to:numberPressedDouble];
                    }
                }
            }
        } else {
            [self updateFeedbackWithNumber:0 andOperation:@"+"];
            if (total == 0) {
                total = numberPressedDouble;
            } else {
                //in case of double operation
                if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") +"]) {
                    total = [self add:total to:numberPressedDouble];
                }
            }
        }
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
    
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        makeNegative = NO;
    } else {
//        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)subtractButtonPressed:(UIButton *)sender {
//    NSLog(@"Subtract Pressed");
    if ([self isNumberBeforeOperation]) {
        
        [self changePreviousOperation];
        subtracting = !subtracting;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        if ([self.feedbackTextView.text length] > 2) {
            if (![[feedback substringFromIndex:[feedback length]-2] isEqualToString:@"- "]) {
                [self updateFeedbackWithNumber:0 andOperation:@"-"];
                if (total == 0) {
                    total = numberPressedDouble;
                } else {
                    //in case of double operation
                    if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") -"]) {
                        total = [self subtract:numberPressedDouble from:total];
                    }
                }
            }
        } else {
            [self updateFeedbackWithNumber:0 andOperation:@"-"];
            if (total == 0) {
                total = numberPressedDouble;
            } else {
                //in case of double operation
                if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") -"]) {
                    total = [self subtract:numberPressedDouble from:total];
                }
            }
        }
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }

        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        makeNegative = NO;
    } else {
//        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)multiplyButtonPressed:(UIButton *)sender {
//    NSLog(@"Multiply Pressed");
    if ([self isNumberBeforeOperation]) {
        
        [self changePreviousOperation];
        multiplying = !multiplying;

        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        if ([self.feedbackTextView.text length] > 2) {
            if (![[feedback substringFromIndex:[feedback length]-2] isEqualToString:@"x "]) {
                [self updateFeedbackWithNumber:0 andOperation:@"x"];
                if (total == 0) {
                    total = numberPressedDouble;
                } else {
                    //in case of double operation
                    if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") x"]) {
                        total = [self multiply:total by:numberPressedDouble];
                    }
                }
            }
        } else {
            [self updateFeedbackWithNumber:0 andOperation:@"x"];
            if (total == 0) {
                total = numberPressedDouble;
            } else {
                //in case of double operation
                if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") x"]) {
                    total = [self multiply:total by:numberPressedDouble];
                }
            }
        }
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        makeNegative = NO;
    } else {
//        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}
- (IBAction)divideButtonPressed:(UIButton *)sender {
//    NSLog(@"Divide Pressed");
    if ([self isNumberBeforeOperation]) {

        [self changePreviousOperation];
        dividing = !dividing;
        
        //Show/hide dividing state
        [self changeOperationStateOf:sender];
        if ([self.feedbackTextView.text length] > 2) {
            if (![[feedback substringFromIndex:[feedback length]-2] isEqualToString:@"/ "]) {
                [self updateFeedbackWithNumber:0 andOperation:@"/"];
                if (total == 0) {
                    total = numberPressedDouble;
                } else {
                    //in case of double operation
                    if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") /"]) {
                        total = [self divide:total by:numberPressedDouble];
                    }
                }
            }
        } else {
            [self updateFeedbackWithNumber:0 andOperation:@"/"];
            if (total == 0) {
                total = numberPressedDouble;
            } else {
                //in case of double operation
                if (![[feedback substringWithRange:NSMakeRange([feedback length]-4, 3)] isEqualToString:@") /"]) {
                    total = [self divide:total by:numberPressedDouble];
                }
            }
        }
        
        if (!justAddedParantheses) {
            [self addParentheses];
            justAddedParantheses = YES;
        }
        
        
        numberPressedDouble = 0.0;
        exponent = 0;
        isDecimal = NO;
        makeNegative = NO;
    } else {
//        NSLog(@"number not before operation");
        [self showErrorAlert];
    }
}


/*
    This button method corresponds to the equals button
    If it has already been pressed, (by checking if there is a closed parantheses at the end, it:
        - Updates the feedback text view
        - Calculates the last term being operated on
        - Updates the result text view
        - Clears the UI of any previous operation
*/
- (IBAction)equalsButtonPressed:(UIButton *)sender {
//    NSLog(@"Equals Pressed");
    if (![[feedback substringWithRange:NSMakeRange([feedback length]-1, 1)] isEqualToString:@")"]) {
        feedback = [NSString stringWithFormat:@"%@)", feedback];
        self.feedbackTextView.text = feedback;
        justAddedParantheses = NO;
//        makeNegative = NO;
        [self calculate];
        [self updateResult];
        [self changePreviousOperation];
    }
}



#pragma mark - Numbers

/*
    These button methods check to see if there is an operation being carried out as well as if both the feedback and result text views are empty. If not, (after the user hits enter) then everything is cleared out
    These button methods correspond to each number button
    When pressed:
        - They are responsible for check if the user is imputting a number with more than 1 digit
        - They update the feedback to the user so that they may see operations being carried out
        - They also clear the UI of any previous operation
*/
- (IBAction)zeroButtonPressed:(UIButton *)sender {
//    NSLog(@"Zero Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)oneButtonPressed:(UIButton *)sender {
//    NSLog(@"One Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)twoButtonPressed:(UIButton *)sender {
//    NSLog(@"Two Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)threeButtonPressed:(UIButton *)sender {
//    NSLog(@"Three Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)fourButtonPressed:(UIButton *)sender {
//    NSLog(@"Four Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)fiveButtonPressed:(UIButton *)sender {
//    NSLog(@"Five Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)sixButtonPressed:(UIButton *)sender {
//    NSLog(@"Six Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)sevenButtonPressed:(UIButton *)sender {
//    NSLog(@"Seven Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)eightButtonPressed:(UIButton *)sender {
//    NSLog(@"Eight Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}
- (IBAction)nineButtonPressed:(UIButton *)sender {
//    NSLog(@"Nine Pressed");
    if (![self isInOperation] && ![self.feedbackTextView.text isEqualToString:@""] && ![self.resultTextView.text isEqualToString:[NSString stringWithFormat:@"%f", (double)0]]) {
        [self clear];
    }
    [self checkForMultiDigitWithNumber:[sender.titleLabel.text doubleValue]];
    [self updateFeedbackWithNumber:sender.titleLabel.text andOperation:nil];
    [self changePreviousOperationUI];
}


#pragma mark - Other

/*
    This method corresponds to the clear button
    This method calls the clear method - which clears the console (result and feedback text view) and previous variables
*/
- (IBAction)clearButtonPressed:(UIButton *)sender {
    [self clear];
}

/*
    This method corresponds to the backspace button
    This method calls the remove outer parantheses method - which returns the user back one operation and shows result
*/
- (IBAction)backspaceButtonPressed:(UIButton *)sender {
    [self removeOuterParantheses];
}

/*
    This method corresponds to the decimal button
    This method updates the UI with a decimal for the number being operated on
    Also changes the isDecimal boolean value
*/
- (IBAction)decimalButtonPressed:(UIButton *)sender {
//    NSLog(@"total is %f", total);
//    NSLog(@"number pressed double is %f", numberPressedDouble);
    if (!isDecimal) {
        [self updateFeedbackWithNumber:@"." andOperation:nil];
        isDecimal = YES;
    }
}



- (IBAction)plusMinusButtonPressed:(UIButton *)sender {
//    NSLog(@"plus minus pressed");
    //No operations yet
    if (total == 0) {
        //Entered a number
        if (![self.feedbackTextView.text isEqualToString:@""]) {
            if (!makeNegative) {
                feedback = [NSString stringWithFormat:@"-%@", feedback];
                self.feedbackTextView.text = feedback;
                makeNegative = YES;
                numberPressedDouble*=-1;
            } else {
                feedback = [feedback substringFromIndex:1];
                self.feedbackTextView.text = feedback;
                makeNegative = NO;
                numberPressedDouble*=-1;
            }
        }
    //In mid operation
    } else {
        NSString *ending = [self.feedbackTextView.text substringWithRange:NSMakeRange([self.feedbackTextView.text length]-1, 1)];
        if (![ending isEqualToString:@")"] && ![ending isEqualToString:@" "]) {
            if (!makeNegative) {
                ending = [NSString stringWithFormat:@"-%@", ending];
                feedback = [NSString stringWithFormat:@"%@%@", [feedback substringToIndex:[feedback length]-1], ending];
                self.feedbackTextView.text = feedback;
                makeNegative = YES;
                numberPressedDouble*=-1;
            } else {
                ending = [self.feedbackTextView.text substringWithRange:NSMakeRange([self.feedbackTextView.text length]-1, 1)];
                feedback = [NSString stringWithFormat:@"%@%@", [feedback substringToIndex:[feedback length]-2], ending];
                self.feedbackTextView.text = feedback;
                makeNegative = NO;
                numberPressedDouble*=-1;
            }
        }
    }
}




#pragma mark - Helper Methods

/*
    This method changes and updates the UI -> updates the result by the variable total
*/
-(void)updateResult{
    self.resultTextView.text = [NSString stringWithFormat:@"%f", total];
}

/*
    This method updates the UI -> updates the feedback according to the inputted number and operation arguments
    If the operation argument is nil:
     - If feedback is an empty string (first number being inputted), then it gets shown and set equal to feedback
     - If feedback is NOT empty, a number is added to the feedback and shown - this happens when a number button method is called
 
    If the operation argument is NOT nil:
     - The feedback txt view is shown with an operation within it - this happens when an operation button method is called
*/
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

/*
    This method is called by viewDidLoad
    It adds border parameters to every UI element (buttons and text views)
*/
-(void)addBorders{
    
    
    /*
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
    self.plusMinusButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.plusMinusButton.layer.borderWidth = kBorderSize;
    self.plusMinusButton.layer.cornerRadius = kCornerRadius;
    self.plusMinusButton.layer.masksToBounds = YES;
    
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
     
     
     */
}

/*
    This method calculates the total
    This gets called by the equals button method
 
    It also saves the state of the operation so that when the backspace button is pressed, the calculator return to one operation before
*/
-(void)calculate {
//    NSLog(@"total before operation is %f", total);
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
//    NSLog(@"total after operation is %f", total);
}

/*
    This method gets called by the viedidload, button methods, clear button method, and backspace button methods
    It clears the UI along with variables
*/
-(void)clear{
    makeNegative = NO;
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

/*
    This method is called by every number button method
 
    It is responsible for displaying and getting multidigit numbers ready for calculation
    It performs in 2 ways:
     - Decimal mode: Performs multi digit numbers to the right of decimal
     - NonDecimal mode: Performs multi digit numbers to the left of decimal
*/
-(void)checkForMultiDigitWithNumber:(double)buttonNumber{
    if (!isDecimal) {
//        NSLog(@"no decimal");
        if (numberPressedDouble == 0.0) {
//            NSLog(@"was zero");
            numberPressedDouble = buttonNumber;
        } else {
//            NSLog(@"now increase by 10");
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
    
//    NSLog(@"the number pressed double is %f", numberPressedDouble);
}

/*
    This method gets called to add the beginning parantheses
*/
-(void)addParentheses {
    feedback = [NSString stringWithFormat:@"(%@", feedback];
}

/*
    This method removes the outer parantheses, restores previous operation state, adn displays result
*/
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
            
            //Restore state
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

/*
    This method returns a boolean that tells the object calling it if there are numbers displayed in feedback before an operation
 
    This method gets called by the 4 operation methods
*/
-(BOOL)isNumberBeforeOperation{
    return ![self.feedbackTextView.text isEqualToString:@""];
}

/*
    This method states if there is an operation taking place (in progress)
*/
-(BOOL)isInOperation{
    return adding || subtracting || multiplying || dividing;
}

/*
    This method shows an alert message that tells the user that they must enter a number before doing any calculation or operation
*/
-(void)showErrorAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Whoops" message:@"You must enter a number before any operation." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - Operation State Methods

/*
    This method changes the operation state (represented by UI) of the previous operation button
*/
-(void)changeOperationStateOf:(UIButton *)sender {
    if (previousOperationButton) {
        [previousOperationButton.layer setBorderColor:[UIColor blackColor].CGColor];
    }
    previousOperationButton = sender;
    [sender.layer setBorderColor:[UIColor redColor].CGColor];
}

/*
    This method changes the state of current operation (ui and variables - boolean operation state)
*/
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

/*
    This method changes the state of current operation (ui without the boolean operation state)
*/
-(void)changePreviousOperationUI{
    if (adding) {
        self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (subtracting) {
        self.subtractButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (multiplying) {
        self.multiplyButton.layer.borderColor = [UIColor blackColor].CGColor;
    } else if (dividing) {
        self.divideButton.layer.borderColor = [UIColor blackColor].CGColor;
    }
}










#pragma mark - Operations

#pragma mark - Addition

/*
    These methods are straightforward
 
    They are represented as these methods in order to make them easier in terms of modularity and consistency
*/

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
