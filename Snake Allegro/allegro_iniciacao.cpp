#include <allegro.h>
#include <iostream>
#ifdef WIN32 //se esta usando windows
#include <winalleg.h> //vou usar para saber a versao do windows
#endif
#include "allegro_iniciacao.h"
#include "al_screen/al_screen.h" //atualizar a tela melhor

//variaveis externas
extern volatile int FecharJogo;
extern unsigned int volume;
extern unsigned int vSync;
extern unsigned int exibirFPS;
extern int resolucaoX;
extern int resolucaoY;
//variaveis Countador de FPS
extern volatile int contFrames, contTempo; // Conta a quantidade de frames em cada segundo
//extern volatile int fps; // Armazena a taxa atual de Fps
extern short int fpsC,fpsT,fps;

void inicia_allegro() {
	int profundidade, res;
	allegro_init();
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
	int v = GetVersion() & 65535;
    float versao = (v%256) + (v/256)/10.;
    /*if (versao<=5.1) //5.1 = XP, 6.0 = Vista, 6.1 Win7
        profundidade=16;
    else
        profundidade=32;*/

	set_color_depth(profundidade); //padrao é 32 bits, no XP é 16

	volume=get_config_int("Inicializacao", "volume", 128); //usa as config de volume do arquivo
	exibirFPS=get_config_int("Inicializacao", "exibirFps", 0);

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
	res = set_gfx_mode(GFX_AUTODETECT_WINDOWED, resolucaoX, resolucaoY, 0, 0);
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

    set_window_title("Snake Criado por Arthur Assuncao"); //nome da Janela

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
	//fechando o allegro
    if (get_update_method())
    {
        shutdown_screen_updating();
    }
	allegro_exit();
	exit(0);
	/* adicione outras deiniciacoes aqui */
}
void BotaoFechar(void)
{
   FecharJogo = TRUE;
}
END_OF_FUNCTION(BotaoFechar)
//Contador Frames Por Segundo
void funcFPS(void)
{
	contFrames++;
}
END_OF_FUNCTION(funcFPS);
//Fim Contador FPS
//Contador de tempo
void funcTempo(void)
{
/*fps = contFrames;
contFrames = 0;*/
	fpsT++;
	contTempo++;
}
END_OF_FUNCTION(funcTempo);
