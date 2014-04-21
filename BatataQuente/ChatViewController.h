//
//  ChatViewController.h
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 18/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "Batata.h"

@interface ChatViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *lblMsgEnviada;
@property (weak, nonatomic) IBOutlet UITextField *txtMsg;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (weak, nonatomic) IBOutlet UIImageView *imgBatata;
@property Batata *minhaBatata;

@property BOOL iniciaTempo;
@property BOOL batata;
@property NSMutableArray *players;


@property NSTimer *timer;
@property NSTimeInterval current;


@property (weak, nonatomic) IBOutlet UILabel *tempoDecorrido;

- (IBAction)voltar:(id)sender;

@end
