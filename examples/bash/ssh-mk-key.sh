#!/bin/bash
## ssh-mk-key.sh

## -b KEY_SIZE_IN_BITS
## -C KEY_COMMENT
## -N PASSPHRASE
## -f KEY_FILEPATH (implicitly also makes KEY_FILEPATH.pub)
ssh-keygen -b 4096 -C "$USER@$(hostname) $(date -u +%Y-%m-%d)" -N "" -f ~/.ssh/id_rsa # Generate a SSH key
