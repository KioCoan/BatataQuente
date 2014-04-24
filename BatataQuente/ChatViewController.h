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
#import "ControladorJogadores.h"
#import "ControladorDePosicoes.h"

@interface ChatViewController : UIViewController

{
    UISwipeGestureRecognizer *swipe;
    int indiceEliminado;
    NSString *eliminado;
    BOOL proximoEmbatatado;
    BOOL fuiEliminado;
    NSString *myName;
    BOOL todosProntos;
    BOOL envieiImagemPraTodos;
    
    
}

@property (weak, nonatomic) IBOutlet UIImageView *myPersonagem;
@property (weak, nonatomic) IBOutlet UILabel *lblMeuNome;

@property UIImage *myImage;
@property ControladorJogadores *controladorDeJogadores;
@property Audio *audioPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imgBatata;
@property UIImageView *personagem;
@property Batata *minhaBatata;
@property (weak, nonatomic) IBOutlet UIButton *btnPronto;


- (IBAction)actionPronto:(id)sender;

@property BOOL iniciaTempo;
@property BOOL batata;

@property NSString *eliminado;


@property (weak, nonatomic) IBOutlet UIButton *btnRestart;

- (IBAction)actionRestart:(id)sender;
@property NSTimer *timer;
@property NSTimeInterval current;

@property (weak, nonatomic) IBOutlet UILabel *lblMensagens;

@property (weak, nonatomic) IBOutlet UILabel *tempoDecorrido;

- (IBAction)voltar:(id)sender;

@end
