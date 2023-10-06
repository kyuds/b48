#!/bin/bash

# CONSTANTS
declare -a board
HOR_CNT=7
VER_CNT=3

# SETTINGS
SIZE=4 # creates a SIZE x SIZE grid for play

# DRAWING HELPERS
function init_board() {
    for ((i=0; i<$(expr "$SIZE" '*' "$SIZE"); i++)); do
        board[i]="1"
    done

    board[2]=2048
    board[14]=65536
    board[5]=512
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

# CALCULATIONS
function ln() {
    n="$1"
    length=${#n}

    # number exceeded board constraints
    if [[ $length -gt $HOR_CNT ]]; then
        win
    fi
}

function win() {
    # need to clear board
    echo "You win!"
    exit 0
}

# PRINT BOARD
function print_board() {
    draw_boarder_line
    for ((r=0; r<$SIZE; r++)); do
        draw_horizontal_empty
	
        for ((c=0; c<$SIZE; c++)); do
            idx=$(expr "$r" '*' "$SIZE" '+' "$c")
            itm=${board[idx]}
            rightpad=$(( ($HOR_CNT - ${#itm}) / 2 ))
            leftpad=$(( $HOR_CNT - $rightpad - ${#itm} ))
            
            echo -n "|"
            for ((i=0; i<$leftpad; i++)); do
                echo -n " "
            done
            echo -n "$itm"
            for ((i=0; i<$rightpad; i++)); do
                echo -n " "
            done
        done
        echo "|"

        draw_horizontal_empty
        draw_boarder_line
    done
}

# GAME LOGIC

init_board
print_board



