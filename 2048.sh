#!/bin/bash

# CONSTANTS
declare -a board
HOR_CNT=7
VER_CNT=3

# SETTINGS
SIZE=4 # creates a SIZE x SIZE grid for play

# BASIC HELPERS
function init_board() {
    for ((i=0; i<$(expr "$SIZE" '*' "$SIZE"); i++)); do
        board[i]="1"
    done
}

function draw_boarder_line() {
    for ((i=0; i<$SIZE; i++)); do
        echo -n "+"
        for ((j=0; j<$HOR_CNT; j++)); do
            echo -n "-"
        done
    done
    echo "+"
}

function draw_horizontal_empty() {
    for ((i=0; i<$SIZE; i++)); do
        echo -n "|"
        for ((j=0; j<$HOR_CNT; j++)); do
            echo -n " "
        done
    done
    echo "|"
}

init_board
draw_boarder_line
draw_horizontal_empty

