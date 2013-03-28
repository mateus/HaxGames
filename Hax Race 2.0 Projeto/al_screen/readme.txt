
     ______   ___    ___
    /\  _  \ /\_ \  /\_ \
    \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___ 
     \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
      \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
       \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
        \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
                                       /\____/
                                       \_/__/
      SCREEN UPDATE API
      (c) Chris "23yrold3yrold" Barry, 2004



int initialize_screen_updating(int i);
Initializes the screen update system. This function must be called after set_gfx_mode() and can be called with the following values:

      UPDATE_TRIPLE_BUFFER    - standard triple buffering setup
      UPDATE_PAGE_FLIP        - standard page flipping setup
      UPDATE_SYSTEM_BUFFER    - double buffering system using a system bitmap
      UPDATE_DOUBLE_BUFFER    - double buffering system using a memory bitmap
      UPDATE_TRIPLE_WMB       - triple buffering, but with a memory bitmap buffer instead of a video bitmap
      UPDATE_PAGEFLIP_WMB     - page flipping, but with a memory bitmap buffer instead of a video bitmap

UPDATE_TRIPLE_WMB and UPDATE_PAGEFLIP_WMB are for times you're using a lot of blending or whatnot, and don't want your program slowed
down due to reading from video memory. UPDATE_SYSTEM_BUFFER and UPDATE_DOUBLE_BUFFER don't synchronize to the vertical retrace of the
screen unless vsync is enabled (by calling enable_vsync()). Note that these two mode alone are affected by the vsync functions; the
triple buffering and page flipping modes automatically handle vertical retrace synchronisation.

You can call this function multiple times in one program. So if you want the user to be able to switch between update methods to find
one best suited to their system, it's as easy as calling initialize_screen_updating() again.


void shutdown_screen_updating();
Does what it says. Call this at the end of your program to prevent memory leaks.


BITMAP* get_buffer();
This function returns the drawing surface. Do all your drawing to this bitmap during your drawing code. It doesn't affect the screen
until you call update_screen().


void update_screen();
Blits the buffer to the screen.


int get_update_method();
Returns the update method in the form of one of the six values listed under initialize_screen_updating().


void enable_vsync();
Makes update_screen() wait for a vertical retrace to end before updating the screen. Note this only affects UPDATE_SYSTEM_BUFFER and
UPDATE_DOUBLE_BUFFER.


void disable_vsync();
Disables vertical retrace synchronisation for UPDATE_SYSTEM_BUFFER and UPDATE_DOUBLE_BUFFER modes.


void toggle_vsync();
Toggles vertical retrace synchronisation for UPDATE_SYSTEM_BUFFER and UPDATE_DOUBLE_BUFFER modes.


int vsync_is_enabled();
Returns whether vertical retrace synchronisation is enabled.
