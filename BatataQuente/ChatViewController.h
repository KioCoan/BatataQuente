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
#import "Audio.h"

@interface ChatViewController : UIViewController <UITextFieldDelegate>

{
    UISwipeGestureRecognizer *swipe;
    int indiceEliminado;
    NSString *eliminado;
    BOOL proximoEmbatatado;
    BOOL fuiEliminado;
}

@property Audio *audioPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imgBatata;
@property UIImageView *personagem;
@property Batata *minhaBatata;

@property BOOL iniciaTempo;
@property BOOL batata;
@property NSMutableArray *players;
@property NSString *eliminado;



- (IBAction)actionRestart:(id)sender;
@property NSTimer *timer;
@property NSTimeInterval current;


@property (weak, nonatomic) IBOutlet UILabel *tempoDecorrido;

- (IBAction)voltar:(id)sender;

@end
