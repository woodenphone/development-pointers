#!renpy
## enable_rollback.rpy
## Enable rollback for games that disable it.
## Everything after this header copypasted from:
## * https://www.reddit.com/r/RenPy/comments/12p4a1w/reenable_rollback_function_as_if_default_and_same/jgl0ztw/
## See relevant docs:
## * https://www.renpy.org/doc/html/save_load_rollback.html#blocking-rollback
## * https://www.renpy.org/doc/html/config.html#rollback
## ==================================== ##

init 999 python:
    renpy.config.rollback_enabled = True
    renpy.config.hard_rollback_limit = 256 #adjust the limit as required
    renpy.config.rollback_length = 256 #adjust the same above here
    def unren_noblock( *args, **kwargs ):
        return
    renpy.block_rollback = unren_noblock
    try:
        config.keymap['rollback'] = [ 'K_PAGEUP', 'repeat_K_PAGEUP', 'K_AC_BACK', 'mousedown_4' ]
    except:
        pass
