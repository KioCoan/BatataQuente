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

    [self setCrieiSala:NO];

    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mudaImagemPersonagem)];
    self.fotoPerfil = [[FBProfilePictureView alloc] initWithFrame:self.iconePersonagem.frame];
    [self.fotoPerfil addGestureRecognizer:tap2];
    self.fotoPerfil.userInteractionEnabled = YES;
    
    
    if(self.myImage == nil){
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeMasculino.png"]];
        self.myImage = @"iconeMasculino.png";
        self.imgFace = nil;
        
        
    }else{
        self.imgFace = self.myImage;
        [self.fotoPerfil setProfileID:self.myImage];
        
        self.fotoPerfil.layer.borderWidth = 1.0f;
        self.fotoPerfil.layer.cornerRadius = CGRectGetWidth(self.fotoPerfil.bounds) / 2.0f;
        [[self view] addSubview:self.fotoPerfil];
        
        
        [[self iconePersonagem] setImage:nil];
        [[self iconePersonagem] setBackgroundColor:[UIColor whiteColor]];
        self.iconePersonagem.layer.cornerRadius = CGRectGetWidth(self.fotoPerfil.bounds) / 2.0f;
    }

    
    //configuracao foto
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


-(void)mudaImagemPersonagem{
    if(!self.imgFace){
        [self exibeImagensPadrao];
    
    }else{
        [self exibeImagenDoFace];
    }
    
    
    
}

//SE O CARA ESTIVER USANDO A FOTO DO FACE ELE TERÁ 2 OPÇÕES DE IMAGENS PADRÕES
-(void)exibeImagensPadrao{
    if([self.myImage isEqualToString:@"iconeMasculino.png"]){
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeFeminino.png"]];
        self.myImage = @"iconeFeminino.png";
        
    }else{
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeMasculino.png"]];
        self.myImage = @"iconeMasculino.png";
        
    }
}


//SE O CARA ESTIVER USANDO A FOTO DO FACE ELE TERÁ 3 OPÇÕES DE IMAGENS
-(void)exibeImagenDoFace{
    if([self.myImage isEqualToString:@"iconeMasculino.png"]){
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeFeminino.png"]];
        self.myImage = @"iconeFeminino.png";
        
        
    }else if([self.myImage isEqualToString:@"iconeFeminino.png"]){
        [self.iconePersonagem setImage:[UIImage imageNamed:self.imgFace]];
        self.myImage = self.imgFace;
        [[self view] bringSubviewToFront:self.fotoPerfil];
        self.iconePersonagem.hidden = YES;
        self.fotoPerfil.hidden = NO;
        
    }else{
        [self.iconePersonagem setImage:[UIImage imageNamed:@"iconeMasculino.png"]];
        self.myImage = @"iconeMasculino.png";
        [[self view] bringSubviewToFront:self.iconePersonagem];
        [[self iconePersonagem] setBackgroundColor:[UIColor clearColor]];
        self.iconePersonagem.hidden = NO;
        self.fotoPerfil.hidden = YES;
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
    
    if(self.estaVisivel){
        [self.appDelegate.mcManager advertiseSelf:self.estaVisivel];
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
    if ([self.arrConnectedDevices count]<1) {
        [[self arrConnectedDevices]addObject: [[self txtNome] text]];
    }
    
        [self.appDelegate.mcManager advertiseSelf:self.estaVisivel];
  
    
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
    
    [self setCrieiSala:NO];
    [self.btnVisivel setImage:[UIImage imageNamed:@"visivelOff.png"] forState:UIControlStateNormal];
    
    if(self.estaVisivel){
        [self visivel:nil];
    }
    
    
    [self.arrConnectedDevices removeAllObjects];
    [self.tbldispositivos reloadData];
        
        
}


- (IBAction)iniciarPartida:(id)sender {
   
   
    
    self.controladorJogadores = [[ControladorJogadores alloc] init];
    
    
    if ([[self.arrConnectedDevices objectAtIndex:0]isEqualToString:@""]) {
        
        [self.arrConnectedDevices setObject:[[self.appDelegate.mcManager.session myPeerID ] displayName] atIndexedSubscript:0];
    }
    
    for (int i = 0; i<[self.arrConnectedDevices count]; i++) {
        [self.controladorJogadores insereJogador:[self.arrConnectedDevices objectAtIndex:i]];
        
    }
    
    [self.controladorJogadores adicionaNoJogador:[self.appDelegate.mcManager.peerID displayName] aImagem:self.myImage];
    
    ChatViewController *chat = [self.storyboard instantiateViewControllerWithIdentifier:@"viewChat"];
    
    
    
    [chat setBatata:self.crieiSala];
    [chat setMyImage:self.myImage];
    
    NSLog(@"%@", [[self iconePersonagem] image]);
    [chat setControladorDeJogadores:self.controladorJogadores];
    
    
    chat.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:chat animated:YES completion:nil];
    
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
        NSLog(@"nome : %@",peerID.displayName);
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
                
                for (NSString *user in self.arrConnectedDevices) {
                    
                    if ([[peerID displayName]isEqualToString:user]) {
                        [self.arrConnectedDevices removeObject:user];
                    }
                }
            }
        }
        
        [self.tbldispositivos reloadData];
        
        BOOL peersExist = ([[self.appDelegate.mcManager.session connectedPeers] count] == 0);
        //[self.btnDisconnect setEnabled:!peersExist];
        //[self.txtNome setEnabled:peersExist];
        
        if(peersExist){
            
                [self.btnIniciar setImage:[UIImage imageNamed:@"iniciarPartidaOff.png"] forState:UIControlStateNormal];
                self.btnIniciar.userInteractionEnabled = NO;
            
        }
    }
    
    }];
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
    
    if(indexPath.row == 0){
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
