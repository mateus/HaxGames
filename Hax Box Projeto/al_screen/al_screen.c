/*--------------------------------------------------------------
	al_screen.c -- implementation file for screen update API
					(c) Chris "23yrold3yrold" Barry, 2004
  --------------------------------------------------------------*/

#include <allegro.h>
#include "al_screen.h"

static int  updatemethod = UPDATE_NONE;
static int  waitforvsync = 0;
static BITMAP *pages[3] = {NULL, NULL, NULL}, *active_page = NULL, *buffer = NULL;

// helper function that both deletes a bitmap and (optionally) sets it to NULL in one move.
// it's safe to pass this function a NULL pointer.
static inline BITMAP* erase_bitmap(BITMAP *bmp)
{
	destroy_bitmap(bmp);
	return NULL;
}

// self-explanatory ...
int  initialize_screen_updating(int  i)
{
	// if there's already an update method in operation, kill it.
	if(updatemethod != UPDATE_NONE) shutdown_screen_updating();
		
	// make sure the chosen update method is valid
	if(i >= UPDATE_MAX || i <= UPDATE_NONE) i = UPDATE_TRIPLE_BUFFER;
	
	// deal with the video memory w/ memory buffer methods first.
	// if they fail, drop to System Buffering and try again below
	switch(i)
	{
		case UPDATE_TRIPLE_WMB:
			if (!(gfx_capabilities & GFX_CAN_TRIPLE_BUFFER))
				enable_triple_buffer();

			if((gfx_capabilities & GFX_CAN_TRIPLE_BUFFER))
			{
				pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
				pages[1] = create_video_bitmap(SCREEN_W, SCREEN_H);
				pages[2] = create_video_bitmap(SCREEN_W, SCREEN_H);
				buffer = create_bitmap(SCREEN_W, SCREEN_H);
				
				if(pages[0] && pages[1] && pages[2] && buffer)
				{
					clear_bitmap(pages[0]);
					clear_bitmap(pages[1]);
					clear_bitmap(pages[2]);
					clear_bitmap(buffer);
					active_page = pages[0];
					show_video_bitmap(pages[2]);
					return (updatemethod = UPDATE_TRIPLE_WMB);
				}
				else
				{
					pages[0] = erase_bitmap(pages[0]);
					pages[1] = erase_bitmap(pages[1]);
					pages[2] = erase_bitmap(pages[2]);
					buffer   = erase_bitmap(buffer);
				}
			}
		// fall through if triple buffering isn't supported
			
		case UPDATE_PAGEFLIP_WMB:
			pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
			pages[1] = create_video_bitmap(SCREEN_W, SCREEN_H);
			buffer = create_bitmap(SCREEN_W, SCREEN_H);
			
			if(pages[0] && pages[1] && buffer)
			{
				clear_bitmap(pages[0]);
				clear_bitmap(pages[1]);
				clear_bitmap(buffer);
				active_page = pages[0];
				show_video_bitmap(pages[1]);
				return (updatemethod = UPDATE_PAGEFLIP_WMB);
			}
			else
			{
				pages[0] = erase_bitmap(pages[0]);
				pages[1] = erase_bitmap(pages[1]);
				buffer   = erase_bitmap(buffer);
				i = UPDATE_SYSTEM_BUFFER;
			}
		// fall through if page flipping isn't supported
		
		default: break;
	}
	
	// the main setup code
	switch(i)
	{
		case UPDATE_TRIPLE_BUFFER:
			if (!(gfx_capabilities & GFX_CAN_TRIPLE_BUFFER))
				enable_triple_buffer();

			if((gfx_capabilities & GFX_CAN_TRIPLE_BUFFER))
			{
				pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
				pages[1] = create_video_bitmap(SCREEN_W, SCREEN_H);
				pages[2] = create_video_bitmap(SCREEN_W, SCREEN_H);
				
				if(pages[0] && pages[1] && pages[2])
				{
					clear_bitmap(pages[0]);
					clear_bitmap(pages[1]);
					clear_bitmap(pages[2]);
					active_page = buffer = pages[0];
					show_video_bitmap(pages[2]);
					return (updatemethod= UPDATE_TRIPLE_BUFFER);
				}
				else
				{
					pages[0] = erase_bitmap(pages[0]);
					pages[1] = erase_bitmap(pages[1]);
					pages[2] = erase_bitmap(pages[2]);
				}
			}
		// fall through if triple buffering isn't supported
			
		case UPDATE_PAGE_FLIP:
			pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
			pages[1] = create_video_bitmap(SCREEN_W, SCREEN_H);
		
			if(pages[0] && pages[1])
			{
				clear_bitmap(pages[0]);
				clear_bitmap(pages[1]);
				active_page = buffer = pages[0];
				show_video_bitmap(pages[1]);
				return (updatemethod = UPDATE_PAGE_FLIP);
			}
			else
			{
				pages[0] = erase_bitmap(pages[0]);
				pages[1] = erase_bitmap(pages[1]);
			}
		// fall through if page flipping isn't supported
			
		case UPDATE_SYSTEM_BUFFER:
			buffer   = create_system_bitmap(SCREEN_W, SCREEN_H);
			pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
		
			if(buffer && pages[0])
			{
				clear_bitmap(buffer);
				clear_bitmap(pages[0]);
				show_video_bitmap(pages[0]);
				return (updatemethod = UPDATE_SYSTEM_BUFFER);
			}
			else
			{
				buffer   = erase_bitmap(buffer);
				pages[0] = erase_bitmap(pages[0]);
			}
		// fall through if system buffering isn't supported
			
		case UPDATE_DOUBLE_BUFFER:
			buffer   = create_bitmap(SCREEN_W, SCREEN_H);
			pages[0] = create_video_bitmap(SCREEN_W, SCREEN_H);
		
			if(buffer && pages[0])
			{
				clear_bitmap(buffer);
				clear_bitmap(pages[0]);
				show_video_bitmap(pages[0]);
				return updatemethod = UPDATE_DOUBLE_BUFFER;
			}
			else
			{
				buffer   = erase_bitmap(buffer);
				pages[0] = erase_bitmap(pages[0]);
			}
		// fall through if double buffering isn't supported
			
		default:
			// if there's been a total failure to set an update method (personally, I think that's impossible),
			// returns the default value of updatemethod, which is UPDATE_NONE. The user can check for
			// (!initialize_screen_updating()) and act accordingly. Wonder what he'd do ...
		return (updatemethod = UPDATE_NONE);
	}
}

void update_screen()
{
	switch(updatemethod)
	{
		case UPDATE_TRIPLE_WMB:
			blit(buffer, active_page, 0, 0, 0, 0, buffer->w, buffer->h);
			while (poll_scroll());
			request_video_bitmap(active_page);
			
			if(active_page == pages[0])
				active_page = pages[1];
			else if(active_page == pages[1])
				active_page = pages[2];
			else
				active_page = pages[0];
		return;
		
		case UPDATE_PAGEFLIP_WMB:
			blit(buffer, active_page, 0, 0, 0, 0, buffer->w, buffer->h);
			show_video_bitmap(active_page);
			active_page = ((active_page == pages[0]) ? pages[1] : pages[0]);
		return;
		
		case UPDATE_TRIPLE_BUFFER:
			while (poll_scroll());
			request_video_bitmap(active_page);
			
			if(active_page == pages[0])
				active_page = pages[1];
			else if(active_page == pages[1])
				active_page = pages[2];
			else
				active_page = pages[0];
			
			buffer = active_page;
		return;
		
		case UPDATE_PAGE_FLIP:
			show_video_bitmap(active_page);
			buffer = active_page = ((active_page == pages[0]) ? pages[1] : pages[0]);
		return;
			
		case UPDATE_SYSTEM_BUFFER:
			if(waitforvsync) vsync();
			blit(buffer, pages[0], 0, 0, 0, 0, buffer->w, buffer->h);
		return;
			
		case UPDATE_DOUBLE_BUFFER:
			if(waitforvsync) vsync();
			blit(buffer, pages[0], 0, 0, 0, 0, buffer->w, buffer->h);
		return;
	}
}

void shutdown_screen_updating()
{
	// just in case. buffer is always either a memory bitmap, or equal to active_page.
	// active_page always points to video memory (an element of page[]), or nothing.
	if(is_memory_bitmap(buffer))
		buffer = erase_bitmap(buffer);
	else
		buffer = NULL;
	
	active_page = NULL;
	
	pages[0] = erase_bitmap(pages[0]);
	pages[1] = erase_bitmap(pages[1]);
	pages[2] = erase_bitmap(pages[2]);
	
	updatemethod = UPDATE_NONE;
}

// two more quickies
BITMAP* get_buffer()     { return buffer;       }
int  get_update_method() { return updatemethod; }

// finally, the vsync stuff. Note that waitforvsync only affects system buffering and double buffering
void enable_vsync()     { waitforvsync = 1;     }
void disable_vsync()    { waitforvsync = 0;     }
void toggle_vsync()     { waitforvsync = waitforvsync ? 0 : 1; }
int  vsync_is_enabled() { return waitforvsync;  }
