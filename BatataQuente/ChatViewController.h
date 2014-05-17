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
#import "ImagensTelaPartida.h"
#import "ViewController.h"
@interface ChatViewController : UIViewController

{
    UISwipeGestureRecognizer *swipe;
    int indiceEliminado;
    NSString *_eliminado;
    BOOL proximoEmbatatado;
    BOOL fuiEliminado;
    NSString *myName;
    BOOL todosProntos;
    BOOL envieiImagemPraTodos;
    BOOL envieiMensagemToPronto;
    ImagensTelaPartida *imagensTela;
    NSTimer *timerBatata;
    NSTimeInterval currentBatata;
}




@property (weak, nonatomic) IBOutlet UILabel *lblMeuNome;
@property ViewController *viewController;
@property NSString *myImage;
@property ControladorJogadores *controladorDeJogadores;
@property Audio *audioPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imgBatata;
@property UIImageView *personagem;
@property Batata *minhaBatata;


- (IBAction)actionPronto:(id)sender;

@property BOOL iniciaTempo;
@property BOOL batata;

@property NSString *eliminado;

@property (weak, nonatomic) IBOutlet UIImageView *meuIcone;

@property (weak, nonatomic) IBOutlet UIImageView *minhaImagem;
@property (weak, nonatomic) IBOutlet UIButton *btnRestart;
@property (weak, nonatomic) IBOutlet UIButton *btnVoltar;

- (IBAction)actionRestart:(id)sender;
@property NSTimer *timer;
@property NSTimeInterval current;

@property (weak, nonatomic) IBOutlet UILabel *lblMensagens;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

- (IBAction)voltar:(id)sender;

@end
