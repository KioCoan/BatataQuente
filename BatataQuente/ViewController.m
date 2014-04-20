//
//  ViewController.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChatViewController.h"

@interface ViewController ()

@property (nonatomic, strong)AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

@end

@implementation ViewController



static NSString * XXServiceType = @"batata-quente";

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self canBecomeFirstResponder ];
    [self.txtNome setDelegate:self];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[self.appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
	
    self.arrConnectedDevices = [[NSMutableArray alloc] init];
    
    [self.tbldispositivos setDelegate:self];
    [self.tbldispositivos setDataSource:self];
    self.estaVisivel = false;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mudaImagemPersonagem)];
    [self.iconePersonagem addGestureRecognizer:tap];
    self.sexoMasculino = YES;
    [self setCrieiSala:NO];
}
-(void)viewWillAppear:(BOOL)animated{
   // [self disconnect:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)mudaImagemPersonagem{
    if(self.sexoMasculino){
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeFeminino.png"]];
        self.sexoMasculino = NO;
    
    }else{
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeMasculino.png"]];
        self.sexoMasculino = YES;
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    self.appDelegate.mcManager.peerID = nil;
    self.appDelegate.mcManager.session = nil;
    self.appDelegate.mcManager.browser = nil;
    
    if (self.estaVisivel) {
        [self.appDelegate.mcManager.advertiser stop];
    }
    self.appDelegate.mcManager.advertiser = nil;
    
    if(![self.txtNome.text isEqualToString:@""]){
        [self.appDelegate.mcManager setupPeerAndSessionWithDisplayName:self.txtNome.text];
        [self.appDelegate.mcManager setupMCBrowser];
    }
    
    
    return YES;
}



- (IBAction)btnProcurar:(id)sender
{
    if(!self.estaVisivel){
        [self visivel:nil];
    }
    
    [[self.appDelegate mcManager] setupMCBrowser];
    [[[self.appDelegate mcManager] browser] setDelegate:self];
    [self presentViewController:[[self.appDelegate mcManager] browser] animated:YES completion:nil];
    
    [self setCrieiSala:YES];
    
}

-(IBAction)visivel:(id)sender{
    
        
        self.estaVisivel = !self.estaVisivel;
        [self mudaImagemBtnVisivel];
        [[self arrConnectedDevices]addObject: [[self txtNome] text]];
        [self.appDelegate.mcManager advertiseSelf:self.estaVisivel];
     
    
    
//    if ([[[self txtNome]text]isEqualToString:@""]) {
//        UIAlertView *alert;
//        alert = [[UIAlertView alloc] initWithTitle:@"Dados inválidos"
//                                           message:@"Seu nome é obrigatório"
//                                          delegate:self
//                                 cancelButtonTitle:@"OK"
//                                 otherButtonTitles:nil];
//        [alert show];
//        
//        
//    }else{
//        
//        self.estaVisivel = !self.estaVisivel;
//        [[self arrConnectedDevices]addObject: [[self txtNome]text]];
//        [self.appDelegate.mcManager advertiseSelf:self.estaVisivel];
//    }
  
    
}

-(void)mudaImagemBtnVisivel{
    if(self.estaVisivel){
        [self.btnVisivel setImage:[UIImage imageNamed:@"visivelOn.png"] forState:UIControlStateNormal];
    }else{
        [self.btnVisivel setImage:[UIImage imageNamed:@"visivelOff.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)disconnect:(id)sender{
    [self.appDelegate.mcManager.session disconnect];
    
    self.txtNome.enabled = YES;
    
    [self.arrConnectedDevices removeAllObjects];
    [self.tbldispositivos reloadData];
}


- (IBAction)iniciarPartida:(id)sender {
    //NSLog(@"%@",self.arrConnectedDevices);
    
    ChatViewController *chat = [self.storyboard instantiateViewControllerWithIdentifier:@"viewChat"];;
    
    
    [chat setPlayers:self.arrConnectedDevices];
    [chat setBatata:self.crieiSala];
    
    chat.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:chat animated:YES completion:nil];
    
    
    
    //[self performSegueWithIdentifier:@"viewChat" sender:nil];
}


-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self.appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self.appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [self.arrConnectedDevices addObject:peerDisplayName];
            
            [self.btnIniciar setImage:[UIImage imageNamed:@"iniciarPartidaOn.png"] forState:UIControlStateNormal];
                self.btnIniciar.userInteractionEnabled = YES;
            
        }
        else if (state == MCSessionStateNotConnected){
            if ([self.arrConnectedDevices count] > 0) {
                int indexOfPeer = [self.arrConnectedDevices indexOfObject:peerDisplayName];
                [self.arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            }
        }
        [self.tbldispositivos reloadData];
        
        BOOL peersExist = ([[self.appDelegate.mcManager.session connectedPeers] count] == 0);
        [self.btnDisconnect setEnabled:!peersExist];
        [self.txtNome setEnabled:peersExist];
        
        if(peersExist){
            
                [self.btnIniciar setImage:[UIImage imageNamed:@"iniciarPartidaOff.png"] forState:UIControlStateNormal];
                self.btnIniciar.userInteractionEnabled = NO;
            
        }
    }
    
    }];
    [self.btnIniciar setNeedsDisplay];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    if([[self.arrConnectedDevices objectAtIndex:indexPath.row] isEqualToString:[self.txtNome text]]){
        cell.textLabel.text = @"Eu";
    }else{
        cell.textLabel.text = [self.arrConnectedDevices objectAtIndex:indexPath.row];
    }
    
    cell.backgroundColor = nil;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}




@end
