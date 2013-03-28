/*--------------------------------------------------------------
	al_screen.h -- header file for screen update API
					(c) Chris "23yrold3yrold" Barry, 2004
  --------------------------------------------------------------*/

#ifndef SCREEN_UPDATE_H
#define SCREEN_UPDATE_H

#ifdef __cplusplus
	extern "C" {
#endif

enum {
		UPDATE_NONE = 0,
		UPDATE_TRIPLE_BUFFER,
		UPDATE_PAGE_FLIP,
		UPDATE_SYSTEM_BUFFER,
		UPDATE_DOUBLE_BUFFER,
		UPDATE_TRIPLE_WMB,
		UPDATE_PAGEFLIP_WMB,
		UPDATE_MAX
};

int     initialize_screen_updating(int i);
void    update_screen();
void    shutdown_screen_updating();
BITMAP* get_buffer();
int     get_update_method();
void    enable_vsync();
void    disable_vsync();
void    toggle_vsync();
int     vsync_is_enabled();

#ifdef __cplusplus
	}
#endif

#endif
