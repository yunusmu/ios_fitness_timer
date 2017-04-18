//
//  ViewController.m
//  FitnessTimer
//
//  Created by Joseph Apps on 18/04/2017.
//  Copyright © 2017 Joseph Apps. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)speakButtonTapped:(id)sender {
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.inputField.text];
    [utterance setRate:0.5f];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"tr-TR"]];
    [synthesizer speakUtterance:utterance];
}

@end
