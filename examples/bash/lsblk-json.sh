#!/usr/bin/env bash
## lsblk-json
## 
## ======================================== ##
date -Is >&2
lsblk -O -J --sort=KNAME >&1
