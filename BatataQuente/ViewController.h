//
//  ViewController.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface ViewController : UIViewController <MCNearbyServiceAdvertiserDelegate,MCSessionDelegate,MCNearbyServiceBrowserDelegate,MCBrowserViewControllerDelegate, UITextFieldDelegate>


@property MCPeerID *localPeerID;
@property MCSession *session;
@property MCNearbyServiceAdvertiser *advertiser;
@property MCNearbyServiceBrowser *browser;
@property MCBrowserViewController *browserViewController;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UILabel *lblNomeObrigatorio;


@property (weak, nonatomic) IBOutlet UIButton *btnProcurar;


//Ações Botões
- (IBAction)btnVisivel:(id)sender;
- (IBAction)btnProcurar:(id)sender;
- (IBAction)start:(id)sender;
- (IBAction)pressReturn:(id)sender;
- (IBAction)tocouFora:(id)sender;

@end
