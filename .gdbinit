# GEF
# source ~/.gef-2b72f5d0d9f0f218a91cd1ca5148e45923b950d5.py

# PWNDBG
# set debuginfod enabled on
# source /home/pegasus/sources/pwndbg/gdbinit.py
# set context-clear-screen on

# VANILLA
set disassembly-flavor intel
set debuginfod enabled off
set print asm-demangle on
set height 0
set print pretty on
tui new-layout gui src 1 asm 1 status 0 {-horizontal cmd 1 regs 1} 1
tui reg all
layout gui
focus cmd
