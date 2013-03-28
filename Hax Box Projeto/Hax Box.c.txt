#include <allegro.h>
#include <time.h>
#include <alpng.h> //habilita o uso de png
#include <algif.h> //habilita o uso de gif
#include <jpgalleg.h> //habilita o uso de jpg
#include "al_screen/al_screen.h" //atualizar a tela melhor
#include "pmask/pmask.h"
#include "pmask/collist.h"
#include <stdio.h>

#define TELA_L 800
#define TELA_A 600
#define LINHAS 15
#define COLUNAS 20
#define ALTURA_TILE 40
#define LARGURA_TILE 40
#define CORES 32 // Profundidade de cores
#define MAXFPS 60 //maximo de frames por segundo

//Prototipos

void funcTempo(void);
void funcFPS(void) ;
void BotaoFechar(void) ;
void deinicia_allegro();
void inicia_allegro();
void jogar(int map[LINHAS][COLUNAS]);
void jogar2(int map[LINHAS][COLUNAS]);
void jogar3(int map[LINHAS][COLUNAS]);
void jogar4(int map[LINHAS][COLUNAS]);
void jogar5(int map[LINHAS][COLUNAS]);
void jogar6(int map[LINHAS][COLUNAS]);
void jogar7(int map[LINHAS][COLUNAS]);
void jogar8(int map[LINHAS][COLUNAS]);
void jogar9(int map[LINHAS][COLUNAS]);
void jogar10(int map[LINHAS][COLUNAS]);
void fases();
void fases2();
void fimDeFase(int minuto,int segundo,int movimentos,int passos,int fase);
void novojogo();

int mapaLiberado = 1;

//-----------------------------------------MAPAS-------------------------------
int map1[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,3,1,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,2,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,2,2,2,3,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,3,2,2,2,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,2,1,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,1,3,1,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };

int map2[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,2,2,2,3,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,1,2,1,2,1,2,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,1,2,1,2,1,2,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,2,3,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
int map3[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,2,2,2,2,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,2,1,1,1,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,3,3,1,2,2,2,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,3,3,1,2,2,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
int map4[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,2,2,1,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,1,2,3,1,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,1,1,3,1,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,1,1,1,2,3,2,2,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,2,2,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
int map5[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,1,1,2,2,1,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,1,2,1,2,1,2,1,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,1,2,3,3,3,2,2,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,1,1,1,1,2,2,2,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
        
int map6[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,1,1,2,2,1,2,2,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,1,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,3,2,3,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,2,2,1,2,2,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,0,1,2,3,2,3,2,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
            
int map7[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,3,2,3,2,3,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,2,2,2,1,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,1,2,2,2,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,2,2,2,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
int map8[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,1,1,1,1,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0,4},
    {4,0,0,0,0,1,2,2,2,2,2,2,2,2,1,0,0,0,0,4},
    {4,0,0,0,0,1,1,1,2,2,2,1,1,1,1,0,0,0,0,4},
    {4,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
        
int map9[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,1,1,2,2,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,2,3,2,1,1,0,0,0,0,4},
    {4,0,0,0,1,1,1,2,2,2,2,2,2,2,1,1,0,0,0,4},
    {4,0,0,0,1,2,3,3,3,3,3,3,3,3,2,1,0,0,0,4},
    {4,0,0,0,1,2,2,2,2,2,2,2,2,2,2,1,0,0,0,4},
    {4,0,0,0,1,1,1,2,3,2,1,2,2,1,1,1,0,0,0,4},
    {4,0,0,0,0,0,1,2,2,2,1,1,1,1,0,0,0,0,0,4},
    {4,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
            
int map10[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,4},
    {4,0,1,2,2,2,2,2,2,2,1,2,2,1,2,2,2,1,0,4},
    {4,0,1,2,1,2,1,2,1,2,1,2,2,2,2,2,2,1,0,4},
    {4,0,1,2,1,3,3,3,1,2,1,2,2,2,2,2,2,1,0,4},
    {4,0,1,2,2,3,3,3,1,2,1,2,2,2,2,2,2,1,1,4},
    {4,0,1,2,1,1,3,1,1,2,1,2,1,1,2,2,2,2,1,4},
    {4,0,1,2,1,3,3,3,2,2,2,2,2,2,2,2,2,2,1,4},
    {4,0,1,2,1,1,2,1,1,1,2,2,1,1,1,1,1,1,1,4},
    {4,0,1,2,2,2,2,1,1,1,1,1,1,0,0,0,0,0,0,4},
    {4,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
    
int map11[LINHAS][COLUNAS] = {
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4}, // Limite do mapa
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}, };
//-----------------------------------------MAPAS-------------------------------

BITMAP *makeCursor();

//variaveis externas
extern volatile int FecharJogo;
extern int volume;
extern int vSync;
//variaveis Countador de FPS
extern volatile int contFrames, contTempo; // Conta a quantidade de frames em cada segundo 
//extern volatile int fps; // Armazena a taxa atual de Fps
extern short int fpsC,fpsT,fps;

//Variaveis Globais
// fechar jogo
volatile int FecharJogo = FALSE;

int volume=128;
int vSync=0;
int resolucaoX, resolucaoY;
int Janela = 1;

PALLETE pl;

//variaveis Countador de FPS
volatile int contFrames = 0, contTempo = 0; // Conta a quantidade de frames em cada segundo
//volatile int fps = 0; // Armazena a taxa atual de Fps
short int fpsC=0,fpsT=0,fps=0;


//Fim Variaveis Globais



typedef struct hax {
    int x,y; // posições x e y do Hax na tela;
}haxBoneco;

typedef struct box{
    int x,y;
}boxCoordenadas;

typedef struct BBcaixa{
    int left,right,top,bottom;
}BBcaixa;

//---------------------------------------------------------------------------
int main()
{   
    set_uformat(U_ASCII);//Ativar acentuação
    inicia_allegro();
    int res = 1;

	BITMAP *buffer = create_bitmap( TELA_L, TELA_A );
	BITMAP *cursor = makeCursor();
	BITMAP *logo = load_bitmap("img/HaxBoxLogo.bmp",pl);
	BITMAP *selecionado = load_bitmap("img/x.bmp",pl);
	BITMAP *selecionadoF = load_bitmap("img/xF.bmp",pl);
	
	FILE *saveJogo;
     
     saveJogo = fopen("save.bin","rb");
     if(!saveJogo)
     {
       saveJogo = fopen("save.bin","w+b");
       fwrite(&mapaLiberado,sizeof(int),1,saveJogo); //como mapa liberado comeca com 1, entao escrevo nele
     }
     fseek(saveJogo, 0, SEEK_SET); //posiciona no inicio do arquivo
     
     //salva no arquivo
     fread(&mapaLiberado,sizeof(int),1,saveJogo); //atribui o valor q esta no arquivo ao mapaLiberado
     fclose(saveJogo);
	
	
	int cc = 0, ca = 0;
	int i=223,k=1600;
	int iNaTela = 0, kNaTela = 0;
	int ladoEsq=0,ladoDir=1;
    	
	FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);

	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);
			
			if(key[KEY_L])
                  mapaLiberado = 10;
        /* CODIGO */
                
// DESENHA MENU-----------------------------------------------------------

            draw_sprite( buffer, logo, 0, 0);
            
            if(mouse_x <= 465 && mouse_x >= 335)
                   if(mouse_y <= 390 && mouse_y >= 350)
                       draw_sprite( buffer, selecionado, 285, 355);
            if(mouse_x <= 445 && mouse_x >= 340)
                   if(mouse_y <= 500 && mouse_y >= 460)
                       draw_sprite( buffer, selecionado, 285, 465);
                       
            if(mouse_x <= 795 && mouse_x >= 680)
                   if(mouse_y <= 35 && mouse_y >= 7)
                       draw_sprite( buffer, selecionadoF, 660, 15);
                   

//VERIFICA CLICK DO MOUSE---------------------------------------------------
            if ( mouse_b & 1 )
            {
                // Verifica Jogar 
                if(mouse_x <= 465 && mouse_x >= 335)
                   if(mouse_y <= 390 && mouse_y >= 350)
                      fases();
                      //jogar(map1);
                // Verifica Sair
                if(mouse_x <= 445 && mouse_x >= 340)
                   if(mouse_y <= 500 && mouse_y >= 460)
                      FecharJogo=1;  
                      
                if(mouse_x <= 795 && mouse_x >= 680)
                   if(mouse_y <= 35 && mouse_y >= 7)
                      if (is_windowed_mode())
                       {
                          set_gfx_mode(GFX_AUTODETECT_FULLSCREEN, TELA_L, TELA_A, 0, 0);
                       }
                       else
                       {
                           set_gfx_mode(GFX_AUTODETECT_WINDOWED, TELA_L, TELA_A, 0, 0);
                       }             
            }
          /*  	
           textprintf_ex(buffer, font, 10, SCREEN_H - 40, makecol(230, 230, 230), -1, "Mouse: %d", mouse_b); 
           textprintf_ex(buffer, font, 10, SCREEN_H - 60, makecol(230, 230, 230), -1, "Mouse_x: %d, Mouse_y: %d", mouse_x, mouse_y);           	
          */
//FAZ RODAPÉ PISCAR---------------------------------------------------------
            if (ca == 0)
            {
                 if (++cc == 254)
                 {
                    ca = 1;
                 }
            }
            else
            {
                 if (--cc == 0)
                 {
                    ca = 0;
                 }
            }/* makecol(cc, cc, 0)*/
            
           rectfill(buffer,0,582,800,595,makecol(30,30,30));
           
           // Outro Codigo de apresentação; Trocar o I para 800
           
           /* 
            i--;
            if(i==-800)
                i=800;
            k--;
            if(k==-800)
                k=800;
                               
            textprintf_ex(buffer, font, i, TELA_A-15,makecol(150,150,150), -1,
            "Criado por Mateus Ferreira - IFET Campus Barbacena 2011"); 
            
            textprintf_ex(buffer, font, k, TELA_A-15,makecol(150,150,150), -1,
            "Criado por Mateus Ferreira - IFET Campus Barbacena 2011"); 
            */
            
            
            if(i==0)
            {
              ladoEsq = 1;
              ladoDir = 0;
              i+=1;
            }
            else
            if(i==223)
            {
              ladoDir = 1;
              ladoEsq = 0;
            }
            
            if(ladoDir)
                i--;
            else
                i++;                 
            textprintf_ex(buffer, font, i, TELA_A-15,makecol(150,150,150), -1,
            "Criado por Mateus Ferreira - IFET Campus Barbacena 2011 // Mapas Sokobox"); 
           

//IMPRIME FRAPS -----------------------------------------------------------------
		//	textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
//IMPRIME CURSOR NA TELA --------------------------------------------------------            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
/* FIM DO CODIGO PRINCIPAL */
//pega o buffer----------------------------------------------------------------
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
//Atualiza a tela---------------------------------------------------------------
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}

	deinicia_allegro();
	return 0;
}
END_OF_MAIN()
//---------------------------------------------------------------------------
void jogar(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 9;
    box.y = 6;
    boxCoordenadas box2;
    box2.x = 9;
    box2.y = 5;
    boxCoordenadas box3;
    box3.x = 10;
    box3.y = 5;
    boxCoordenadas box4;
    box4.x = 10;
    box4.y = 7;
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 9;
    boxAnt.y = 6; 
    boxCoordenadas box2Ant;
    box2Ant.x = 9;
    box2Ant.y = 5;  
    boxCoordenadas box3Ant;
    box3Ant.x = 10;
    box3Ant.y = 5;  
    boxCoordenadas box4Ant;
    box4Ant.x = 10;
    box4Ant.y = 7;
    
    haxBoneco hax;
	hax.x = 10;
	hax.y = 6;
	
	haxBoneco haxAnt;
	haxAnt.x = 10;
	haxAnt.y = 6;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;      
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
         
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
            box.x = 9;
            box.y = 6;

            box2.x = 9;
            box2.y = 5;

            box3.x = 10;
            box3.y = 5;
            
            box4.x = 10;
            box4.y = 7;
            
            boxAnt.x = 9;
            boxAnt.y = 6; 

            box2Ant.x = 9;
            box2Ant.y = 5;  

            box3Ant.x = 10;
            box3Ant.y = 5;  

            box4Ant.x = 10;
            box4Ant.y = 7;
            
         	hax.x = 10;
        	hax.y = 6;

        	haxAnt.x = 10;
        	haxAnt.y = 6;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);         
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,1);
              while(!key[KEY_ENTER]);         
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------

void inicia_allegro() {
	int profundidade, res;
	allegro_init();
	install_pmask();
	install_timer();
	install_keyboard();
	clear_keybuf();
	install_mouse();
	
	set_uformat(U_ASCII); // Habilita acentuação em ALGUMAS FONTES
	/*profundidade = desktop_color_depth();
	if (profundidade == 0) profundidade = 32;
	   set_color_depth(profundidade);*/
	
	//roda configuracao de um arquivo
	set_config_file("config.txt");
	
	profundidade = get_config_int("Inicializacao", "colordepth",32);
	set_color_depth(profundidade); //padrao é 32 bits
	
	volume=get_config_int("Inicializacao", "volume", 128); //usa as config de volume do arquivo
	
	#define GFX_BWINDOWSCREEN_ACCEL AL_ID('B','W','S','A')
	#define GFX_BWINDOWSCREEN        AL_ID('B','W','S',' ')
    AL_VAR(GFX_DRIVER, gfx_beos_bwindowscreen_accel);
    AL_VAR(GFX_DRIVER, gfx_beos_bwindowscreen);

	vSync = get_config_int("Inicializacao", "vsync",0);
	resolucaoX = get_config_int("Inicializacao", "resolucaox",800);
	resolucaoY = get_config_int("Inicializacao", "resolucaoy",600);
    //Fullscreen
    //res = set_gfx_mode(GFX_AUTODETECT_FULLSCREEN & GFX_BWINDOWSCREEN_ACCEL, resolucaoX, resolucaoY, 0, 0);
    //Janela
    if(Janela == 1)
        res = set_gfx_mode(GFX_AUTODETECT_WINDOWED, TELA_L, TELA_A, 0, 0); 
    else 
        res = set_gfx_mode(GFX_AUTODETECT_FULLSCREEN, TELA_L, TELA_A, 0, 0);   
	if (res != 0) {
		allegro_message(allegro_error);
		exit(-1);
	}
	if(install_sound(DIGI_AUTODETECT, MIDI_AUTODETECT, NULL))
    {
        allegro_message("Sound Error: %s", allegro_error);
    }
	
	//inicializa o metodo de atualizacao
	initialize_screen_updating(get_config_int("Inicializacao", "updatemethod", UPDATE_TRIPLE_BUFFER));
    
    set_window_title("Hax Box"); //nome da Janela
    
    set_display_switch_mode(SWITCH_BACKGROUND); //roda o allegro em segundo plano
    
    //Botao fechar
    LOCK_FUNCTION(BotaoFechar); 
    set_close_button_callback(BotaoFechar);
	
	//Contador de frames
	// Faz o lock das variaveis usadas pela funcao de timer e da propria funcao 
    LOCK_VARIABLE(fps); 
    LOCK_VARIABLE(contFrames); 
    LOCK_FUNCTION(funcFPS);
	//chama a funcao funcFPS
	install_int_ex(funcFPS,BPS_TO_TIMER(MAXFPS)); //Frames por segundo, 60FPS
	//chama a funcao funcTempo
	LOCK_VARIABLE(contTempo); 
    LOCK_FUNCTION(funcTempo);
	install_int(funcTempo, 1000); //Timer "ticks" a cada mil milisegundos, ou seja, 1 segundo
 
	/* adicione outras iniciacoes aqui */
}
//---------------------------------------------------------------------
void deinicia_allegro() {
	clear_keybuf();
	//salvando o arquivo de configuracao
	set_config_int("Inicializacao", "volume", volume);
	set_config_int("Inicializacao", "vsync", vSync);
	if (get_update_method())
    {
        shutdown_screen_updating();
    }
	//fechando o allegro
	allegro_exit();
	/* adicione outras deiniciacoes aqui */
}
//---------------------------------------------------------------------------
void BotaoFechar(void) 
{ 
   FecharJogo = TRUE; 
} 
END_OF_FUNCTION(BotaoFechar)
//---------------------------------------------------------------------------
//Contador Frames Por Segundo
void funcFPS(void) 
{ 
	contFrames++; 
} 
END_OF_FUNCTION(funcFPS); 
//Fim Contador FPS

//---------------------------------------------------------------------------
//Contador de tempo
void funcTempo(void) 
{ 
/*fps = contFrames; 
contFrames = 0;*/
	fpsT++;
	contTempo++;
} 
END_OF_FUNCTION(funcTempo); 

//---------------------------------------------------------------------------
BITMAP *makeCursor()
{
   BITMAP *ret = create_bitmap(20, 20);
   
   clear_to_color(ret, makecol(255,0,255));
   
   line(ret, 0, 0, 5, 17, makecol(0, 100, 0));
   line(ret, 1, 1, 6, 18, makecol(0, 150, 0));
   line(ret, 2, 2, 7, 19, makecol(0, 200, 0));
   line(ret, 3, 3, 8, 20, makecol(0, 255, 0));

   line(ret, 0, 0, 17, 5, makecol(0, 100, 0));
   line(ret, 1, 1, 18, 6, makecol(0, 150, 0));
   line(ret, 2, 2, 19, 7, makecol(0, 200, 0));
   line(ret, 3, 3, 20, 8, makecol(0, 255, 0));
   
   circle(ret,20,20,11,makecol(0, 255, 0));
   circle(ret,20,20,9,makecol(0, 200, 0)); 
   circle(ret,20,20,7,makecol(0, 150, 0)); 
   
   circlefill(ret,10,10,1,makecol(0, 255, 0));     
  
   return ret;
}
//-----------------------------------------------------------------------------
void fases()
{    
     BITMAP *buffer = create_bitmap( TELA_L, TELA_A );
     BITMAP *stgs = load_bitmap("img/stgs.bmp",pl);
     BITMAP *setaDir = load_bitmap("img/setaDir.bmp",pl);
     BITMAP *setaDir2 = load_bitmap("img/setaDir2.bmp",pl);
     BITMAP *novoJogo = load_bitmap("img/novo jogo.bmp",pl);
     BITMAP *cadeado = load_gif("img/cadeado.gif",pl);
     BITMAP *fundo = load_bitmap("img/telaNovoJogo.bmp",pl);
     BITMAP *sim = load_bitmap("img/sim.bmp",pl);
     BITMAP *nao = load_bitmap("img/nao.bmp",pl);
     
	 BITMAP *cursor = makeCursor();
	 
	 FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
	 
	 mouse_b = 0;
	 int x,y = 0;
	 
	 int novoJogoAtivo = 0;
	 int imprimeFor = 1;
	int i=360;
	 int ladoEsq=0,ladoDir=1;
	 
	 while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);
			
			
        /* CODIGO */
        
// DESENHA MENU-----------------------------------------------------------

            draw_sprite( buffer, stgs, 0, 0);  
// IMPRE SETAS -----------------------------------------------------------------
         draw_sprite( buffer, setaDir, 390, 495);
         
         if(mouse_x <= 448 && mouse_x >= 400)
                   if(mouse_y <= 526 && mouse_y >= 508)
                              draw_sprite( buffer, setaDir2, 390, 495);    
         
         if ( mouse_b & 1 )
            {
                // Fase Especial
                  if(mouse_x <= 448 && mouse_x >= 400)
                   if(mouse_y <= 526 && mouse_y >= 508)
                      fases2(); 
            } 

//VERIFICA CLICK DO MOUSE---------------------------------------------------
           if(!novoJogoAtivo)
           {
            if ( mouse_b & 1 )
            {
                // Fase 01
                if(mouse_x <= 180 && mouse_x >= 35)
                   if(mouse_y <= 215 && mouse_y >= 70)
                      jogar(map1); 
            }
            if ( mouse_b & 1 && mapaLiberado > 1)
            {               
                // Fase 02 
                if(mouse_x <= 357 && mouse_x >= 181)
                   if(mouse_y <= 215 && mouse_y >= 70)
                      jogar2(map2); 
            }
            if ( mouse_b & 1 && mapaLiberado > 2)
            {     
                // Fase 03
                if(mouse_x <= 570 && mouse_x >= 358)
                   if(mouse_y <= 215 && mouse_y >= 70)
                      jogar3(map3);         
            }
            if ( mouse_b & 1 && mapaLiberado > 3)
            {     
                // Fase 04
                 if(mouse_x <= 755 && mouse_x >= 570)
                   if(mouse_y <= 215 && mouse_y >= 60)
                      jogar4(map4);         
            }
            if ( mouse_b & 1 && mapaLiberado > 4)
            {     
                // Fase 05
                 if(mouse_x <= 178 && mouse_x >= 5)
                   if(mouse_y <= 420 && mouse_y >= 270)
                      jogar5(map5);         
            }
            if ( mouse_b & 1 && mapaLiberado > 5)
            {     
                // Fase 06
                 if(mouse_x <= 368 && mouse_x >= 178)
                   if(mouse_y <= 420 && mouse_y >= 270)
                      jogar6(map6);         
            }
            if ( mouse_b & 1 && mapaLiberado > 6)
            {     
                // Fase 07
                 if(mouse_x <= 530 && mouse_x >= 385)
                   if(mouse_y <= 420 && mouse_y >= 270)
                      jogar7(map7);         
            }
            if ( mouse_b & 1 && mapaLiberado > 7)
            {     
                // Fase 08
                 if(mouse_x <= 756 && mouse_x >= 560)
                   if(mouse_y <= 420 && mouse_y >= 270)
                      jogar8(map8);         
            }
            
               
            //fase 01  	
            if(mouse_x <= 180 && mouse_x >= 35)
                   if(mouse_y <= 215 && mouse_y >= 70)
                   {
                      rect(buffer,35,70,180,215,makecol(255,255,255));
                   }
            //fase 02
            if(mouse_x <= 357 && mouse_x >= 181)
                   if(mouse_y <= 215 && mouse_y >= 70)
                   {
                      rect(buffer,181,70,357,215,makecol(255,255,255));
                   }
            // Fase 03
            if(mouse_x <= 570 && mouse_x >= 358)
                   if(mouse_y <= 215 && mouse_y >= 70)
                   {
                      rect(buffer,358,70,570,215,makecol(255,255,255));
                   } 
            // Fase 04
            if(mouse_x <= 755 && mouse_x >= 570)
                   if(mouse_y <= 215 && mouse_y >= 60)
                   {
                      rect(buffer,570,60,755,215,makecol(255,255,255));
                   } 
             // Fase 05
            if(mouse_x <= 178 && mouse_x >= 5)
                   if(mouse_y <= 420 && mouse_y >= 270)
                   {
                      rect(buffer,5,270,178,420,makecol(255,255,255));
                   } 
            // Fase 06
            if(mouse_x <= 368 && mouse_x >= 178)
                   if(mouse_y <= 420 && mouse_y >= 270)
                   {
                      rect(buffer,368,270,178,420,makecol(255,255,255));
                   } 
            // Fase 07
            if(mouse_x <= 530 && mouse_x >= 385)
                   if(mouse_y <= 420 && mouse_y >= 270)
                   {
                      rect(buffer,530,270,385,420,makecol(255,255,255));
                   }
            // Fase 08
            if(mouse_x <= 756 && mouse_x >= 560)
                   if(mouse_y <= 420 && mouse_y >= 270)
                   {
                      rect(buffer,756,270,560,420,makecol(255,255,255));
                   }
           }// fim do if !novoJogoAtivo         
          /*        
            textprintf_ex(buffer, font, 200, SCREEN_H - 40, makecol(230, 230, 230), -1, "Mouse: %d", mouse_b);
            textprintf_ex(buffer, font, 200, SCREEN_H - 60, makecol(230, 230, 230), -1, "Mouse_x: %d, Mouse_y: %d", mouse_x, mouse_y);           	
            */
// DESENHA CADEADOS-----------------------------------------------------------

           if(mapaLiberado < 2)
            draw_sprite( buffer, cadeado, 220, 220);
           if(mapaLiberado < 3)
            draw_sprite( buffer, cadeado, 415, 220);
           if(mapaLiberado < 4)
            draw_sprite( buffer, cadeado, 629, 220);
           if(mapaLiberado < 5)
            draw_sprite( buffer, cadeado, 55, 429);
           if(mapaLiberado < 6)
            draw_sprite( buffer, cadeado, 220, 429);
           if(mapaLiberado < 7)
            draw_sprite( buffer, cadeado, 415, 429);
           if(mapaLiberado < 8)
            draw_sprite( buffer, cadeado, 629, 429);      
            
//NOVO JOGO ------------------------------------------------------------------
             if(mouse_x <= 145 && mouse_x >= 40)
                   if(mouse_y <= 565 && mouse_y >= 550)
                       draw_sprite( buffer, novoJogo, 35, 545);
                       
             if ( mouse_b & 1 )
             {
                if(mouse_x <= 145 && mouse_x >= 40)
                   if(mouse_y <= 565 && mouse_y >= 550)
                   {  
                     novoJogoAtivo = 1;                                                                                               
                   }
             }
             
             if(novoJogoAtivo)
             {
               if(imprimeFor)
               {
                for(x = 0,y = 0; x <= 170; x++)
                {
                    if(x%2==0)
                       y++; 
                     rectfill(buffer,400-x,300-y,400+x,300+y,makecol(0,0,0));
                     rect(buffer,400-x,300-y,400+x,300+y,makecol(255,255,255));
                     rect(buffer,399-x,299-y,401+x,301+y,makecol(200,200,200));
                     rect(buffer,398-x,298-y,402+x,302+y,makecol(150,150,150));
                     
                     //rest(1);
                     
               		//pega o buffer
            		if (get_update_method())
            		{
            			buffer = get_buffer();
            		}
            		else
            		{
            			buffer = screen;
            			if (vsync_is_enabled())
            			{
            				vsync();
            			}
            		}
            		release_bitmap(buffer);
            		//Atualiza a tela
            		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
            		if (get_update_method())
            		{
            			update_screen();
            		}
            		else
            		{
            			// já está na tela
            		}	
                     
                }
                imprimeFor = 0;
              }
                    rectfill(buffer,400-x,300-y,400+x,300+y,makecol(0,0,0));
                    rect(buffer,400-x,300-y,400+x,300+y,makecol(255,255,255));
                    rect(buffer,399-x,299-y,401+x,301+y,makecol(200,200,200));
                    rect(buffer,398-x,298-y,402+x,302+y,makecol(150,150,150));
                    
                    draw_sprite( buffer, fundo, 280, 225);
                    
                if(mouse_x <= 342 && mouse_x >= 300)
                   if(mouse_y <= 360 && mouse_y >= 338)
                       draw_sprite( buffer, sim, 300, 335);
                       
                if(mouse_x <= 500 && mouse_x >= 450)
                   if(mouse_y <= 360 && mouse_y >= 338)
                       draw_sprite( buffer, nao, 450, 332);
                
                 if ( mouse_b & 1 )
                 {        
                    if(mouse_x <= 342 && mouse_x >= 300)
                       if(mouse_y <= 360 && mouse_y >= 338)
                       {
                         mapaLiberado = 1;
                         FILE *saveJogo;
                         saveJogo = fopen("save.bin","r+b");
                         if(!saveJogo)
                         {
                           saveJogo = fopen("save.bin","w+b");
                         }
                         fseek(saveJogo, 0, SEEK_SET); //posiciona no inicio do arquivo
                         
                         //salva no arquivo
                         fwrite(&mapaLiberado,sizeof(int),1,saveJogo); //escreve no arquivo
                         fclose(saveJogo);
                         novoJogoAtivo = 0;
                          mouse_b = 0;
                       }
                 }
                 if ( mouse_b & 1 )
                 {        
                    if(mouse_x <= 500 && mouse_x >= 450)
                       if(mouse_y <= 360 && mouse_y >= 338)                      
                         novoJogoAtivo = 0;
                          mouse_b = 0;
                 }
    
                    line(buffer,270,309,530,309,makecol(150, 150, 150));
                    //line(screen,220,214,560,214,makecol(200, 200, 200));
                    line(buffer,270,310,530,310,makecol(255, 255, 255));
                    //line(screen,220,216,560,216,makecol(200, 200, 200));
                    line(buffer,270,311,530,311,makecol(150, 150, 150));
                    
                    //draw_sprite(buffer, cursor, mouse_x, mouse_y);
             }else
                imprimeFor = 1;
                     
//IMPRIME CURSOR NA TELA --------------------------------------------------------            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            

/* FIM DO CODIGO PRINCIPAL */
//pega o buffer----------------------------------------------------------------
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
//Atualiza a tela---------------------------------------------------------------
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	key[KEY_ESC] = 0;
}
//-----------------------------------------------------------------------------
void fases2()
{
     BITMAP *buffer = create_bitmap( TELA_L, TELA_A );
     BITMAP *stgs = load_bitmap("img/stgs2.bmp",pl);
     BITMAP *bonus = load_bitmap("img/bonus.bmp",pl);
     BITMAP *setaEsq = load_bitmap("img/setaEsq.bmp",pl);
     BITMAP *setaEsq2 = load_bitmap("img/setaEsq2.bmp",pl);
     BITMAP *cadeado = load_gif("img/cadeado.gif",pl);
	 BITMAP *cursor = makeCursor();
	 
	 FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
	 
	 mouse_b = 0;
	 
	 int i=360;
	 int ladoEsq=0,ladoDir=1;
	 int voltou = 0;
	 
	 while (!key[KEY_ESC] && !FecharJogo && !voltou)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0 && !voltou)
		{
			acquire_bitmap(buffer);
			clear(buffer);
			
			
        /* CODIGO */
        
// DESENHA MENU-----------------------------------------------------------

            draw_sprite( buffer, stgs, 0, 0);  
// IMPRE SETAS -----------------------------------------------------------------
         draw_sprite( buffer, setaEsq, 330, 495);
         
         if(mouse_x <= 388 && mouse_x >= 340)
                   if(mouse_y <= 526 && mouse_y >= 508)
                              draw_sprite( buffer, setaEsq2, 330, 495);
         
         if ( mouse_b & 1)
            {
                // Fase Especial
                if(mouse_x <= 388 && mouse_x >= 340)
                   if(mouse_y <= 526 && mouse_y >= 508)
                      //fases(); 
                      //key[KEY_ESC] = 1;
                      voltou = 1;
            }      

//VERIFICA CLICK DO MOUSE---------------------------------------------------
            if ( mouse_b & 1 && mapaLiberado > 8)
            {
                // Fase 09
                 if(mouse_x <= 530 && mouse_x >= 275)
                   if(mouse_y <= 343 && mouse_y >= 150)
                      jogar9(map9); 
            } 
            if ( mouse_b & 1 && mapaLiberado > 9)
            {
                // Fase 10
                if(mouse_x <= 780 && mouse_x >= 695 && mouse_y <= 570 && mouse_y >= 525 )
                      jogar10(map10);
            }else
            if( mouse_b & 1 && mapaLiberado < 9 && mouse_x <= 780 && mouse_x >= 695 && mouse_y <= 570 && mouse_y >= 525 )    
                allegro_message("Você precisa completar todos os outros níveis para habilitar a fase bônus !!! ");  
            mouse_b = 0;
                  
            //fase 01  	
            if(mouse_x <= 530 && mouse_x >= 275)
                   if(mouse_y <= 343 && mouse_y >= 150)
                   {
                      rect(buffer,530,343,275,150,makecol(255,255,255));
                   }
          /*   
            textprintf_ex(buffer, font, 10, SCREEN_H - 40, makecol(230, 230, 230), -1, "Mouse: %d", mouse_b);
           textprintf_ex(buffer, font, 10, SCREEN_H - 60, makecol(230, 230, 230), -1, "Mouse_x: %d, Mouse_y: %d", mouse_x, mouse_y);           	
           */
 
// IMPRIME BÔNUS -------------------------------------------------------------
             if(mouse_x <= 780 && mouse_x >= 695)
               if(mouse_y <= 570 && mouse_y >= 525)
                          draw_sprite( buffer, bonus, 690, 520);          
// DESENHA CADEADOS-----------------------------------------------------------
      
           if(mapaLiberado < 9)
            draw_sprite( buffer, cadeado, 360, 346);
//IMPRIME CURSOR NA TELA --------------------------------------------------------            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);

/* FIM DO CODIGO PRINCIPAL */
//pega o buffer----------------------------------------------------------------
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
//Atualiza a tela---------------------------------------------------------------
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	key[KEY_ESC] = 0;
}
void fimDeFase(int minuto,int segundo,int movimentos,int passos,int fase)
{
     if(fase == mapaLiberado)
             mapaLiberado++;
     
     FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
     FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
     BITMAP *parabens = load_bitmap("img/parabens.bmp",pl);
     BITMAP *hax = load_gif("img/haxFrente.gif",pl);
     BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
     
     FILE *saveJogo;
     saveJogo = fopen("save.bin","r+b");
     if(!saveJogo)
     {
       saveJogo = fopen("save.bin","w+b");
     }
     fseek(saveJogo, 0, SEEK_SET); //posiciona no inicio do arquivo
     
     //salva no arquivo
     fwrite(&mapaLiberado,sizeof(int),1,saveJogo); //escreve no arquivo
     fclose(saveJogo);
     
    acquire_bitmap(buffer);
	clear(buffer);
	
    int x,y ;
    for(x = 0, y = 0; x <= 230; x++, y--)
    {
         rectfill(buffer,400-x,300-y,400+x,300+y,makecol(0,0,0));
         rect(buffer,400-x,300-y,400+x,300+y,makecol(255,255,255));
         rect(buffer,399-x,299-y,401+x,301+y,makecol(200,200,200));
         rect(buffer,398-x,298-y,402+x,302+y,makecol(150,150,150));
         
         //rest(1);
         
   		//pega o buffer
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}
		release_bitmap(buffer);
		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}	
         
    }
    
    draw_sprite( buffer, parabens, 280, 100);
        
    line(buffer,220,214,580,214,makecol(150, 150, 150));
    //line(screen,220,214,560,214,makecol(200, 200, 200));
    line(buffer,220,215,580,215,makecol(255, 255, 255));
    //line(screen,220,216,560,216,makecol(200, 200, 200));
    line(buffer,220,216,580,216,makecol(150, 150, 150));
    
    textprintf_ex(buffer, CooperBlack, 260,260, makecol(181, 230, 29), -1, "Tempo");
 
    if(minuto < 10)
    textprintf_ex(buffer, CooperBlack, 390,260, makecol(63, 72, 204), -1, "0%d ",minuto);
    else
    textprintf_ex(buffer, CooperBlack, 390,260, makecol(63, 72, 204), -1, "%d",minuto);
    
    textprintf_ex(buffer, CooperBlack, 415,260, makecol(63, 72, 204), -1, " : ");
    
    if(segundo < 10)
    textprintf_ex(buffer, CooperBlack, 443,260, makecol(63, 72, 204), -1, "0%d ",segundo);
    else
    textprintf_ex(buffer, CooperBlack, 443,260, makecol(63, 72, 204), -1, "%d",segundo);
    
    textprintf_ex(buffer, CooperBlack, 260, 320, makecol(181, 230, 29), -1, "Passos");    
    textprintf_ex(buffer, CooperBlack, 390, 320, makecol(63, 72, 204), -1, "%d",passos);
    
    textprintf_ex(buffer, CooperBlack, 260, 380, makecol(181, 230, 29), -1, "Movimentos");           
    textprintf_ex(buffer, CooperBlack, 470, 380, makecol(63, 72, 204), -1, "%d",movimentos);
    
    textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 480,makecol(255, 255, 255), -1,"Pressione ENTER para continuar");
    
    draw_sprite( buffer, hax, 220, 470);
    draw_sprite( buffer, hax, 555, 470);
    
	//pega o buffer
	if (get_update_method())
	{
		buffer = get_buffer();
	}
	else
	{
		buffer = screen;
		if (vsync_is_enabled())
		{
			vsync();
		}
	}
	release_bitmap(buffer);
	//Atualiza a tela
	//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
	if (get_update_method())
	{
		update_screen();
	}
	else
	{
		// já está na tela
	}
}
//---------------------------------------------------------------------------
void jogar2(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 10;
    box.y = 7;
    boxCoordenadas box2;
    box2.x = 10;
    box2.y = 4;

    
    boxCoordenadas boxAnt; 
    boxAnt.x = 10;
    boxAnt.y = 7; 
    boxCoordenadas box2Ant;
    box2Ant.x = 10;
    box2Ant.y = 4;  

    
    haxBoneco hax;
	hax.x = 8;
	hax.y = 4;
	
	haxBoneco haxAnt;
	haxAnt.x = 8;
	haxAnt.y = 4;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
     
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
      
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {

            box.x = 10;
            box.y = 7;

            box2.x = 10;
            box2.y = 4;
            
            boxAnt.x = 10;
            boxAnt.y = 7; 

            box2Ant.x = 10;
            box2Ant.y = 4;  

         	hax.x = 8;
        	hax.y = 4;

        	haxAnt.x = 8;
        	haxAnt.y = 4;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);     
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 

                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                               
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
                
            if(caixaNoVerde && caixaNoVerde2 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,2);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar3(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 7;
    box.y = 4;
    boxCoordenadas box2;
    box2.x = 9;
    box2.y = 5;
    boxCoordenadas box3;
    box3.x = 12;
    box3.y = 5;
    boxCoordenadas box4;
    box4.x = 11;
    box4.y = 6;
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 7;
    boxAnt.y = 4; 
    boxCoordenadas box2Ant;
    box2Ant.x = 9;
    box2Ant.y = 5;  
    boxCoordenadas box3Ant;
    box3Ant.x = 12;
    box3Ant.y = 5;  
    boxCoordenadas box4Ant;
    box4Ant.x = 11;
    box4Ant.y = 6;
    
    haxBoneco hax;
	hax.x = 7;
	hax.y = 5;
	
	haxBoneco haxAnt;
	haxAnt.x = 7;
	haxAnt.y = 5;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;      
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
       
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          { 
            box.x = 7;
            box.y = 4;

            box2.x = 9;
            box2.y = 5;

            box3.x = 12;
            box3.y = 5;
            
            box4.x = 11;
            box4.y = 6;
            
            boxAnt.x = 7;
            boxAnt.y = 4; 

            box2Ant.x = 9;
            box2Ant.y = 5;  

            box3Ant.x = 12;
            box3Ant.y = 5;  

            box4Ant.x = 11;
            box4Ant.y = 6;
            
         	hax.x = 7;
        	hax.y = 5;

        	haxAnt.x = 7;
        	haxAnt.y = 5;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);         
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,3);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar4(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 9;
    box.y = 6;
    boxCoordenadas box2;
    box2.x = 9;
    box2.y = 5;
    boxCoordenadas box3;
    box3.x = 9;
    box3.y = 4;

    
    boxCoordenadas boxAnt; 
    boxAnt.x = 9;
    boxAnt.y = 6; 
    boxCoordenadas box2Ant;
    box2Ant.x = 9;
    box2Ant.y = 5;  
    boxCoordenadas box3Ant;
    box3Ant.x = 9;
    box3Ant.y = 4;  

    
    haxBoneco hax;
	hax.x = 6;
	hax.y = 4;
	
	haxBoneco haxAnt;
	haxAnt.x = 6;
	haxAnt.y = 4;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
     
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
       
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
            box.x = 9;
            box.y = 6;

            box2.x = 9;
            box2.y = 5;

            box3.x = 9;
            box3.y = 4;
            
            boxAnt.x = 9;
            boxAnt.y = 6; 

            box2Ant.x = 9;
            box2Ant.y = 5;  

            box3Ant.x = 9;
            box3Ant.y = 4;  
            
         	hax.x = 6;
        	hax.y = 4;

        	haxAnt.x = 6;
        	haxAnt.y = 4;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);      
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                }              
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;

                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,4);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar5(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 7;
    box.y = 4;
    boxCoordenadas box2;
    box2.x = 8;
    box2.y = 4;
    boxCoordenadas box3;
    box3.x = 9;
    box3.y = 4;

    
    boxCoordenadas boxAnt; 
    boxAnt.x = 7;
    boxAnt.y = 4; 
    boxCoordenadas box2Ant;
    box2Ant.x = 8;
    box2Ant.y = 4;  
    boxCoordenadas box3Ant;
    box3Ant.x = 9;
    box3Ant.y = 4;  

    
    haxBoneco hax;
	hax.x = 7;
	hax.y = 3;
	
	haxBoneco haxAnt;
	haxAnt.x = 7;
	haxAnt.y = 3;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
     
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
     
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
            box.x = 7;
            box.y = 4;

            box2.x = 8;
            box2.y = 4;

            box3.x = 9;
            box3.y = 4;
            
            boxAnt.x = 7;
            boxAnt.y = 4; 

            box2Ant.x = 8;
            box2Ant.y = 4;  

            box3Ant.x = 9;
            box3Ant.y = 4;  
            
         	hax.x = 7;
        	hax.y = 3;

        	haxAnt.x = 7;
        	haxAnt.y = 3;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);      
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                }              
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;

                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,5);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar6(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 7;
    box.y = 4;
    boxCoordenadas box2;
    box2.x = 7;
    box2.y = 6;
    boxCoordenadas box3;
    box3.x = 11;
    box3.y = 4;
    boxCoordenadas box4;
    box4.x = 11;
    box4.y = 6;
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 7;
    boxAnt.y = 4; 
    boxCoordenadas box2Ant;
    box2Ant.x = 7;
    box2Ant.y = 6;  
    boxCoordenadas box3Ant;
    box3Ant.x = 11;
    box3Ant.y = 4;  
    boxCoordenadas box4Ant;
    box4Ant.x = 11;
    box4Ant.y = 6;
    
    haxBoneco hax;
	hax.x = 9;
	hax.y = 5;
	
	haxBoneco haxAnt;
	haxAnt.x = 9;
	haxAnt.y = 5;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;      
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
        
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
            box.x = 7;
            box.y = 4;

            box2.x = 7;
            box2.y = 6;

            box3.x = 11;
            box3.y = 4;
            
            box4.x = 11;
            box4.y = 6;
            
            boxAnt.x = 7;
            boxAnt.y = 4; 

            box2Ant.x = 7;
            box2Ant.y = 6;  

            box3Ant.x = 11;
            box3Ant.y = 4;  

            box4Ant.x = 11;
            box4Ant.y = 6;
            
         	hax.x = 9;
        	hax.y = 5;

        	haxAnt.x = 9;
        	haxAnt.y = 5;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);         
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4)
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,6);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar7(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 11;
    box.y = 5;
    boxCoordenadas box2;
    box2.x = 11;
    box2.y = 6;
    boxCoordenadas box3;
    box3.x = 10;
    box3.y = 6;

    
    boxCoordenadas boxAnt; 
    boxAnt.x = 11;
    boxAnt.y = 5; 
    boxCoordenadas box2Ant;
    box2Ant.x = 11;
    box2Ant.y = 6;  
    boxCoordenadas box3Ant;
    box3Ant.x = 10;
    box3Ant.y = 6;  

    
    haxBoneco hax;
	hax.x = 11;
	hax.y = 7;
	
	haxBoneco haxAnt;
	haxAnt.x = 11;
	haxAnt.y = 7;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
     
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
       
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
          
            box.x = 11;
            box.y = 5;

            box2.x = 11;
            box2.y = 6;

            box3.x = 10;
            box3.y = 6;
            
            boxAnt.x = 11;
            boxAnt.y = 5; 

            box2Ant.x = 11;
            box2Ant.y = 6;  

            box3Ant.x = 10;
            box3Ant.y = 6;  
            
         	hax.x = 11;
        	hax.y = 7;

        	haxAnt.x = 11;
        	haxAnt.y = 7;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);      
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                }              
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;

                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,7);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar8(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 9;
    box.y = 6;
    boxCoordenadas box2;
    box2.x = 7;
    box2.y = 5;
    boxCoordenadas box3;
    box3.x = 8;
    box3.y = 5;
    boxCoordenadas box4;
    box4.x = 9;
    box4.y = 5;
    boxCoordenadas box5;
    box5.x = 10;
    box5.y = 5;
    boxCoordenadas box6;
    box6.x = 11;
    box6.y = 5;
    boxCoordenadas box7;
    box7.x = 12;
    box7.y = 5;
    boxCoordenadas box8;
    box8.x = 13;
    box8.y = 5;
    
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 9;
    boxAnt.y = 6; 
    boxCoordenadas box2Ant;
    box2Ant.x = 7;
    box2Ant.y = 5;  
    boxCoordenadas box3Ant;
    box3Ant.x = 8;
    box3Ant.y = 5;  
    boxCoordenadas box4Ant;
    box4Ant.x = 9;
    box4Ant.y = 5;
    boxCoordenadas box5Ant;
    box5Ant.x = 10;
    box5Ant.y = 5;
    boxCoordenadas box6Ant;
    box6Ant.x = 11;
    box6Ant.y = 5;
    boxCoordenadas box7Ant;
    box7Ant.x = 12;
    box7Ant.y = 5;
    boxCoordenadas box8Ant;
    box8Ant.x = 13;
    box8Ant.y = 5;
    
    haxBoneco hax;
	hax.x = 12;
	hax.y = 3;
	
	haxBoneco haxAnt;
	haxAnt.x = 12;
	haxAnt.y = 3;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;
    BBcaixa BBbox5;
    BBcaixa BBbox6;
    BBcaixa BBbox7;
    BBcaixa BBbox8; 
         
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int caixaNoVerde5 = 0, caixaNoVerde6 = 0 , caixaNoVerde7 = 0 ,caixaNoVerde8 = 0;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
       
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y;
              
              box5.x = box5Ant.x;
              box5.y = box5Ant.y; 
              
              box6.x = box6Ant.x;
              box6.y = box6Ant.y;
              
              box7.x = box7Ant.x;
              box7.y = box7Ant.y;
              
              box8.x = box8Ant.x;
              box8.y = box8Ant.y;
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
            box.x = 9;
            box.y = 6;

            box2.x = 7;
            box2.y = 5;
        
            box3.x = 8;
            box3.y = 5;
            
            box4.x = 9;
            box4.y = 5;
         
            box5.x = 10;
            box5.y = 5;
            
            box6.x = 11;
            box6.y = 5;
       
            box7.x = 12;
            box7.y = 5;
           
            box8.x = 13;
            box8.y = 5;
           
            boxAnt.x = 9;
            boxAnt.y = 6; 
          
            box2Ant.x = 7;
            box2Ant.y = 5;  
            
            box3Ant.x = 8;
            box3Ant.y = 5;  
       
            box4Ant.x = 9;
            box4Ant.y = 5;
           
            box5Ant.x = 10;
            box5Ant.y = 5;
          
            box6Ant.x = 11;
            box6Ant.y = 5;
           
            box7Ant.x = 12;
            box7Ant.y = 5;
         
            box8Ant.x = 13;
            box8Ant.y = 5;
            
         	hax.x = 12;
        	hax.y = 3;

        	haxAnt.x = 12;
        	haxAnt.y = 3;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           
           if(caixaNoVerde5)
                draw_sprite( buffer, caixaVerde, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde6)
                draw_sprite( buffer, caixaVerde, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );   
                
           if(caixaNoVerde7)
                draw_sprite( buffer, caixaVerde, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
                
           if(caixaNoVerde8)
                draw_sprite( buffer, caixaVerde, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);
            // caixa 5
            BBbox5.left = box5.x*LARGURA_TILE;
            BBbox5.top = box5.y*LARGURA_TILE;
            BBbox5.right = (BBbox5.left + LARGURA_TILE);
            BBbox5.bottom = (BBbox5.top + LARGURA_TILE); 
            // caixa 6
            BBbox6.left = box6.x*LARGURA_TILE;
            BBbox6.top = box6.y*LARGURA_TILE;
            BBbox6.right = (BBbox6.left + LARGURA_TILE);
            BBbox6.bottom = (BBbox6.top + LARGURA_TILE); 
            // caixa 7
            BBbox7.left = box7.x*LARGURA_TILE;
            BBbox7.top = box7.y*LARGURA_TILE;
            BBbox7.right = (BBbox7.left + LARGURA_TILE);
            BBbox7.bottom = (BBbox7.top + LARGURA_TILE);
            // caixa 8
            BBbox8.left = box8.x*LARGURA_TILE;
            BBbox8.top = box8.y*LARGURA_TILE;
            BBbox8.right = (BBbox8.left + LARGURA_TILE);
            BBbox8.bottom = (BBbox8.top + LARGURA_TILE);           
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                  
                box5Ant.x = box5.x;
                box5Ant.y = box5.y;
                  
                box6Ant.x = box6.x;
                box6Ant.y = box6.y;
                  
                box7Ant.x = box7.x;
                box7Ant.y = box7.y;
                  
                box8Ant.x = box8.x;
                box8Ant.y = box8.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x-1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x-1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x-1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x-1 != box8.x) || (box.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x+1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x+1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x+1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x+1 != box8.x) || (box.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y-1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y-1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y-1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y-1 != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y+1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y+1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y+1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y+1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x-1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x-1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x-1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x-1 != box8.x) || (box2.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x+1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x+1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x+1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x+1 != box8.x) || (box2.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y-1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y-1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y-1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y+1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y+1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y+1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y+1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x-1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x-1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x-1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x-1 != box8.x) || (box3.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x+1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x+1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x+1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x+1 != box8.x) || (box3.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y-1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y-1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y-1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y+1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y+1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y+1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y+1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x-1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x-1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x-1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x-1 != box8.x) || (box4.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x+1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x+1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x+1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x+1 != box8.x) || (box4.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y-1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y-1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y-1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y+1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y+1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y+1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y+1 != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 5----------------------------------------------                 
                if(BBhax.left == BBbox5.right && hax.y == box5.y && key[KEY_LEFT] )
                {
                  if( ((box5.x-1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x-1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x-1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x-1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x-1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x-1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x-1 != box8.x) || (box5.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x-1] != 1)  
                       {         
                            box5.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox5.left && hax.y == box5.y && key[KEY_RIGHT] )
                {
                  if( ((box5.x+1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x+1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x+1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x+1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x+1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x+1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x+1 != box8.x) || (box5.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x+1] != 1)  
                       {         
                            box5.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox5.bottom && hax.x == box5.x && key[KEY_UP] )
                {
                  if( ((box5.x != box.x) || (box5.y-1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y-1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y-1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y-1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y-1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y-1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y-1][box5.x] != 1)  
                        {                  
                            box5.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox5.top && hax.x == box5.x && key[KEY_DOWN] )
                {               
                  if( ((box5.x != box.x) || (box5.y+1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y+1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y+1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y+1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y+1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y+1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y+1 != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y+1][box5.x] != 1)  
                        {                     
                            box5.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 6----------------------------------------------                 
                if(BBhax.left == BBbox6.right && hax.y == box6.y && key[KEY_LEFT] )
                {
                  if( ((box6.x-1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x-1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x-1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x-1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x-1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x-1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x-1 != box8.x) || (box6.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x-1] != 1)  
                       {         
                            box6.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox6.left && hax.y == box6.y && key[KEY_RIGHT] )
                {
                  if( ((box6.x+1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x+1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x+1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x+1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x+1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x+1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x+1 != box8.x) || (box6.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x+1] != 1)  
                       {         
                            box6.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox6.bottom && hax.x == box6.x && key[KEY_UP] )
                {
                  if( ((box6.x != box.x) || (box6.y-1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y-1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y-1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y-1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y-1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y-1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y-1][box6.x] != 1)  
                        {                  
                            box6.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox6.top && hax.x == box6.x && key[KEY_DOWN] )
                {               
                  if( ((box6.x != box.x) || (box6.y+1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y+1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y+1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y+1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y+1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y+1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y+1 != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y+1][box6.x] != 1)  
                        {                     
                            box6.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 7----------------------------------------------                 
                if(BBhax.left == BBbox7.right && hax.y == box7.y && key[KEY_LEFT] )
                {
                  if( ((box7.x-1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x-1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x-1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x-1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x-1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x-1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x-1 != box8.x) || (box7.y != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x-1] != 1)  
                       {         
                            box7.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox7.left && hax.y == box7.y && key[KEY_RIGHT] )
                {
                  if( ((box7.x+1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x+1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x+1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x+1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x+1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x+1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x+1 != box8.x) || (box7.y != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x+1] != 1)  
                       {         
                            box7.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox7.bottom && hax.x == box7.x && key[KEY_UP] )
                {
                  if( ((box7.x != box.x) || (box7.y-1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y-1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y-1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y-1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y-1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y-1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y-1 != box8.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y-1][box7.x] != 1)  
                        {                  
                            box7.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox7.top && hax.x == box7.x && key[KEY_DOWN] )
                {               
                  if( ((box7.x != box.x) || (box7.y+1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y+1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y+1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y+1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y+1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y+1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y+1 != box8.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y+1][box7.x] != 1)  
                        {                     
                            box7.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 8----------------------------------------------                 
                if(BBhax.left == BBbox8.right && hax.y == box8.y && key[KEY_LEFT] )
                {
                  if( ((box8.x-1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x-1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x-1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x-1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x-1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x-1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x-1 != box7.x) || (box8.y != box7.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x-1] != 1)  
                       {         
                            box8.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox8.left && hax.y == box8.y && key[KEY_RIGHT] )
                {
                  if( ((box8.x+1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x+1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x+1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x+1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x+1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x+1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x+1 != box7.x) || (box8.y != box7.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x+1] != 1)  
                       {         
                            box8.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox8.bottom && hax.x == box8.x && key[KEY_UP] )
                {
                  if( ((box8.x != box.x) || (box8.y-1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y-1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y-1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y-1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y-1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y-1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y-1 != box7.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y-1][box8.x] != 1)  
                        {                  
                            box8.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox8.top && hax.x == box8.x && key[KEY_DOWN] )
                {               
                  if( ((box8.x != box.x) || (box8.y+1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y+1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y+1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y+1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y+1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y+1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y+1 != box7.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y+1][box8.x] != 1)  
                        {                     
                            box8.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(map[box5.y][box5.x] == 3)
                caixaNoVerde5 = 1;
            else
                caixaNoVerde5 = 0;
                    
            if(map[box6.y][box6.x] == 3)
                caixaNoVerde6 = 1;
            else
                caixaNoVerde6 = 0;
                    
            if(map[box7.y][box7.x] == 3)
                caixaNoVerde7 = 1;
            else
                caixaNoVerde7 = 0;
                    
            if(map[box8.y][box8.x] == 3)
                caixaNoVerde8 = 1;
            else
                caixaNoVerde8 = 0;
                
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
             && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
       && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,8);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar9(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerde.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 7;
    box.y = 6;
    boxCoordenadas box2;
    box2.x = 7;
    box2.y = 7;
    boxCoordenadas box3;
    box3.x = 9;
    box3.y = 6;
    boxCoordenadas box4;
    box4.x = 9;
    box4.y = 4;
    boxCoordenadas box5;
    box5.x = 10;
    box5.y = 6;
    boxCoordenadas box6;
    box6.x = 10;
    box6.y = 4;
    boxCoordenadas box7;
    box7.x = 12;
    box7.y = 6;
    boxCoordenadas box8;
    box8.x = 13;
    box8.y = 6;
    boxCoordenadas box9;
    box9.x = 12;
    box9.y = 4;
    boxCoordenadas box10;
    box10.x = 12;
    box10.y = 3;
    
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 7;
    boxAnt.y = 6; 
    boxCoordenadas box2Ant;
    box2Ant.x = 7;
    box2Ant.y = 7;  
    boxCoordenadas box3Ant;
    box3Ant.x = 9;
    box3Ant.y = 6;  
    boxCoordenadas box4Ant;
    box4Ant.x = 9;
    box4Ant.y = 4;
    boxCoordenadas box5Ant;
    box5Ant.x = 10;
    box5Ant.y = 6;
    boxCoordenadas box6Ant;
    box6Ant.x = 10;
    box6Ant.y = 4;
    boxCoordenadas box7Ant;
    box7Ant.x = 12;
    box7Ant.y = 6;
    boxCoordenadas box8Ant;
    box8Ant.x = 13;
    box8Ant.y = 6;
    boxCoordenadas box9Ant;
    box9Ant.x = 12;
    box9Ant.y = 4;
    boxCoordenadas box10Ant;
    box10Ant.x = 12;
    box10Ant.y = 3;
    
    haxBoneco hax;
	hax.x = 5;
	hax.y = 6;
	
	haxBoneco haxAnt;
	haxAnt.x = 5;
	haxAnt.y = 6;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;
    BBcaixa BBbox5;
    BBcaixa BBbox6;
    BBcaixa BBbox7;
    BBcaixa BBbox8;
    BBcaixa BBbox9;
    BBcaixa BBbox10; 
         
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int caixaNoVerde5 = 0, caixaNoVerde6 = 0 , caixaNoVerde7 = 0 ,caixaNoVerde8 = 0;
    int caixaNoVerde9 = 0, caixaNoVerde10 = 0 ;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
      
          if(mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 102, 52 );
          }
          else
          draw_sprite( buffer, voltar2, 100, 50 );
             
          if(mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 57, 51 ); 
          }
          else
          draw_sprite( buffer, replay2, 55, 50 ); 
                  
          // Voltar movimento         
          if ( (mouse_b & 1 && mouse_x <= 135 && mouse_x >= 100 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y;
              
              box5.x = box5Ant.x;
              box5.y = box5Ant.y; 
              
              box6.x = box6Ant.x;
              box6.y = box6Ant.y;
              
              box7.x = box7Ant.x;
              box7.y = box7Ant.y;
              
              box8.x = box8Ant.x;
              box8.y = box8Ant.y;
              
              box9.x = box9Ant.x;
              box9.y = box9Ant.y;
              
              box10.x = box10Ant.x;
              box10.y = box10Ant.y;
          } 
          // Reiniciar fase 
          if( (mouse_b & 1 && mouse_x <= 90 && mouse_x >= 55 && mouse_y <= 80 && mouse_y >= 55) || key[KEY_R])
          {
           
                box.x = 7;
                box.y = 6;
            
                box2.x = 7;
                box2.y = 7;
               
                box3.x = 9;
                box3.y = 6;
         
                box4.x = 9;
                box4.y = 4;
               
                box5.x = 10;
                box5.y = 6;
              
                box6.x = 10;
                box6.y = 4;
             
                box7.x = 12;
                box7.y = 6;
             
                box8.x = 13;
                box8.y = 6;
        
                box9.x = 12;
                box9.y = 4;
            
                box10.x = 12;
                box10.y = 3;
            
                boxAnt.x = 7;
                boxAnt.y = 6; 
            
                box2Ant.x = 7;
                box2Ant.y = 7;  
           
                box3Ant.x = 9;
                box3Ant.y = 6;  
            
                box4Ant.x = 9;
                box4Ant.y = 4;
           
                box5Ant.x = 10;
                box5Ant.y = 6;
        
                box6Ant.x = 10;
                box6Ant.y = 4;
               
                box7Ant.x = 12;
                box7Ant.y = 6;
               
                box8Ant.x = 13;
                box8Ant.y = 6;
                
                box9Ant.x = 12;
                box9Ant.y = 4;
               
                box10Ant.x = 12;
                box10Ant.y = 3;              
               
            	hax.x = 5;
            	hax.y = 6;
            	       
            	haxAnt.x = 5;
            	haxAnt.y = 6;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           
           if(caixaNoVerde5)
                draw_sprite( buffer, caixaVerde, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde6)
                draw_sprite( buffer, caixaVerde, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );   
                
           if(caixaNoVerde7)
                draw_sprite( buffer, caixaVerde, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
                
           if(caixaNoVerde8)
                draw_sprite( buffer, caixaVerde, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde9)
                draw_sprite( buffer, caixaVerde, box9.x*LARGURA_TILE ,  box9.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box9.x*LARGURA_TILE ,  box9.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde10)
                draw_sprite( buffer, caixaVerde, box10.x*LARGURA_TILE ,  box10.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box10.x*LARGURA_TILE ,  box10.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);
            // caixa 5
            BBbox5.left = box5.x*LARGURA_TILE;
            BBbox5.top = box5.y*LARGURA_TILE;
            BBbox5.right = (BBbox5.left + LARGURA_TILE);
            BBbox5.bottom = (BBbox5.top + LARGURA_TILE); 
            // caixa 6
            BBbox6.left = box6.x*LARGURA_TILE;
            BBbox6.top = box6.y*LARGURA_TILE;
            BBbox6.right = (BBbox6.left + LARGURA_TILE);
            BBbox6.bottom = (BBbox6.top + LARGURA_TILE); 
            // caixa 7
            BBbox7.left = box7.x*LARGURA_TILE;
            BBbox7.top = box7.y*LARGURA_TILE;
            BBbox7.right = (BBbox7.left + LARGURA_TILE);
            BBbox7.bottom = (BBbox7.top + LARGURA_TILE);
            // caixa 8
            BBbox8.left = box8.x*LARGURA_TILE;
            BBbox8.top = box8.y*LARGURA_TILE;
            BBbox8.right = (BBbox8.left + LARGURA_TILE);
            BBbox8.bottom = (BBbox8.top + LARGURA_TILE); 
            // caixa 9
            BBbox9.left = box9.x*LARGURA_TILE;
            BBbox9.top = box9.y*LARGURA_TILE;
            BBbox9.right = (BBbox9.left + LARGURA_TILE);
            BBbox9.bottom = (BBbox9.top + LARGURA_TILE);  
            // caixa 10
            BBbox10.left = box10.x*LARGURA_TILE;
            BBbox10.top = box10.y*LARGURA_TILE;
            BBbox10.right = (BBbox10.left + LARGURA_TILE);
            BBbox10.bottom = (BBbox10.top + LARGURA_TILE);            
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                  
                box5Ant.x = box5.x;
                box5Ant.y = box5.y;
                  
                box6Ant.x = box6.x;
                box6Ant.y = box6.y;
                  
                box7Ant.x = box7.x;
                box7Ant.y = box7.y;
                  
                box8Ant.x = box8.x;
                box8Ant.y = box8.y;
                
                box9Ant.x = box9.x;
                box9Ant.y = box9.y;
                
                box10Ant.x = box10.x;
                box10Ant.y = box10.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x-1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x-1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x-1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x-1 != box8.x) || (box.y != box8.y)) &&
                      ((box.x-1 != box9.x) || (box.y != box9.y)) &&
                      ((box.x-1 != box10.x) || (box.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x+1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x+1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x+1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x+1 != box8.x) || (box.y != box8.y)) &&
                      ((box.x+1 != box9.x) || (box.y != box9.y)) &&
                      ((box.x+1 != box10.x) || (box.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y-1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y-1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y-1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y-1 != box8.y)) &&
                      ((box.x != box9.x) || (box.y-1 != box9.y)) &&
                      ((box.x != box10.x) || (box.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y+1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y+1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y+1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y+1 != box8.y)) &&
                      ((box.x != box9.x) || (box.y+1 != box9.y)) &&
                      ((box.x != box10.x) || (box.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x-1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x-1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x-1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x-1 != box8.x) || (box2.y != box8.y)) &&
                      ((box2.x-1 != box9.x) || (box2.y != box9.y)) &&
                      ((box2.x-1 != box10.x) || (box2.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x+1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x+1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x+1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x+1 != box8.x) || (box2.y != box8.y)) &&
                      ((box2.x+1 != box9.x) || (box2.y != box9.y)) &&
                      ((box2.x+1 != box10.x) || (box2.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y-1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y-1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y-1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y-1 != box8.y)) &&
                      ((box2.x != box9.x) || (box2.y-1 != box9.y)) &&
                      ((box2.x != box10.x) || (box2.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y+1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y+1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y+1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y+1 != box8.y)) &&
                      ((box2.x != box9.x) || (box2.y+1 != box9.y)) &&
                      ((box2.x != box10.x) || (box2.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x-1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x-1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x-1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x-1 != box8.x) || (box3.y != box8.y)) &&
                      ((box3.x-1 != box9.x) || (box3.y != box9.y)) &&
                      ((box3.x-1 != box10.x) || (box3.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x+1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x+1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x+1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x+1 != box8.x) || (box3.y != box8.y)) &&
                      ((box3.x+1 != box9.x) || (box3.y != box9.y)) &&
                      ((box3.x+1 != box10.x) || (box3.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y-1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y-1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y-1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y-1 != box8.y)) &&
                      ((box3.x != box9.x) || (box3.y-1 != box9.y)) &&
                      ((box3.x != box10.x) || (box3.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y+1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y+1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y+1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y+1 != box8.y)) &&
                      ((box3.x != box9.x) || (box3.y+1 != box9.y)) &&
                      ((box3.x != box10.x) || (box3.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x-1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x-1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x-1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x-1 != box8.x) || (box4.y != box8.y)) &&
                      ((box4.x-1 != box9.x) || (box4.y != box9.y)) &&
                      ((box4.x-1 != box10.x) || (box4.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x+1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x+1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x+1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x+1 != box8.x) || (box4.y != box8.y)) &&
                      ((box4.x+1 != box9.x) || (box4.y != box9.y)) &&
                      ((box4.x+1 != box10.x) || (box4.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y-1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y-1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y-1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y-1 != box8.y)) &&
                      ((box4.x != box9.x) || (box4.y-1 != box9.y)) &&
                      ((box4.x != box10.x) || (box4.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y+1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y+1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y+1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y+1 != box8.y)) &&
                      ((box4.x != box9.x) || (box4.y+1 != box9.y)) &&
                      ((box4.x != box10.x) || (box4.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 5----------------------------------------------                 
                if(BBhax.left == BBbox5.right && hax.y == box5.y && key[KEY_LEFT] )
                {
                  if( ((box5.x-1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x-1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x-1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x-1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x-1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x-1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x-1 != box8.x) || (box5.y != box8.y)) &&
                      ((box5.x-1 != box9.x) || (box5.y != box9.y)) &&
                      ((box5.x-1 != box10.x) || (box5.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x-1] != 1)  
                       {         
                            box5.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox5.left && hax.y == box5.y && key[KEY_RIGHT] )
                {
                  if( ((box5.x+1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x+1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x+1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x+1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x+1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x+1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x+1 != box8.x) || (box5.y != box8.y)) &&
                      ((box5.x+1 != box9.x) || (box5.y != box9.y)) &&
                      ((box5.x+1 != box10.x) || (box5.y != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x+1] != 1)  
                       {         
                            box5.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox5.bottom && hax.x == box5.x && key[KEY_UP] )
                {
                  if( ((box5.x != box.x) || (box5.y-1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y-1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y-1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y-1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y-1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y-1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y-1 != box8.y)) &&
                      ((box5.x != box9.x) || (box5.y-1 != box9.y)) &&
                      ((box5.x != box10.x) || (box5.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y-1][box5.x] != 1)  
                        {                  
                            box5.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox5.top && hax.x == box5.x && key[KEY_DOWN] )
                {               
                  if( ((box5.x != box.x) || (box5.y+1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y+1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y+1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y+1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y+1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y+1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y+1 != box8.y)) &&
                      ((box5.x != box9.x) || (box5.y+1 != box9.y)) &&
                      ((box5.x != box10.x) || (box5.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y+1][box5.x] != 1)  
                        {                     
                            box5.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 6----------------------------------------------                 
                if(BBhax.left == BBbox6.right && hax.y == box6.y && key[KEY_LEFT] )
                {
                  if( ((box6.x-1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x-1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x-1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x-1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x-1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x-1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x-1 != box8.x) || (box6.y != box8.y)) &&
                      ((box6.x-1 != box9.x) || (box6.y != box9.y)) &&
                      ((box6.x-1 != box10.x) || (box6.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x-1] != 1)  
                       {         
                            box6.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox6.left && hax.y == box6.y && key[KEY_RIGHT] )
                {
                  if( ((box6.x+1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x+1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x+1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x+1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x+1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x+1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x+1 != box8.x) || (box6.y != box8.y)) &&
                      ((box6.x+1 != box9.x) || (box6.y != box9.y)) &&
                      ((box6.x+1 != box10.x) || (box6.y != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x+1] != 1)  
                       {         
                            box6.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox6.bottom && hax.x == box6.x && key[KEY_UP] )
                {
                  if( ((box6.x != box.x) || (box6.y-1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y-1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y-1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y-1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y-1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y-1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y-1 != box8.y)) &&
                      ((box6.x != box9.x) || (box6.y-1 != box9.y)) &&
                      ((box6.x != box10.x) || (box6.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y-1][box6.x] != 1)  
                        {                  
                            box6.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox6.top && hax.x == box6.x && key[KEY_DOWN] )
                {               
                  if( ((box6.x != box.x) || (box6.y+1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y+1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y+1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y+1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y+1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y+1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y+1 != box8.y)) &&
                      ((box6.x != box9.x) || (box6.y+1 != box9.y)) &&
                      ((box6.x != box10.x) || (box6.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y+1][box6.x] != 1)  
                        {                     
                            box6.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 7----------------------------------------------                 
                if(BBhax.left == BBbox7.right && hax.y == box7.y && key[KEY_LEFT] )
                {
                  if( ((box7.x-1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x-1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x-1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x-1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x-1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x-1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x-1 != box8.x) || (box7.y != box8.y)) &&
                      ((box7.x-1 != box9.x) || (box7.y != box9.y)) &&
                      ((box7.x-1 != box10.x) || (box7.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x-1] != 1)  
                       {         
                            box7.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox7.left && hax.y == box7.y && key[KEY_RIGHT] )
                {
                  if( ((box7.x+1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x+1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x+1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x+1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x+1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x+1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x+1 != box8.x) || (box7.y != box8.y)) &&
                      ((box7.x+1 != box9.x) || (box7.y != box9.y)) &&
                      ((box7.x+1 != box10.x) || (box7.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x+1] != 1)  
                       {         
                            box7.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox7.bottom && hax.x == box7.x && key[KEY_UP] )
                {
                  if( ((box7.x != box.x) || (box7.y-1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y-1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y-1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y-1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y-1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y-1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y-1 != box8.y)) &&
                      ((box7.x != box9.x) || (box7.y-1 != box9.y)) &&
                      ((box7.x != box10.x) || (box7.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y-1][box7.x] != 1)  
                        {                  
                            box7.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox7.top && hax.x == box7.x && key[KEY_DOWN] )
                {               
                  if( ((box7.x != box.x) || (box7.y+1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y+1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y+1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y+1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y+1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y+1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y+1 != box8.y)) &&
                      ((box7.x != box9.x) || (box7.y+1 != box9.y)) &&
                      ((box7.x != box10.x) || (box7.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y+1][box7.x] != 1)  
                        {                     
                            box7.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 8----------------------------------------------                 
                if(BBhax.left == BBbox8.right && hax.y == box8.y && key[KEY_LEFT] )
                {
                  if( ((box8.x-1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x-1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x-1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x-1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x-1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x-1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x-1 != box7.x) || (box8.y != box7.y)) &&
                      ((box8.x-1 != box9.x) || (box8.y != box9.y)) &&
                      ((box8.x-1 != box10.x) || (box8.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x-1] != 1)  
                       {         
                            box8.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox8.left && hax.y == box8.y && key[KEY_RIGHT] )
                {
                  if( ((box8.x+1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x+1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x+1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x+1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x+1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x+1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x+1 != box7.x) || (box8.y != box7.y)) &&
                      ((box8.x+1 != box9.x) || (box8.y != box9.y)) &&
                      ((box8.x+1 != box10.x) || (box8.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x+1] != 1)  
                       {         
                            box8.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox8.bottom && hax.x == box8.x && key[KEY_UP] )
                {
                  if( ((box8.x != box.x) || (box8.y-1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y-1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y-1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y-1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y-1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y-1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y-1 != box7.y)) &&
                      ((box8.x != box9.x) || (box8.y-1 != box9.y)) &&
                      ((box8.x != box10.x) || (box8.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y-1][box8.x] != 1)  
                        {                  
                            box8.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox8.top && hax.x == box8.x && key[KEY_DOWN] )
                {               
                  if( ((box8.x != box.x) || (box8.y+1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y+1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y+1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y+1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y+1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y+1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y+1 != box7.y)) &&
                      ((box8.x != box9.x) || (box8.y+1 != box9.y)) &&
                      ((box8.x != box10.x) || (box8.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y+1][box8.x] != 1)  
                        {                     
                            box8.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 9----------------------------------------------                 
                if(BBhax.left == BBbox9.right && hax.y == box9.y && key[KEY_LEFT] )
                {
                  if( ((box9.x-1 != box.x) || (box9.y != box.y)) && 
                      ((box9.x-1 != box2.x) || (box9.y != box2.y)) &&
                      ((box9.x-1 != box3.x) || (box9.y != box3.y)) &&
                      ((box9.x-1 != box4.x) || (box9.y != box4.y)) &&
                      ((box9.x-1 != box5.x) || (box9.y != box5.y)) &&
                      ((box9.x-1 != box6.x) || (box9.y != box6.y)) &&
                      ((box9.x-1 != box7.x) || (box9.y != box7.y)) &&
                      ((box9.x-1 != box8.x) || (box9.y != box8.y)) &&
                      ((box9.x-1 != box10.x) || (box9.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box9.y][box9.x-1] != 1)  
                       {         
                            box9.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox9.left && hax.y == box9.y && key[KEY_RIGHT] )
                {
                  if( ((box9.x+1 != box.x) || (box9.y != box.y)) && 
                      ((box9.x+1 != box2.x) || (box9.y != box2.y)) &&
                      ((box9.x+1 != box3.x) || (box9.y != box3.y)) &&
                      ((box9.x+1 != box4.x) || (box9.y != box4.y)) &&
                      ((box9.x+1 != box5.x) || (box9.y != box5.y)) &&
                      ((box9.x+1 != box6.x) || (box9.y != box6.y)) &&
                      ((box9.x+1 != box7.x) || (box9.y != box7.y)) &&
                      ((box9.x+1 != box8.x) || (box9.y != box8.y)) &&
                      ((box9.x+1 != box10.x) || (box9.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box9.y][box9.x+1] != 1)  
                       {         
                            box9.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox9.bottom && hax.x == box9.x && key[KEY_UP] )
                {
                  if( ((box9.x != box.x) || (box9.y-1 != box.y)) && 
                      ((box9.x != box2.x) || (box9.y-1 != box2.y)) &&
                      ((box9.x != box3.x) || (box9.y-1 != box3.y)) &&
                      ((box9.x != box4.x) || (box9.y-1 != box4.y)) &&
                      ((box9.x != box5.x) || (box9.y-1 != box5.y)) &&
                      ((box9.x != box6.x) || (box9.y-1 != box6.y)) &&
                      ((box9.x != box7.x) || (box9.y-1 != box7.y)) &&
                      ((box9.x != box8.x) || (box9.y-1 != box8.y)) &&
                      ((box9.x != box10.x) || (box9.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box9.y-1][box9.x] != 1)  
                        {                  
                            box9.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox9.top && hax.x == box9.x && key[KEY_DOWN] )
                {               
                  if( ((box9.x != box.x) || (box9.y+1 != box.y)) && 
                      ((box9.x != box2.x) || (box9.y+1 != box2.y)) &&
                      ((box9.x != box3.x) || (box9.y+1 != box3.y)) &&
                      ((box9.x != box4.x) || (box9.y+1 != box4.y)) &&
                      ((box9.x != box5.x) || (box9.y+1 != box5.y)) &&
                      ((box9.x != box6.x) || (box9.y+1 != box6.y)) &&
                      ((box9.x != box7.x) || (box9.y+1 != box7.y)) &&
                      ((box9.x != box8.x) || (box9.y+1 != box8.y)) &&
                      ((box9.x != box10.x) || (box9.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box9.y+1][box9.x] != 1)  
                        {                     
                            box9.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 10---------------------------------------------                 
                if(BBhax.left == BBbox10.right && hax.y == box10.y && key[KEY_LEFT] )
                {
                  if( ((box10.x-1 != box.x) || (box10.y != box.y)) && 
                      ((box10.x-1 != box2.x) || (box10.y != box2.y)) &&
                      ((box10.x-1 != box3.x) || (box10.y != box3.y)) &&
                      ((box10.x-1 != box4.x) || (box10.y != box4.y)) &&
                      ((box10.x-1 != box5.x) || (box10.y != box5.y)) &&
                      ((box10.x-1 != box6.x) || (box10.y != box6.y)) &&
                      ((box10.x-1 != box7.x) || (box10.y != box7.y)) &&
                      ((box10.x-1 != box8.x) || (box10.y != box8.y)) &&
                      ((box10.x-1 != box9.x) || (box10.y != box9.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box10.y][box10.x-1] != 1)  
                       {         
                            box10.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox10.left && hax.y == box10.y && key[KEY_RIGHT] )
                {
                  if( ((box10.x+1 != box.x) || (box10.y != box.y)) && 
                      ((box10.x+1 != box2.x) || (box10.y != box2.y)) &&
                      ((box10.x+1 != box3.x) || (box10.y != box3.y)) &&
                      ((box10.x+1 != box4.x) || (box10.y != box4.y)) &&
                      ((box10.x+1 != box5.x) || (box10.y != box5.y)) &&
                      ((box10.x+1 != box6.x) || (box10.y != box6.y)) &&
                      ((box10.x+1 != box7.x) || (box10.y != box7.y)) &&
                      ((box10.x+1 != box8.x) || (box10.y != box8.y)) &&
                      ((box10.x+1 != box9.x) || (box10.y != box9.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box10.y][box10.x+1] != 1)  
                       {         
                            box10.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox10.bottom && hax.x == box10.x && key[KEY_UP] )
                {
                  if( ((box10.x != box.x) || (box10.y-1 != box.y)) && 
                      ((box10.x != box2.x) || (box10.y-1 != box2.y)) &&
                      ((box10.x != box3.x) || (box10.y-1 != box3.y)) &&
                      ((box10.x != box4.x) || (box10.y-1 != box4.y)) &&
                      ((box10.x != box5.x) || (box10.y-1 != box5.y)) &&
                      ((box10.x != box6.x) || (box10.y-1 != box6.y)) &&
                      ((box10.x != box7.x) || (box10.y-1 != box7.y)) &&
                      ((box10.x != box8.x) || (box10.y-1 != box8.y)) &&
                      ((box10.x != box9.x) || (box10.y-1 != box9.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box10.y-1][box10.x] != 1)  
                        {                  
                            box10.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox10.top && hax.x == box10.x && key[KEY_DOWN] )
                {               
                  if( ((box10.x != box.x) || (box10.y+1 != box.y)) && 
                      ((box10.x != box2.x) || (box10.y+1 != box2.y)) &&
                      ((box10.x != box3.x) || (box10.y+1 != box3.y)) &&
                      ((box10.x != box4.x) || (box10.y+1 != box4.y)) &&
                      ((box10.x != box5.x) || (box10.y+1 != box5.y)) &&
                      ((box10.x != box6.x) || (box10.y+1 != box6.y)) &&
                      ((box10.x != box7.x) || (box10.y+1 != box7.y)) &&
                      ((box10.x != box8.x) || (box10.y+1 != box8.y)) &&
                      ((box10.x != box9.x) || (box10.y+1 != box9.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box10.y+1][box10.x] != 1)  
                        {                     
                            box10.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(map[box5.y][box5.x] == 3)
                caixaNoVerde5 = 1;
            else
                caixaNoVerde5 = 0;
                    
            if(map[box6.y][box6.x] == 3)
                caixaNoVerde6 = 1;
            else
                caixaNoVerde6 = 0;
                    
            if(map[box7.y][box7.x] == 3)
                caixaNoVerde7 = 1;
            else
                caixaNoVerde7 = 0;
                    
            if(map[box8.y][box8.x] == 3)
                caixaNoVerde8 = 1;
            else
                caixaNoVerde8 = 0;
                
            if(map[box9.y][box9.x] == 3)
                caixaNoVerde9 = 1;
            else
                caixaNoVerde9 = 0;
                
            if(map[box10.y][box10.x] == 3)
                caixaNoVerde10 = 1;
            else
                caixaNoVerde10 = 0;
                
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
             && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 && caixaNoVerde9 && caixaNoVerde10 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	 if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
     && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 && caixaNoVerde9 && caixaNoVerde10 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,9);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void jogar10(int map[LINHAS][COLUNAS])
{
     
    BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
    BITMAP *mapa = create_bitmap( TELA_L, TELA_A );
    BITMAP *cursor = makeCursor();
      
    MIDI *WelcomeToTheJungle = load_midi("mid/Guns n Roses - Welcome to the Jungle.mid");
    MIDI *BornToBeWild = load_midi("mid/Steppenwolf - Born to be wild.mid");
    MIDI *EnterSandman = load_midi("mid/Metallica - Enter Sandman.mid");
    MIDI *MasterOfPuppets = load_midi("mid/Metallica - Master of Puppets.mid");
    MIDI *NothingElseMatters = load_midi("mid/Metallica - Nothing else Matters.mid");
    MIDI *CrazyTrain = load_midi("mid/Ozzy Osbourne - Crazy Train.mid");
    MIDI *ShotInTheDark = load_midi("mid/Ozzy Osbourne - Shot in the dark.mid");
    MIDI *RockNRollAllNight = load_midi("mid/Kiss - Rock n roll all night.mid");
    MIDI *BlackDog = load_midi("mid/Led Zeppelin - Black dog.mid");
    MIDI *ImmigrantSong = load_midi("mid/Led Zeppelin - Immigrant Song.mid");
    MIDI *AnotherBrickInTheWall = load_midi("mid/Pink Floyd - Another brick in the wall.mid");
    MIDI *HotelCalifornia = load_midi("mid/The Eagles - Hotel California.mid");
    
    srand(time(NULL)); // Randomiza dependendo da interação
    int musicaSelecionada = rand()%12+1; // randomico de musicas de 1 a 12
    int FAtivado = 1;
    int musicaPausada;

    BITMAP *logo = load_bitmap("img/logo.bmp", pl);
    
	BITMAP *haxFrente = load_gif("img/haxFrente.gif", pl);
	BITMAP *haxCosta = load_gif("img/haxCosta.gif", pl);
	BITMAP *haxDireita = load_gif("img/haxDireita.gif", pl);
	BITMAP *haxEsquerda = load_gif("img/haxEsquerda.gif", pl);
	BITMAP *voltar = load_gif("img/voltar.gif", pl);
	BITMAP *voltar2 = load_gif("img/voltar2.gif", pl);
	BITMAP *replay = load_gif("img/replay.gif", pl);
	BITMAP *replay2 = load_gif("img/replay2.gif", pl);

	BITMAP *chao = load_bitmap( "img/mapa/chao2.bmp", pl );
	BITMAP *chaoX = load_bitmap( "img/mapa/chaoX2.bmp", pl );
	BITMAP *preto = load_bitmap( "img/mapa/preto.bmp", pl );
    BITMAP *parede = load_bitmap( "img/mapa/parede.bmp", pl );
    BITMAP *caixa = load_bitmap( "img/mapa/box2.bmp", pl );
    BITMAP *caixaVerde = load_bitmap( "img/mapa/boxVerm.bmp", pl );
    BITMAP *azul = load_bitmap( "img/mapa/azul.bmp", pl );   
    
    FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
    FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
    
    boxCoordenadas box;
    box.x = 12;
    box.y = 5;
    boxCoordenadas box2;
    box2.x = 11;
    box2.y = 4;
    boxCoordenadas box3;
    box3.x = 13;
    box3.y = 4;
    boxCoordenadas box4;
    box4.x = 15;
    box4.y = 3;
    boxCoordenadas box5;
    box5.x = 16;
    box5.y = 3;
    boxCoordenadas box6;
    box6.x = 15;
    box6.y = 5;
    boxCoordenadas box7;
    box7.x = 16;
    box7.y = 5;
    boxCoordenadas box8;
    box8.x = 13;
    box8.y = 7;
    boxCoordenadas box9;
    box9.x = 12;
    box9.y = 4;
    boxCoordenadas box10;
    box10.x = 12;
    box10.y = 3;
    
    
    boxCoordenadas boxAnt; 
    boxAnt.x = 12;
    boxAnt.y = 5; 
    boxCoordenadas box2Ant;
    box2Ant.x = 11;
    box2Ant.y = 4;  
    boxCoordenadas box3Ant;
    box3Ant.x = 13;
    box3Ant.y = 4;  
    boxCoordenadas box4Ant;
    box4Ant.x = 15;
    box4Ant.y = 3;
    boxCoordenadas box5Ant;
    box5Ant.x = 16;
    box5Ant.y = 3;
    boxCoordenadas box6Ant;
    box6Ant.x = 15;
    box6Ant.y = 5;
    boxCoordenadas box7Ant;
    box7Ant.x = 16;
    box7Ant.y = 5;
    boxCoordenadas box8Ant;
    box8Ant.x = 13;
    box8Ant.y = 7;
    boxCoordenadas box9Ant;
    box9Ant.x = 12;
    box9Ant.y = 4;
    boxCoordenadas box10Ant;
    box10Ant.x = 12;
    box10Ant.y = 3;
    
    haxBoneco hax;
	hax.x = 11;
	hax.y = 2;
	
	haxBoneco haxAnt;
	haxAnt.x = 11;
	haxAnt.y = 2;
    
    BBcaixa BBbox;
    BBcaixa BBbox2;
    BBcaixa BBbox3;
    BBcaixa BBbox4;
    BBcaixa BBbox5;
    BBcaixa BBbox6;
    BBcaixa BBbox7;
    BBcaixa BBbox8;
    BBcaixa BBbox9;
    BBcaixa BBbox10; 
         
    BBcaixa BBhax; 
    BBcaixa BBparede;
    
    
     
    int l, c, i, j;
    //Desenhando Mapa
    
    /*
    0 preto
    1 parede
    2 chao
    3 chaoX 
    4 azul   
    */

// Desenha Mapa ----------------------------------------------------------------    
     for ( c = 0; c < COLUNAS; c++ )
     {
         for ( l = 0; l < LINHAS; l++ )
         {
             if ( map[l][c] == 0 )
             {
                  draw_sprite( mapa, preto, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 1 )
             {
                   draw_sprite( mapa, parede, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 2 )
             {
                   draw_sprite( mapa, chao, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 3 )
             {
                   draw_sprite( mapa, chaoX, c * LARGURA_TILE, l * ALTURA_TILE );

             }
             if ( map[l][c] == 4 )
             {
                   draw_sprite( mapa, azul, c * LARGURA_TILE, l * ALTURA_TILE );

             }
        }
     }
    
    int ladoAtivo = 0; // Armazenará a ultima tecla pressionada para desenhar o Hax do lado certo
    int colide = 0, colideCaixa = 0,colideCaixaComCaixa = 0;
    int haxNaCaixa = 0;
    int minuto=00,segundo=00;
    int movimentos = 0;
    int primeiraTeclaClicada = 0;
    int empurroesCaixa = 0;
    
    int caixaNoVerde = 0, caixaNoVerde2 = 0 , caixaNoVerde3 = 0 ,caixaNoVerde4 = 0;
    int caixaNoVerde5 = 0, caixaNoVerde6 = 0 , caixaNoVerde7 = 0 ,caixaNoVerde8 = 0;
    int caixaNoVerde9 = 0, caixaNoVerde10 = 0 ;
    int TotalCaixasVerde = 0;
    int paraImprimirMovimento = 0;
    
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
			acquire_bitmap(buffer);
			clear(buffer);

/* COLOQUE O SEU CODIGO AQUI */

// IMPRIME MAPA -----------------------------------------------------------------
          
           draw_sprite( buffer, mapa, 0, 0 );
           
//VOLTAR E RESETAR---------------------------------------------------------------
      
      
      /* if()
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 712, 402 );
          }
          else
          draw_sprite( buffer, voltar2, 710, 400 );
             
          if()
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 667, 401 ); 
          }
          else
          draw_sprite( buffer, replay2, 665, 400 ); */
                  
          // Voltar movimento         
          if (mouse_b & 1 && mouse_x <= 745 && mouse_x >= 710 && mouse_y <= 430 && mouse_y >= 405 || key[KEY_V])
          {
                 
              hax.y = haxAnt.y;
              hax.x = haxAnt.x;
              
              box.x = boxAnt.x;
              box.y = boxAnt.y;
              
              box2.x = box2Ant.x;
              box2.y = box2Ant.y; 
              
              box3.x = box3Ant.x;
              box3.y = box3Ant.y; 
              
              box4.x = box4Ant.x;
              box4.y = box4Ant.y;
              
              box5.x = box5Ant.x;
              box5.y = box5Ant.y; 
              
              box6.x = box6Ant.x;
              box6.y = box6Ant.y;
              
              box7.x = box7Ant.x;
              box7.y = box7Ant.y;
              
              box8.x = box8Ant.x;
              box8.y = box8Ant.y;
              
              box9.x = box9Ant.x;
              box9.y = box9Ant.y;
              
              box10.x = box10Ant.x;
              box10.y = box10Ant.y;
          } 
          // Reiniciar fase 
          if(mouse_b & 1 && mouse_x <= 700 && mouse_x >= 665 && mouse_y <= 430 && mouse_y >= 405 || key[KEY_R])
          {
           
                    
            box.x = 12;
            box.y = 5;
           
            box2.x = 11;
            box2.y = 4;
      
            box3.x = 13;
            box3.y = 4;
          
            box4.x = 15;
            box4.y = 3;
          
            box5.x = 16;
            box5.y = 3;
         
            box6.x = 15;
            box6.y = 5;
       
            box7.x = 16;
            box7.y = 5;
        
            box8.x = 13;
            box8.y = 7;
          
            box9.x = 12;
            box9.y = 4;
     
            box10.x = 12;
            box10.y = 3;

            boxAnt.x = 12;
            boxAnt.y = 5; 
         
            box2Ant.x = 11;
            box2Ant.y = 4;  
           
            box3Ant.x = 13;
            box3Ant.y = 4;  
          
            box4Ant.x = 15;
            box4Ant.y = 3;
         
            box5Ant.x = 16;
            box5Ant.y = 3;
           
            box6Ant.x = 15;
            box6Ant.y = 5;
           
            box7Ant.x = 16;
            box7Ant.y = 5;
           
            box8Ant.x = 13;
            box8Ant.y = 7;
           
            box9Ant.x = 12;
            box9Ant.y = 4;
           
            box10Ant.x = 12;
            box10Ant.y = 3;   
          
        	hax.x = 11;
        	hax.y = 2;
     
        	haxAnt.x = 11;
        	haxAnt.y = 2;
        	
        	minuto=00;
            segundo=00;
            movimentos = 0;
            primeiraTeclaClicada = 0;
            empurroesCaixa = 0;
            contTempo = 0;
            
            ladoAtivo = 0;
         }
// IMPRIME CAIXAS ---------------------------------------------------------------               
           if(caixaNoVerde)
                draw_sprite( buffer, caixaVerde, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box.x*LARGURA_TILE ,  box.y*LARGURA_TILE  );
           
           if(caixaNoVerde2)
                draw_sprite( buffer, caixaVerde, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box2.x*LARGURA_TILE ,  box2.y*LARGURA_TILE  );
                
           if(caixaNoVerde3)
                draw_sprite( buffer, caixaVerde, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box3.x*LARGURA_TILE ,  box3.y*LARGURA_TILE  );
                
           if(caixaNoVerde4)
                draw_sprite( buffer, caixaVerde, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box4.x*LARGURA_TILE ,  box4.y*LARGURA_TILE  );
           
           if(caixaNoVerde5)
                draw_sprite( buffer, caixaVerde, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box5.x*LARGURA_TILE ,  box5.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde6)
                draw_sprite( buffer, caixaVerde, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box6.x*LARGURA_TILE ,  box6.y*LARGURA_TILE  );   
                
           if(caixaNoVerde7)
                draw_sprite( buffer, caixaVerde, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box7.x*LARGURA_TILE ,  box7.y*LARGURA_TILE  );
                
           if(caixaNoVerde8)
                draw_sprite( buffer, caixaVerde, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box8.x*LARGURA_TILE ,  box8.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde9)
                draw_sprite( buffer, caixaVerde, box9.x*LARGURA_TILE ,  box9.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box9.x*LARGURA_TILE ,  box9.y*LARGURA_TILE  ); 
                
           if(caixaNoVerde10)
                draw_sprite( buffer, caixaVerde, box10.x*LARGURA_TILE ,  box10.y*LARGURA_TILE  );
           else
                draw_sprite( buffer, caixa, box10.x*LARGURA_TILE ,  box10.y*LARGURA_TILE  ); 
           
// Bouding Box ------------------------------------------------------------------
           // hax
            BBhax.left = hax.x*LARGURA_TILE;
            BBhax.top = hax.y*LARGURA_TILE;
            BBhax.right = (BBhax.left + LARGURA_TILE);
            BBhax.bottom = (BBhax.top + LARGURA_TILE);
            
           // caixa
            BBbox.left = box.x*LARGURA_TILE;
            BBbox.top = box.y*LARGURA_TILE;
            BBbox.right = (BBbox.left + LARGURA_TILE);
            BBbox.bottom = (BBbox.top + LARGURA_TILE);
            // caixa 2
            BBbox2.left = box2.x*LARGURA_TILE;
            BBbox2.top = box2.y*LARGURA_TILE;
            BBbox2.right = (BBbox2.left + LARGURA_TILE);
            BBbox2.bottom = (BBbox2.top + LARGURA_TILE);
            // caixa 3
            BBbox3.left = box3.x*LARGURA_TILE;
            BBbox3.top = box3.y*LARGURA_TILE;
            BBbox3.right = (BBbox3.left + LARGURA_TILE);
            BBbox3.bottom = (BBbox3.top + LARGURA_TILE);
            // caixa 4
            BBbox4.left = box4.x*LARGURA_TILE;
            BBbox4.top = box4.y*LARGURA_TILE;
            BBbox4.right = (BBbox4.left + LARGURA_TILE);
            BBbox4.bottom = (BBbox4.top + LARGURA_TILE);
            // caixa 5
            BBbox5.left = box5.x*LARGURA_TILE;
            BBbox5.top = box5.y*LARGURA_TILE;
            BBbox5.right = (BBbox5.left + LARGURA_TILE);
            BBbox5.bottom = (BBbox5.top + LARGURA_TILE); 
            // caixa 6
            BBbox6.left = box6.x*LARGURA_TILE;
            BBbox6.top = box6.y*LARGURA_TILE;
            BBbox6.right = (BBbox6.left + LARGURA_TILE);
            BBbox6.bottom = (BBbox6.top + LARGURA_TILE); 
            // caixa 7
            BBbox7.left = box7.x*LARGURA_TILE;
            BBbox7.top = box7.y*LARGURA_TILE;
            BBbox7.right = (BBbox7.left + LARGURA_TILE);
            BBbox7.bottom = (BBbox7.top + LARGURA_TILE);
            // caixa 8
            BBbox8.left = box8.x*LARGURA_TILE;
            BBbox8.top = box8.y*LARGURA_TILE;
            BBbox8.right = (BBbox8.left + LARGURA_TILE);
            BBbox8.bottom = (BBbox8.top + LARGURA_TILE); 
            // caixa 9
            BBbox9.left = box9.x*LARGURA_TILE;
            BBbox9.top = box9.y*LARGURA_TILE;
            BBbox9.right = (BBbox9.left + LARGURA_TILE);
            BBbox9.bottom = (BBbox9.top + LARGURA_TILE);  
            // caixa 10
            BBbox10.left = box10.x*LARGURA_TILE;
            BBbox10.top = box10.y*LARGURA_TILE;
            BBbox10.right = (BBbox10.left + LARGURA_TILE);
            BBbox10.bottom = (BBbox10.top + LARGURA_TILE);            
        
// COLISÃO PAREDE --------------------------------------------------------------
           for ( c = 0; c < COLUNAS; c++ )
              for ( l = 0; l < LINHAS; l++ )
              {  
                  if(map[l][c] == 1)
                  {
                    BBparede.left = c*ALTURA_TILE;
                    BBparede.top = l*LARGURA_TILE;
                    BBparede.right = (BBparede.left + caixa->w);
                    BBparede.bottom = (BBparede.top + caixa->h);  
                    // COLISÃO COM PAREDE---------------                   
                    if(BBhax.left == BBparede.right && hax.y == l && key[KEY_LEFT])
                        colide = 1; 
                    else                           
                    if(BBhax.right == BBparede.left && hax.y == l && key[KEY_RIGHT])
                        colide = 1;
                    else    
                    if(BBhax.top == BBparede.bottom && hax.x == c && key[KEY_UP] )
                        colide = 1; 
                    else                                     
                    if(BBhax.bottom == BBparede.top && hax.x == c && key[KEY_DOWN] )
                        colide = 1;               
                  }                    
              }    
           
//MOVIMENTOS DO HAX -----------------------------------------------------------    
                
            switch (ladoAtivo)
               {
                      case 0 :  draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );      
                                break;                                            
                      case 1 :  draw_sprite( buffer, haxDireita, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                          
                      case 2 :  draw_sprite( buffer, haxCosta, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;                    
                      case 3 :  draw_sprite( buffer, haxEsquerda, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 ); 
                                break;
                      default : draw_sprite( buffer, haxFrente, hax.x*LARGURA_TILE+9, hax.y*LARGURA_TILE+2 );
                                break;
               } 
           /* 
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "box.x %d",box.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "box.y %d",box.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "box2.x %d",box2.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "box2.y %d",box2.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "box3.x %d",box3.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "box3.y %d",box3.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box4.x %d",box4.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box4.y %d",box4.y);
           */
           /*
            textprintf_ex(buffer, font, 50, 200, makecol(181, 230, 29), -1, "hax.x %d",hax.x);    
            textprintf_ex(buffer, font, 50, 210, makecol(181, 230, 29), -1, "hax.y %d",hax.y);
            textprintf_ex(buffer, font, 50, 230, makecol(181, 230, 29), -1, "haxAnt.x %d",haxAnt.x);
            textprintf_ex(buffer, font, 50, 240, makecol(181, 230, 29), -1, "haxAnt.y %d",haxAnt.y);
            textprintf_ex(buffer, font, 50, 260, makecol(181, 230, 29), -1, "boxAnt.x %d",boxAnt.x);
            textprintf_ex(buffer, font, 50, 270, makecol(181, 230, 29), -1, "boxAnt.y %d",boxAnt.y);
            textprintf_ex(buffer, font, 50, 290, makecol(181, 230, 29), -1, "box.x %d",box.x);
            textprintf_ex(buffer, font, 50, 300, makecol(181, 230, 29), -1, "box.y %d",box.y);
           */
            if(keypressed() && !colide) 
            {   
                 if( (key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) &&  primeiraTeclaClicada == 0 )
                     primeiraTeclaClicada = 1; 
                 // ARMAZENA POSIÇÃO ANTERIOR ---                                
                haxAnt.y = hax.y;
                haxAnt.x = hax.x;
                
                boxAnt.x = box.x;
                boxAnt.y = box.y;
                
                box2Ant.x = box2.x;
                box2Ant.y = box2.y; 
                
                box3Ant.x = box3.x;
                box3Ant.y = box3.y;
                 
                box4Ant.x = box4.x;
                box4Ant.y = box4.y;  
                  
                box5Ant.x = box5.x;
                box5Ant.y = box5.y;
                  
                box6Ant.x = box6.x;
                box6Ant.y = box6.y;
                  
                box7Ant.x = box7.x;
                box7Ant.y = box7.y;
                  
                box8Ant.x = box8.x;
                box8Ant.y = box8.y;
                
                box9Ant.x = box9.x;
                box9Ant.y = box9.y;
                
                box10Ant.x = box10.x;
                box10Ant.y = box10.y;
                // COLISÃO COM BOX 1----------------------------------------------                 
                if(BBhax.left == BBbox.right && hax.y == box.y && key[KEY_LEFT] )
                {          
                  if( ((box.x-1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x-1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x-1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x-1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x-1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x-1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x-1 != box8.x) || (box.y != box8.y)) &&
                      ((box.x-1 != box9.x) || (box.y != box9.y)) &&
                      ((box.x-1 != box10.x) || (box.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box.y][box.x-1] != 1)  
                       {         
                            box.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1; 
                      // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                   
                } else
                if(BBhax.right == BBbox.left && hax.y == box.y && key[KEY_RIGHT] )
                {
                  if( ((box.x+1 != box2.x) || (box.y != box2.y)) && 
                      ((box.x+1 != box3.x) || (box.y != box3.y)) &&
                      ((box.x+1 != box4.x) || (box.y != box4.y)) &&
                      ((box.x+1 != box5.x) || (box.y != box5.y)) &&
                      ((box.x+1 != box6.x) || (box.y != box6.y)) &&
                      ((box.x+1 != box7.x) || (box.y != box7.y)) &&
                      ((box.x+1 != box8.x) || (box.y != box8.y)) &&
                      ((box.x+1 != box9.x) || (box.y != box9.y)) &&
                      ((box.x+1 != box10.x) || (box.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --             
                       if(map[box.y][box.x+1] != 1)  
                       {         
                            box.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
              
                } else
                if(BBhax.top == BBbox.bottom && hax.x == box.x && key[KEY_UP] )
                {
                  if( ((box.x != box2.x) || (box.y-1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y-1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y-1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y-1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y-1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y-1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y-1 != box8.y)) &&
                      ((box.x != box9.x) || (box.y-1 != box9.y)) &&
                      ((box.x != box10.x) || (box.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y-1][box.x] != 1)  
                    {                  
                        box.y--;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox.top && hax.x == box.x && key[KEY_DOWN] )
                {
                  if( ((box.x != box2.x) || (box.y+1 != box2.y)) && 
                      ((box.x != box3.x) || (box.y+1 != box3.y)) &&
                      ((box.x != box4.x) || (box.y+1 != box4.y)) &&
                      ((box.x != box5.x) || (box.y+1 != box5.y)) &&
                      ((box.x != box6.x) || (box.y+1 != box6.y)) &&
                      ((box.x != box7.x) || (box.y+1 != box7.y)) &&
                      ((box.x != box8.x) || (box.y+1 != box8.y)) &&
                      ((box.x != box9.x) || (box.y+1 != box9.y)) &&
                      ((box.x != box10.x) || (box.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                    //-- Com o mapa --    
                    if(map[box.y+1][box.x] != 1)  
                    {                     
                        box.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } 
                
                // COLISÃO COM BOX 2----------------------------------------------                 
                if(BBhax.left == BBbox2.right && hax.y == box2.y && key[KEY_LEFT] )
                {
                  if( ((box2.x-1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x-1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x-1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x-1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x-1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x-1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x-1 != box8.x) || (box2.y != box8.y)) &&
                      ((box2.x-1 != box9.x) || (box2.y != box9.y)) &&
                      ((box2.x-1 != box10.x) || (box2.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x-1] != 1)  
                       {         
                            box2.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                         
                } else
                if(BBhax.right == BBbox2.left && hax.y == box2.y && key[KEY_RIGHT] )
                {
                  if( ((box2.x+1 != box.x) || (box2.y != box.y)) && 
                      ((box2.x+1 != box3.x) || (box2.y != box3.y)) &&
                      ((box2.x+1 != box4.x) || (box2.y != box4.y)) &&
                      ((box2.x+1 != box5.x) || (box2.y != box5.y)) &&
                      ((box2.x+1 != box6.x) || (box2.y != box6.y)) &&
                      ((box2.x+1 != box7.x) || (box2.y != box7.y)) &&
                      ((box2.x+1 != box8.x) || (box2.y != box8.y)) &&
                      ((box2.x+1 != box9.x) || (box2.y != box9.y)) &&
                      ((box2.x+1 != box10.x) || (box2.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box2.y][box2.x+1] != 1)  
                       {         
                            box2.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                  
                } else
                if(BBhax.top == BBbox2.bottom && hax.x == box2.x && key[KEY_UP] )
                {
                  if( ((box2.x != box.x) || (box2.y-1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y-1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y-1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y-1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y-1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y-1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y-1 != box8.y)) &&
                      ((box2.x != box9.x) || (box2.y-1 != box9.y)) &&
                      ((box2.x != box10.x) || (box2.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box2.y-1][box2.x] != 1)  
                        {                  
                            box2.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                } else
                if(BBhax.bottom == BBbox2.top && hax.x == box2.x && key[KEY_DOWN] )
                {
                  if( ((box2.x != box.x) || (box2.y+1 != box.y)) && 
                      ((box2.x != box3.x) || (box2.y+1 != box3.y)) &&
                      ((box2.x != box4.x) || (box2.y+1 != box4.y)) &&
                      ((box2.x != box5.x) || (box2.y+1 != box5.y)) &&
                      ((box2.x != box6.x) || (box2.y+1 != box6.y)) &&
                      ((box2.x != box7.x) || (box2.y+1 != box7.y)) &&
                      ((box2.x != box8.x) || (box2.y+1 != box8.y)) &&
                      ((box2.x != box9.x) || (box2.y+1 != box9.y)) &&
                      ((box2.x != box10.x) || (box2.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                    if(map[box2.y+1][box2.x] != 1)  
                    {                     
                        box2.y++;
                        empurroesCaixa++;
                        colideCaixa = 0;
                    } else colideCaixa = 1;
                    // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                   
                }
                
                // COLISÃO COM BOX 3----------------------------------------------                 
                if(BBhax.left == BBbox3.right && hax.y == box3.y && key[KEY_LEFT] )
                {
                  if( ((box3.x-1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x-1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x-1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x-1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x-1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x-1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x-1 != box8.x) || (box3.y != box8.y)) &&
                      ((box3.x-1 != box9.x) || (box3.y != box9.y)) &&
                      ((box3.x-1 != box10.x) || (box3.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x-1] != 1)  
                       {         
                            box3.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                          
                } else
                if(BBhax.right == BBbox3.left && hax.y == box3.y && key[KEY_RIGHT] )
                {
                  if( ((box3.x+1 != box.x) || (box3.y != box.y)) && 
                      ((box3.x+1 != box2.x) || (box3.y != box2.y)) &&
                      ((box3.x+1 != box4.x) || (box3.y != box4.y)) &&
                      ((box3.x+1 != box5.x) || (box3.y != box5.y)) &&
                      ((box3.x+1 != box6.x) || (box3.y != box6.y)) &&
                      ((box3.x+1 != box7.x) || (box3.y != box7.y)) &&
                      ((box3.x+1 != box8.x) || (box3.y != box8.y)) &&
                      ((box3.x+1 != box9.x) || (box3.y != box9.y)) &&
                      ((box3.x+1 != box10.x) || (box3.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box3.y][box3.x+1] != 1)  
                       {         
                            box3.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                        
                } else
                if(BBhax.top == BBbox3.bottom && hax.x == box3.x && key[KEY_UP] )
                {
                  if( ((box3.x != box.x) || (box3.y-1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y-1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y-1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y-1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y-1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y-1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y-1 != box8.y)) &&
                      ((box3.x != box9.x) || (box3.y-1 != box9.y)) &&
                      ((box3.x != box10.x) || (box3.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y-1][box3.x] != 1)  
                        {                  
                            box3.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                         
                } else
                if(BBhax.bottom == BBbox3.top && hax.x == box3.x && key[KEY_DOWN] )
                {
                  if( ((box3.x != box.x) || (box3.y+1 != box.y)) && 
                      ((box3.x != box2.x) || (box3.y+1 != box2.y)) &&
                      ((box3.x != box4.x) || (box3.y+1 != box4.y)) &&
                      ((box3.x != box5.x) || (box3.y+1 != box5.y)) &&
                      ((box3.x != box6.x) || (box3.y+1 != box6.y)) &&
                      ((box3.x != box7.x) || (box3.y+1 != box7.y)) &&
                      ((box3.x != box8.x) || (box3.y+1 != box8.y)) &&
                      ((box3.x != box9.x) || (box3.y+1 != box9.y)) &&
                      ((box3.x != box10.x) || (box3.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box3.y+1][box3.x] != 1)  
                        {                     
                            box3.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                    
                } 
                
                // COLISÃO COM BOX 4----------------------------------------------                 
                if(BBhax.left == BBbox4.right && hax.y == box4.y && key[KEY_LEFT] )
                {
                  if( ((box4.x-1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x-1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x-1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x-1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x-1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x-1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x-1 != box8.x) || (box4.y != box8.y)) &&
                      ((box4.x-1 != box9.x) || (box4.y != box9.y)) &&
                      ((box4.x-1 != box10.x) || (box4.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x-1] != 1)  
                       {         
                            box4.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox4.left && hax.y == box4.y && key[KEY_RIGHT] )
                {
                  if( ((box4.x+1 != box.x) || (box4.y != box.y)) && 
                      ((box4.x+1 != box2.x) || (box4.y != box2.y)) &&
                      ((box4.x+1 != box3.x) || (box4.y != box3.y)) &&
                      ((box4.x+1 != box5.x) || (box4.y != box5.y)) &&
                      ((box4.x+1 != box6.x) || (box4.y != box6.y)) &&
                      ((box4.x+1 != box7.x) || (box4.y != box7.y)) &&
                      ((box4.x+1 != box8.x) || (box4.y != box8.y)) &&
                      ((box4.x+1 != box9.x) || (box4.y != box9.y)) &&
                      ((box4.x+1 != box10.x) || (box4.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box4.y][box4.x+1] != 1)  
                       {         
                            box4.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox4.bottom && hax.x == box4.x && key[KEY_UP] )
                {
                  if( ((box4.x != box.x) || (box4.y-1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y-1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y-1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y-1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y-1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y-1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y-1 != box8.y)) &&
                      ((box4.x != box9.x) || (box4.y-1 != box9.y)) &&
                      ((box4.x != box10.x) || (box4.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y-1][box4.x] != 1)  
                        {                  
                            box4.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox4.top && hax.x == box4.x && key[KEY_DOWN] )
                {               
                  if( ((box4.x != box.x) || (box4.y+1 != box.y)) && 
                      ((box4.x != box2.x) || (box4.y+1 != box2.y)) &&
                      ((box4.x != box3.x) || (box4.y+1 != box3.y)) &&
                      ((box4.x != box5.x) || (box4.y+1 != box5.y)) &&
                      ((box4.x != box6.x) || (box4.y+1 != box6.y)) &&
                      ((box4.x != box7.x) || (box4.y+1 != box7.y)) &&
                      ((box4.x != box8.x) || (box4.y+1 != box8.y)) &&
                      ((box4.x != box9.x) || (box4.y+1 != box9.y)) &&
                      ((box4.x != box10.x) || (box4.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box4.y+1][box4.x] != 1)  
                        {                     
                            box4.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 5----------------------------------------------                 
                if(BBhax.left == BBbox5.right && hax.y == box5.y && key[KEY_LEFT] )
                {
                  if( ((box5.x-1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x-1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x-1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x-1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x-1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x-1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x-1 != box8.x) || (box5.y != box8.y)) &&
                      ((box5.x-1 != box9.x) || (box5.y != box9.y)) &&
                      ((box5.x-1 != box10.x) || (box5.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x-1] != 1)  
                       {         
                            box5.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox5.left && hax.y == box5.y && key[KEY_RIGHT] )
                {
                  if( ((box5.x+1 != box.x) || (box5.y != box.y)) && 
                      ((box5.x+1 != box2.x) || (box5.y != box2.y)) &&
                      ((box5.x+1 != box3.x) || (box5.y != box3.y)) &&
                      ((box5.x+1 != box4.x) || (box5.y != box4.y)) &&
                      ((box5.x+1 != box6.x) || (box5.y != box6.y)) &&
                      ((box5.x+1 != box7.x) || (box5.y != box7.y)) &&
                      ((box5.x+1 != box8.x) || (box5.y != box8.y)) &&
                      ((box5.x+1 != box9.x) || (box5.y != box9.y)) &&
                      ((box5.x+1 != box10.x) || (box5.y != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box5.y][box5.x+1] != 1)  
                       {         
                            box5.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox5.bottom && hax.x == box5.x && key[KEY_UP] )
                {
                  if( ((box5.x != box.x) || (box5.y-1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y-1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y-1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y-1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y-1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y-1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y-1 != box8.y)) &&
                      ((box5.x != box9.x) || (box5.y-1 != box9.y)) &&
                      ((box5.x != box10.x) || (box5.y-1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y-1][box5.x] != 1)  
                        {                  
                            box5.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox5.top && hax.x == box5.x && key[KEY_DOWN] )
                {               
                  if( ((box5.x != box.x) || (box5.y+1 != box.y)) && 
                      ((box5.x != box2.x) || (box5.y+1 != box2.y)) &&
                      ((box5.x != box3.x) || (box5.y+1 != box3.y)) &&
                      ((box5.x != box4.x) || (box5.y+1 != box4.y)) &&
                      ((box5.x != box6.x) || (box5.y+1 != box6.y)) &&
                      ((box5.x != box7.x) || (box5.y+1 != box7.y)) &&
                      ((box5.x != box8.x) || (box5.y+1 != box8.y)) &&
                      ((box5.x != box9.x) || (box5.y+1 != box9.y)) &&
                      ((box5.x != box10.x) || (box5.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box5.y+1][box5.x] != 1)  
                        {                     
                            box5.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 6----------------------------------------------                 
                if(BBhax.left == BBbox6.right && hax.y == box6.y && key[KEY_LEFT] )
                {
                  if( ((box6.x-1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x-1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x-1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x-1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x-1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x-1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x-1 != box8.x) || (box6.y != box8.y)) &&
                      ((box6.x-1 != box9.x) || (box6.y != box9.y)) &&
                      ((box6.x-1 != box10.x) || (box6.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x-1] != 1)  
                       {         
                            box6.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox6.left && hax.y == box6.y && key[KEY_RIGHT] )
                {
                  if( ((box6.x+1 != box.x) || (box6.y != box.y)) && 
                      ((box6.x+1 != box2.x) || (box6.y != box2.y)) &&
                      ((box6.x+1 != box3.x) || (box6.y != box3.y)) &&
                      ((box6.x+1 != box4.x) || (box6.y != box4.y)) &&
                      ((box6.x+1 != box5.x) || (box6.y != box5.y)) &&
                      ((box6.x+1 != box7.x) || (box6.y != box7.y)) &&
                      ((box6.x+1 != box8.x) || (box6.y != box8.y)) &&
                      ((box6.x+1 != box9.x) || (box6.y != box9.y)) &&
                      ((box6.x+1 != box10.x) || (box6.y != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box6.y][box6.x+1] != 1)  
                       {         
                            box6.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox6.bottom && hax.x == box6.x && key[KEY_UP] )
                {
                  if( ((box6.x != box.x) || (box6.y-1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y-1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y-1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y-1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y-1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y-1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y-1 != box8.y)) &&
                      ((box6.x != box9.x) || (box6.y-1 != box9.y)) &&
                      ((box6.x != box10.x) || (box6.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y-1][box6.x] != 1)  
                        {                  
                            box6.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox6.top && hax.x == box6.x && key[KEY_DOWN] )
                {               
                  if( ((box6.x != box.x) || (box6.y+1 != box.y)) && 
                      ((box6.x != box2.x) || (box6.y+1 != box2.y)) &&
                      ((box6.x != box3.x) || (box6.y+1 != box3.y)) &&
                      ((box6.x != box4.x) || (box6.y+1 != box4.y)) &&
                      ((box6.x != box5.x) || (box6.y+1 != box5.y)) &&
                      ((box6.x != box7.x) || (box6.y+1 != box7.y)) &&
                      ((box6.x != box8.x) || (box6.y+1 != box8.y)) &&
                      ((box6.x != box9.x) || (box6.y+1 != box9.y)) &&
                      ((box6.x != box10.x) || (box6.y+1 != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box6.y+1][box6.x] != 1)  
                        {                     
                            box6.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 7----------------------------------------------                 
                if(BBhax.left == BBbox7.right && hax.y == box7.y && key[KEY_LEFT] )
                {
                  if( ((box7.x-1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x-1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x-1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x-1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x-1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x-1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x-1 != box8.x) || (box7.y != box8.y)) &&
                      ((box7.x-1 != box9.x) || (box7.y != box9.y)) &&
                      ((box7.x-1 != box10.x) || (box7.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x-1] != 1)  
                       {         
                            box7.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox7.left && hax.y == box7.y && key[KEY_RIGHT] )
                {
                  if( ((box7.x+1 != box.x) || (box7.y != box.y)) && 
                      ((box7.x+1 != box2.x) || (box7.y != box2.y)) &&
                      ((box7.x+1 != box3.x) || (box7.y != box3.y)) &&
                      ((box7.x+1 != box4.x) || (box7.y != box4.y)) &&
                      ((box7.x+1 != box5.x) || (box7.y != box5.y)) &&
                      ((box7.x+1 != box6.x) || (box7.y != box6.y)) &&
                      ((box7.x+1 != box8.x) || (box7.y != box8.y)) &&
                      ((box7.x+1 != box9.x) || (box7.y != box9.y)) &&
                      ((box7.x+1 != box10.x) || (box7.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box7.y][box7.x+1] != 1)  
                       {         
                            box7.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox7.bottom && hax.x == box7.x && key[KEY_UP] )
                {
                  if( ((box7.x != box.x) || (box7.y-1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y-1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y-1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y-1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y-1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y-1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y-1 != box8.y)) &&
                      ((box7.x != box9.x) || (box7.y-1 != box9.y)) &&
                      ((box7.x != box10.x) || (box7.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y-1][box7.x] != 1)  
                        {                  
                            box7.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox7.top && hax.x == box7.x && key[KEY_DOWN] )
                {               
                  if( ((box7.x != box.x) || (box7.y+1 != box.y)) && 
                      ((box7.x != box2.x) || (box7.y+1 != box2.y)) &&
                      ((box7.x != box3.x) || (box7.y+1 != box3.y)) &&
                      ((box7.x != box4.x) || (box7.y+1 != box4.y)) &&
                      ((box7.x != box5.x) || (box7.y+1 != box5.y)) &&
                      ((box7.x != box6.x) || (box7.y+1 != box6.y)) &&
                      ((box7.x != box8.x) || (box7.y+1 != box8.y)) &&
                      ((box7.x != box9.x) || (box7.y+1 != box9.y)) &&
                      ((box7.x != box10.x) || (box7.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box7.y+1][box7.x] != 1)  
                        {                     
                            box7.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 8----------------------------------------------                 
                if(BBhax.left == BBbox8.right && hax.y == box8.y && key[KEY_LEFT] )
                {
                  if( ((box8.x-1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x-1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x-1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x-1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x-1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x-1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x-1 != box7.x) || (box8.y != box7.y)) &&
                      ((box8.x-1 != box9.x) || (box8.y != box9.y)) &&
                      ((box8.x-1 != box10.x) || (box8.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x-1] != 1)  
                       {         
                            box8.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox8.left && hax.y == box8.y && key[KEY_RIGHT] )
                {
                  if( ((box8.x+1 != box.x) || (box8.y != box.y)) && 
                      ((box8.x+1 != box2.x) || (box8.y != box2.y)) &&
                      ((box8.x+1 != box3.x) || (box8.y != box3.y)) &&
                      ((box8.x+1 != box4.x) || (box8.y != box4.y)) &&
                      ((box8.x+1 != box5.x) || (box8.y != box5.y)) &&
                      ((box8.x+1 != box6.x) || (box8.y != box6.y)) &&
                      ((box8.x+1 != box7.x) || (box8.y != box7.y)) &&
                      ((box8.x+1 != box9.x) || (box8.y != box9.y)) &&
                      ((box8.x+1 != box10.x) || (box8.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box8.y][box8.x+1] != 1)  
                       {         
                            box8.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox8.bottom && hax.x == box8.x && key[KEY_UP] )
                {
                  if( ((box8.x != box.x) || (box8.y-1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y-1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y-1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y-1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y-1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y-1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y-1 != box7.y)) &&
                      ((box8.x != box9.x) || (box8.y-1 != box9.y)) &&
                      ((box8.x != box10.x) || (box8.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y-1][box8.x] != 1)  
                        {                  
                            box8.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox8.top && hax.x == box8.x && key[KEY_DOWN] )
                {               
                  if( ((box8.x != box.x) || (box8.y+1 != box.y)) && 
                      ((box8.x != box2.x) || (box8.y+1 != box2.y)) &&
                      ((box8.x != box3.x) || (box8.y+1 != box3.y)) &&
                      ((box8.x != box4.x) || (box8.y+1 != box4.y)) &&
                      ((box8.x != box5.x) || (box8.y+1 != box5.y)) &&
                      ((box8.x != box6.x) || (box8.y+1 != box6.y)) &&
                      ((box8.x != box7.x) || (box8.y+1 != box7.y)) &&
                      ((box8.x != box9.x) || (box8.y+1 != box9.y)) &&
                      ((box8.x != box10.x) || (box8.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box8.y+1][box8.x] != 1)  
                        {                     
                            box8.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 9----------------------------------------------                 
                if(BBhax.left == BBbox9.right && hax.y == box9.y && key[KEY_LEFT] )
                {
                  if( ((box9.x-1 != box.x) || (box9.y != box.y)) && 
                      ((box9.x-1 != box2.x) || (box9.y != box2.y)) &&
                      ((box9.x-1 != box3.x) || (box9.y != box3.y)) &&
                      ((box9.x-1 != box4.x) || (box9.y != box4.y)) &&
                      ((box9.x-1 != box5.x) || (box9.y != box5.y)) &&
                      ((box9.x-1 != box6.x) || (box9.y != box6.y)) &&
                      ((box9.x-1 != box7.x) || (box9.y != box7.y)) &&
                      ((box9.x-1 != box8.x) || (box9.y != box8.y)) &&
                      ((box9.x-1 != box10.x) || (box9.y != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box9.y][box9.x-1] != 1)  
                       {         
                            box9.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox9.left && hax.y == box9.y && key[KEY_RIGHT] )
                {
                  if( ((box9.x+1 != box.x) || (box9.y != box.y)) && 
                      ((box9.x+1 != box2.x) || (box9.y != box2.y)) &&
                      ((box9.x+1 != box3.x) || (box9.y != box3.y)) &&
                      ((box9.x+1 != box4.x) || (box9.y != box4.y)) &&
                      ((box9.x+1 != box5.x) || (box9.y != box5.y)) &&
                      ((box9.x+1 != box6.x) || (box9.y != box6.y)) &&
                      ((box9.x+1 != box7.x) || (box9.y != box7.y)) &&
                      ((box9.x+1 != box8.x) || (box9.y != box8.y)) &&
                      ((box9.x+1 != box10.x) || (box9.y != box10.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box9.y][box9.x+1] != 1)  
                       {         
                            box9.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox9.bottom && hax.x == box9.x && key[KEY_UP] )
                {
                  if( ((box9.x != box.x) || (box9.y-1 != box.y)) && 
                      ((box9.x != box2.x) || (box9.y-1 != box2.y)) &&
                      ((box9.x != box3.x) || (box9.y-1 != box3.y)) &&
                      ((box9.x != box4.x) || (box9.y-1 != box4.y)) &&
                      ((box9.x != box5.x) || (box9.y-1 != box5.y)) &&
                      ((box9.x != box6.x) || (box9.y-1 != box6.y)) &&
                      ((box9.x != box7.x) || (box9.y-1 != box7.y)) &&
                      ((box9.x != box8.x) || (box9.y-1 != box8.y)) &&
                      ((box9.x != box10.x) || (box9.y-1 != box10.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box9.y-1][box9.x] != 1)  
                        {                  
                            box9.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox9.top && hax.x == box9.x && key[KEY_DOWN] )
                {               
                  if( ((box9.x != box.x) || (box9.y+1 != box.y)) && 
                      ((box9.x != box2.x) || (box9.y+1 != box2.y)) &&
                      ((box9.x != box3.x) || (box9.y+1 != box3.y)) &&
                      ((box9.x != box4.x) || (box9.y+1 != box4.y)) &&
                      ((box9.x != box5.x) || (box9.y+1 != box5.y)) &&
                      ((box9.x != box6.x) || (box9.y+1 != box6.y)) &&
                      ((box9.x != box7.x) || (box9.y+1 != box7.y)) &&
                      ((box9.x != box8.x) || (box9.y+1 != box8.y)) &&
                      ((box9.x != box10.x) || (box9.y+1 != box10.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box9.y+1][box9.x] != 1)  
                        {                     
                            box9.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                // COLISÃO COM BOX 10---------------------------------------------                 
                if(BBhax.left == BBbox10.right && hax.y == box10.y && key[KEY_LEFT] )
                {
                  if( ((box10.x-1 != box.x) || (box10.y != box.y)) && 
                      ((box10.x-1 != box2.x) || (box10.y != box2.y)) &&
                      ((box10.x-1 != box3.x) || (box10.y != box3.y)) &&
                      ((box10.x-1 != box4.x) || (box10.y != box4.y)) &&
                      ((box10.x-1 != box5.x) || (box10.y != box5.y)) &&
                      ((box10.x-1 != box6.x) || (box10.y != box6.y)) &&
                      ((box10.x-1 != box7.x) || (box10.y != box7.y)) &&
                      ((box10.x-1 != box8.x) || (box10.y != box8.y)) &&
                      ((box10.x-1 != box9.x) || (box10.y != box9.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box10.y][box10.x-1] != 1)  
                       {         
                            box10.x--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                           
                } else
                if(BBhax.right == BBbox10.left && hax.y == box10.y && key[KEY_RIGHT] )
                {
                  if( ((box10.x+1 != box.x) || (box10.y != box.y)) && 
                      ((box10.x+1 != box2.x) || (box10.y != box2.y)) &&
                      ((box10.x+1 != box3.x) || (box10.y != box3.y)) &&
                      ((box10.x+1 != box4.x) || (box10.y != box4.y)) &&
                      ((box10.x+1 != box5.x) || (box10.y != box5.y)) &&
                      ((box10.x+1 != box6.x) || (box10.y != box6.y)) &&
                      ((box10.x+1 != box7.x) || (box10.y != box7.y)) &&
                      ((box10.x+1 != box8.x) || (box10.y != box8.y)) &&
                      ((box10.x+1 != box9.x) || (box10.y != box9.y)) )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                       if(map[box10.y][box10.x+1] != 1)  
                       {         
                            box10.x++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                       } else colideCaixa = 1;
                       // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                                    
                } else
                if(BBhax.top == BBbox10.bottom && hax.x == box10.x && key[KEY_UP] )
                {
                  if( ((box10.x != box.x) || (box10.y-1 != box.y)) && 
                      ((box10.x != box2.x) || (box10.y-1 != box2.y)) &&
                      ((box10.x != box3.x) || (box10.y-1 != box3.y)) &&
                      ((box10.x != box4.x) || (box10.y-1 != box4.y)) &&
                      ((box10.x != box5.x) || (box10.y-1 != box5.y)) &&
                      ((box10.x != box6.x) || (box10.y-1 != box6.y)) &&
                      ((box10.x != box7.x) || (box10.y-1 != box7.y)) &&
                      ((box10.x != box8.x) || (box10.y-1 != box8.y)) &&
                      ((box10.x != box9.x) || (box10.y-1 != box9.y))  )
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box10.y-1][box10.x] != 1)  
                        {                  
                            box10.y--;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                } else
                if(BBhax.bottom == BBbox10.top && hax.x == box10.x && key[KEY_DOWN] )
                {               
                  if( ((box10.x != box.x) || (box10.y+1 != box.y)) && 
                      ((box10.x != box2.x) || (box10.y+1 != box2.y)) &&
                      ((box10.x != box3.x) || (box10.y+1 != box3.y)) &&
                      ((box10.x != box4.x) || (box10.y+1 != box4.y)) &&
                      ((box10.x != box5.x) || (box10.y+1 != box5.y)) &&
                      ((box10.x != box6.x) || (box10.y+1 != box6.y)) &&
                      ((box10.x != box7.x) || (box10.y+1 != box7.y)) &&
                      ((box10.x != box8.x) || (box10.y+1 != box8.y)) &&
                      ((box10.x != box9.x) || (box10.y+1 != box9.y)))
                  { colideCaixaComCaixa = 0;
                             
                       //-- Com o mapa --
                        if(map[box10.y+1][box10.x] != 1)  
                        {                     
                            box10.y++;
                            empurroesCaixa++;
                            colideCaixa = 0;
                        } else colideCaixa = 1;
                        // ----------------- 
                      
                  } else colideCaixaComCaixa = 1;  
                  
                }
                
                // MOVIMENTOS DO HAX   (Verifica o lado atual)                   
                if(key[KEY_UP])
                {                
                    ladoAtivo = 2;
                    rest(50);
                }else
                if(key[KEY_DOWN])
                {
                    
                    ladoAtivo = 0;
                    rest(50);
                }else
                if(key[KEY_LEFT])
                {
                    
                    ladoAtivo = 3;
                    rest(50);
                }else
                if(key[KEY_RIGHT])
                {
                   
                    ladoAtivo = 1;
                    rest(50);
                }else
                   ladoAtivo = 4;
                   
                if(!colideCaixa && !colideCaixaComCaixa) // Verifica se houve colisão de caixa
                {                   
                    switch (ladoAtivo) // Realiza movimento
                    {
                          case 0 : hax.y++; movimentos++; break;                       
                          case 1 : hax.x++; movimentos++; break;                           
                          case 2 : hax.y--; movimentos++; break;             
                          case 3 : hax.x--; movimentos++; break;
                    }                  
                }       
                clear_keybuf();
    
            }

            
// VERIFICA SE CAIXA ESTA NO X -------------------------------------------------
            if(map[box.y][box.x] == 3)
                caixaNoVerde = 1;
            else
                caixaNoVerde = 0;
                
            if(map[box2.y][box2.x] == 3)
                caixaNoVerde2 = 1;
            else
                caixaNoVerde2 = 0;
                
            if(map[box3.y][box3.x] == 3)
                caixaNoVerde3 = 1;
            else
                caixaNoVerde3 = 0;
                
            if(map[box4.y][box4.x] == 3)
                caixaNoVerde4 = 1;
            else
                caixaNoVerde4 = 0;
                
            if(map[box5.y][box5.x] == 3)
                caixaNoVerde5 = 1;
            else
                caixaNoVerde5 = 0;
                    
            if(map[box6.y][box6.x] == 3)
                caixaNoVerde6 = 1;
            else
                caixaNoVerde6 = 0;
                    
            if(map[box7.y][box7.x] == 3)
                caixaNoVerde7 = 1;
            else
                caixaNoVerde7 = 0;
                    
            if(map[box8.y][box8.x] == 3)
                caixaNoVerde8 = 1;
            else
                caixaNoVerde8 = 0;
                
            if(map[box9.y][box9.x] == 3)
                caixaNoVerde9 = 1;
            else
                caixaNoVerde9 = 0;
                
            if(map[box10.y][box10.x] == 3)
                caixaNoVerde10 = 1;
            else
                caixaNoVerde10 = 0;
                
                
            if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
             && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 && caixaNoVerde9 && caixaNoVerde10 )
            { 
              if(paraImprimirMovimento%2 == 0)   
                paraImprimirMovimento++;
              else      
              key[KEY_ESC] = 1;
            }
            
// LIMPA VARIAVEIS COLIDE ------------------------------------------------------            
           if(colide) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {
                  colide = 0; 
                                   
                } 
                clear_keybuf();    
            } 
            if(colideCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixa = 0;  
                } 
                clear_keybuf();    
            }
            if(colideCaixaComCaixa) 
            {
                if(key[KEY_UP] || key[KEY_DOWN]|| key[KEY_LEFT] || key[KEY_RIGHT] ) 
                {   
                     colideCaixaComCaixa = 0;  
                } 
                clear_keybuf();    
            }  

                    
// MOVIMENTOS - PASSOS(MENU) ---------------------------------------------------
            rectfill(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(50,50,50));
            
            rect(buffer,40,SCREEN_H-160,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-161,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-162,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            rect(buffer,40,SCREEN_H-560,SCREEN_W-40,SCREEN_H-40,makecol(150,150,150));
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
           
         
            rect(buffer,41,SCREEN_H-561,SCREEN_W-41,SCREEN_H-39,makecol(200,200,200));
            rect(buffer,42,SCREEN_H-562,SCREEN_W-42,SCREEN_H-38,makecol(250,250,250));
            
            //draw_sprite( buffer, logo, 331 , 43 );
            
            textprintf_ex(buffer, CooperBlack, 450, SCREEN_H - 140, makecol(181, 230, 29), -1, "Passos");    
            textprintf_ex(buffer, CooperBlack, 580, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",movimentos);
            
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 100, makecol(181, 230, 29), -1, "Movimentos");           
            textprintf_ex(buffer, CooperBlack, 330, SCREEN_H - 100, makecol(63, 72, 204), -1, "%d",empurroesCaixa);                                                                  

// TEMPO (MENU) ---------------------------------------------------------------     
           if(primeiraTeclaClicada)
           {
            segundo = contTempo;                                                                    
            if(segundo > 59)
            {
                segundo = 0;
                contTempo = 0;
                minuto++;
            }
           } 
           else
              contTempo = 0;
              
            textprintf_ex(buffer, CooperBlack, 120, SCREEN_H - 140, makecol(181, 230, 29), -1, "Tempo");
            
            if(minuto < 10)
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",minuto);
		    else
		    textprintf_ex(buffer, CooperBlack, 250, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",minuto);
		    
		    textprintf_ex(buffer, CooperBlack, 275, SCREEN_H - 140, makecol(63, 72, 204), -1, " : ");
		    
		    if(segundo < 10)
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "0%d ",segundo);
		    else
		    textprintf_ex(buffer, CooperBlack, 303, SCREEN_H - 140, makecol(63, 72, 204), -1, "%d",segundo);		   		    

// FPS --------------------------------------------------------------------------         	
            
            //textprintf_ex(buffer, font, 330, SCREEN_H-20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);

          if(mouse_x <= 745 && mouse_x >= 710 && mouse_y <= 430 && mouse_y >= 405)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Voltar (V)"); 
             draw_sprite( buffer, voltar, 712, 402 );
          }
          else
          draw_sprite( buffer, voltar2, 710, 400 );
             
          if(mouse_x <= 700 && mouse_x >= 665 && mouse_y <= 430 && mouse_y >= 405)
          {
             textprintf_ex(buffer, Arial, mouse_x+20, mouse_y+16, makecol(181, 255, 0), -1, "Reiniciar (R)");
             draw_sprite( buffer, replay, 667, 401 ); 
          }
          else
          draw_sprite( buffer, replay2, 665, 400 ); 

// DESENHO DO CURSOR ------------------------------------------------------------  
            
            draw_sprite(buffer, cursor, mouse_x, mouse_y);
            
// MUSICAS (PLAY LIST)-----------------------------------------------------------
            if(FAtivado)
            {     
                switch (musicaSelecionada)
                {
                   case 0 : stop_midi(); break;
                   case 1 : play_midi(WelcomeToTheJungle,TRUE); break;
                   case 2 : play_midi(BornToBeWild,TRUE); break;
                   case 3 : play_midi(EnterSandman,TRUE); break;
                   case 4 : play_midi(MasterOfPuppets,TRUE); break;
                   case 5 : play_midi(NothingElseMatters,TRUE); break;
                   case 6 : play_midi(CrazyTrain,TRUE); break;
                   case 7 : play_midi(ShotInTheDark,TRUE); break; 
                   case 8 : play_midi(RockNRollAllNight,TRUE); break;
                   case 9 : play_midi(BlackDog,TRUE); break;
                   case 10 : play_midi(ImmigrantSong,TRUE); break;
                   case 11 : play_midi(AnotherBrickInTheWall,TRUE); break;
                   case 12 : play_midi(HotelCalifornia,TRUE); break;     
                }
                FAtivado = 0;
            }
            
            textprintf_centre_ex(buffer, font, SCREEN_W / 2, 589,
            makecol(100, 100, 100), -1,"F1 - Pausar/Tocar     F2 - Anterior     F3 - Próximo");
            
            switch (musicaSelecionada)
                {
                   case 0 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pausado"); break;
                   case 1 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Guns n' Roses - Welcome to the Jungle"); break;
                   case 2 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Steppenwolf - Born to be wild"); break;
                   case 3 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Enter Sandman"); break;
                   case 4 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Master of Puppets"); break;
                   case 5 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Metallica - Nothing else Matters"); break;
                   case 6 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Crazy Train"); break;
                   case 7 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Ozzy Osbourne - Shot in the dark"); break;
                   case 8 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Kiss - Rock n roll all night"); break;
                   case 9 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Black dog"); break;
                   case 10 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Led Zeppelin - Immigrant Song"); break;
                   case 11 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"Pink Floyd - Another brick in the wall"); break; 
                   case 12 : textprintf_centre_ex(buffer, Arial, SCREEN_W / 2, 565,
                   makecol(255, 255, 255), -1,"The Eagles - Hotel California"); break; 
                }
            
            if(key[KEY_F2]) // Volta musica
            {
                if(musicaSelecionada == 1)
                   musicaSelecionada = 12;
                else
                   musicaSelecionada--;
                stop_midi();
                key[KEY_F2] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F3]) // Avança musica
            {
                if(musicaSelecionada == 12)
                   musicaSelecionada = 1;
                else
                   musicaSelecionada++;
                stop_midi();
                key[KEY_F3] = 0; 
                FAtivado = 1;                
            }
            if(key[KEY_F1]) // Pause/Play
            {
               if(musicaSelecionada != 0)
               {
                 musicaPausada = musicaSelecionada;
                 musicaSelecionada = 0;  
                 key[KEY_F1] = 0;
                 FAtivado = 1;             
               }
               else
               {
                musicaSelecionada = musicaPausada;
                stop_midi();
                key[KEY_F1] = 0;    
                FAtivado = 1;   
               }          
            }
            
            
/* COLOQUE SEU CODIGO ATE AQUI */
			//pega o buffer
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}
			release_bitmap(buffer);
			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	 if(caixaNoVerde && caixaNoVerde2 && caixaNoVerde3 && caixaNoVerde4 && caixaNoVerde5
     && caixaNoVerde6  && caixaNoVerde7  && caixaNoVerde8 && caixaNoVerde9 && caixaNoVerde10 )
            {
              fimDeFase(minuto,segundo,movimentos,empurroesCaixa,10);
              while(!key[KEY_ENTER]);            
            }

	stop_midi(); 
	clear_keybuf();
	key[KEY_ESC]=0;
}
//---------------------------------------------------------------------------
void novojogo()
{
     FONT *CooperBlack = load_font("fonts/cooperblack22.pcx", pl, NULL);
     FONT *Arial = load_font("fonts/arial14.pcx", pl, NULL);
     BITMAP *fundo = load_bitmap("img/telaNovoJogo.bmp",pl);
     BITMAP *sim = load_bitmap("img/sim.bmp",pl);
     BITMAP *nao = load_bitmap("img/nao.bmp",pl);
     BITMAP *hax = load_gif("img/haxFrente.gif",pl);
     BITMAP *buffer = create_bitmap( TELA_L, TELA_A ); 
     BITMAP *cursor = makeCursor();
               
    acquire_bitmap(buffer);
	clear(buffer);
	
    int x,y = 0;
    for(x = 0; x <= 170; x++)
    {
        if(x%2==0)
           y++; 
         rectfill(buffer,400-x,300-y,400+x,300+y,makecol(0,0,0));
         rect(buffer,400-x,300-y,400+x,300+y,makecol(255,255,255));
         rect(buffer,399-x,299-y,401+x,301+y,makecol(200,200,200));
         rect(buffer,398-x,298-y,402+x,302+y,makecol(150,150,150));
         
         //rest(1);
         
   		//pega o buffer
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}
		release_bitmap(buffer);
		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}	
         
    }
    
    while(!key[KEY_ESC])
    { 
        draw_sprite( buffer, fundo, 280, 225);
        
      /*  
             mapaLiberado = 1;
         FILE *saveJogo;
         saveJogo = fopen("save.bin","r+b");
         if(!saveJogo)
         {
           saveJogo = fopen("save.bin","w+b");
         }
         fseek(saveJogo, 0, SEEK_SET); //posiciona no inicio do arquivo
         
         //salva no arquivo
         fwrite(&mapaLiberado,sizeof(int),1,saveJogo); //escreve no arquivo
         fclose(saveJogo);
    
      */      
        line(buffer,270,309,530,309,makecol(150, 150, 150));
        //line(screen,220,214,560,214,makecol(200, 200, 200));
        line(buffer,270,310,530,310,makecol(255, 255, 255));
        //line(screen,220,216,560,216,makecol(200, 200, 200));
        line(buffer,270,311,530,311,makecol(150, 150, 150));
        
        draw_sprite(buffer, cursor, mouse_x, mouse_y);
        
        //pega o buffer
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}
		release_bitmap(buffer);
		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}
    }
}
//---------------------------------------------------------------------------

