//
//  ViewController.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface ViewController : UIViewController <MCNearbyServiceAdvertiserDelegate,MCSessionDelegate,MCNearbyServiceBrowserDelegate,MCBrowserViewControllerDelegate>


@property MCPeerID *localPeerID;
@property MCSession *session;
@property MCNearbyServiceAdvertiser *advertiser;
@property MCNearbyServiceBrowser *browser;
@property MCBrowserViewController *browserViewController;


@property (weak, nonatomic) IBOutlet UIButton *btnProcurar;
@property (weak, nonatomic) IBOutlet UITextField *txtMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnEnviar;
- (IBAction)btnEnviar:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;


//Ações Botões
- (IBAction)btnVisivel:(id)sender;
- (IBAction)btnProcurar:(id)sender;
- (IBAction)start:(id)sender;

@end
