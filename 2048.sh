#!/bin/bash

# CONSTANTS
declare -a board
HOR_CNT=7
VER_CNT=3

# SETTINGS
SIZE=4 # creates a SIZE x SIZE grid for play

# HELPERS
function init_board() {
    for ((i=0; i<$(expr "$SIZE" '*' "$SIZE"); i++)); do
        board[i]="1"
    done

    board[2]=2048
    board[10]=16
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

function clear() {
    UPLINE=$(tput cuu1)
    ERASELINE=$(tput el)

    for ((c=0; c<$(( $VER_CNT * $SIZE + $SIZE + 1)); c++)); do
        echo -n "$UPLINE$ERASELINE"
    done
}

function win() {
    # need to clear board
    clear
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

            if [[ ${#itm} -gt $HOR_CNT ]]; then
                win
            fi

            rightpad=$(( ($HOR_CNT - ${#itm}) / 2 ))
            leftpad=$(( $HOR_CNT - $rightpad - ${#itm} ))
            
            echo -n "|"
            for ((i=0; i<$leftpad; i++)); do
                echo -n " "
            done
            if [[ $itm -eq 1 ]]; then
                echo -n " "
            else
                echo -n "$itm"
            fi
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

for ((tst=0; tst<10; tst++)); do
    board[0]=$tst
    clear
    print_board
    sleep 1
done

board[0]=19283719823719237
clear
print_board














