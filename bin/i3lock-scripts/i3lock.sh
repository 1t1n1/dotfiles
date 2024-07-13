#!/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
# DEFAULT='#ff00ffcc'
DEFAULT='#1d69f2cc'
DEFAULT_TRANS='#1d69f24c'
# TEXT='#ee00eeee'
TEXT='#ffffffff'
WRONG='#ef1a07bb'
TYPING='#0057f7ff'
VERIFYING='#003dafbb'
IMAGE=~/Pictures/Wallpapers/London-bridge.jpg 

i3lock \
--ignore-empty-password      \
--image=$IMAGE               \
--wrong-text="Wrong Password" \
--pass-screen                \
--pass-power                 \
--pass-volume                \
--ind-pos="960:380"            \
\
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$CLEAR        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TYPING        \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$VERIFYING     \
--bshl-color=$WRONG          \
\
--screen 1                   \
--blur 10                    \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"    \
--keylayout 1                \
