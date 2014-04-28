//
//  ViewController.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "ControladorJogadores.h"
#import <FacebookSDK/FacebookSDK.h>


@interface ViewController : UIViewController <UITextFieldDelegate, MCBrowserViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnIniciar;
@property (weak, nonatomic) IBOutlet UIImageView *iconePersonagem;
@property (weak, nonatomic) IBOutlet UIButton *btnVisivel;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITableView *tbldispositivos;
@property (weak, nonatomic) IBOutlet UIButton *btnDisconnect;

@property FBProfilePictureView *fotoPerfil;
@property BOOL estaVisivel;
@property BOOL crieiSala;
@property ControladorJogadores *controladorJogadores;
@property NSString *myImage;
@property NSString *imgFace;
@property NSString *myName;

- (IBAction)btnProcurar:(id)sender;
- (IBAction)visivel:(id)sender;
- (IBAction)disconnect:(id)sender;
- (IBAction)iniciarPartida:(id)sender;


@end
