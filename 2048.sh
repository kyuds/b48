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
}

function gen_boarder_line() {
    ret=""
    for ((i=0; i<$SIZE; i++)); do
        ret+="+"
        for ((j=0; j<$HOR_CNT; j++)); do
            ret+="-"
        done
    done
    echo "$ret+\n"
}

function gen_horizontal_empty() {
    ret=""
    for ((i=0; i<$SIZE; i++)); do
        ret+="|"
        for ((j=0; j<$HOR_CNT; j++)); do
            ret+=" "
        done
    done
    echo "$ret|\n"
}

function gen_clear_string() {
    UPLINE=$(tput cuu1)
    ERASELINE=$(tput el)
    CLR=""
    for ((c=0; c<$(( $VER_CNT * $SIZE + $SIZE + 1)); c++)); do
        CLR+="${UPLINE}${ERASELINE}"
    done
    echo "$CLR\c"
}

function win() {
    # need to clear board
    clear
    echo "You win!"
    exit 0
}

# PRINT BOARD
function print_board() {
    build=""
    build+=`gen_boarder_line`
    for ((r=0; r<$SIZE; r++)); do
        build+=`gen_horizontal_empty`
	
        for ((c=0; c<$SIZE; c++)); do
            idx=$(expr "$r" '*' "$SIZE" '+' "$c")
            itm=${board[idx]}

            if [[ ${#itm} -gt $HOR_CNT ]]; then
                win
            fi

            rightpad=$(( ($HOR_CNT - ${#itm}) / 2 ))
            leftpad=$(( $HOR_CNT - $rightpad - ${#itm} ))
            
            build+="|"
            for ((i=0; i<$leftpad; i++)); do
                build+=" "
            done
            if [[ $itm -eq 1 ]]; then
                build+=" "
            else
                build+="$itm"
            fi
            for ((i=0; i<$rightpad; i++)); do
                build+=" "
            done
        done
        build+="|\n"

        build+=`gen_horizontal_empty`
        build+=`gen_boarder_line`
    done
    echo -en "$build"
}

CLEAR_STRING=`gen_clear_string`

function clear() {
    echo -e "$CLEAR_STRING"
}

# GAME LOGIC
function move() {
    off_x="$1"
    off_y="$2"
    #echo "x_off: $off_x, y_off: $off_y"
}

# GAME PLAY
init_board

while true; do
    print_board
    read -rsn1 press
    if [ "$press" = "w" ]; then
        move 0 1
    elif [ "$press" = "a" ]; then
        move -1 0
    elif [ "$press" = "s" ]; then
        move 0 -1
    elif [ "$press" = "d" ]; then
        move 1 0
    elif [ "$press" = "q" ]; then
        exit 0
    fi
    clear
done












