## bashrc.d.sh
## This is stashed here to easily copypaste into ~/.bashrc
## ========== ---[ Cut here ]--- ========== #

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi
unset rc
