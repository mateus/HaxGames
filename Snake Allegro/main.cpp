#include <allegro.h>
#include "allegro_iniciacao.h" //init e deinit
#include <time.h>
#include <alpng.h> //habilita o uso de png
#include <algif.h> //habilita o uso de gif
#include <jpgalleg.h> //habilita o uso de jpg
#include "al_screen/al_screen.h" //atualizar a tela melhor
#include <malloc.h>
#include "funcoes/snake.h"
#include "funcoes/funcoes.h"

//Prototipos

//Variaveis Globais
// fechar jogo
volatile int FecharJogo = FALSE;

unsigned int volume=128;
unsigned int vSync=0;
unsigned int exibirFPS=0;
int resolucaoX, resolucaoY;


//variaveis Countador de FPS
volatile int contFrames = 0, contTempo = 0; // Conta a quantidade de frames em cada segundo
//volatile int fps = 0; // Armazena a taxa atual de Fps
short int fpsC=0,fpsT=0,fps=0;


//Fim Variaveis Globais

int main()
{

	inicia_allegro();

    telaInicial();

    snake();

	deinicia_allegro();
	return 0;
}
END_OF_MAIN()
