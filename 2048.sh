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
        board[i]=" "
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

CLEAR_STRING=`gen_clear_string`

function clear() {
    echo -e "$CLEAR_STRING"
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

            rightpad=$(( ($HOR_CNT - ${#itm}) / 2 ))
            leftpad=$(( $HOR_CNT - $rightpad - ${#itm} ))
            
            build+="|"
            for ((i=0; i<$leftpad; i++)); do
                build+=" "
            done
            build+="$itm"
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

# GAME LOGIC
function convert_coordinates() {
    xcoor="$1"
    ycoor="$2"
    reverse="$3"

    if [ "$reverse" = "true" ]; then
        echo $(( $y + $x * $SIZE ))
    else
        echo $(( $x + $y * $SIZE ))
    fi
}

function move() {
    move_factor="$1"
    reverse="$2"
    
    r=$(( ($SIZE - $move_factor * $SIZE) / 2 ))
    
}

function new_twos() {
    echo "Not implemented"
}

function check_status_and_proceed() {
    echo "Not implemented"
    #new_twos
}

function win() {
    echo "You beat the game!"
    exit 0
}

# GAME PLAY
init_board
# new_twos

while true; do
    print_board
    read -rsn1 press
    if [ "$press" = "w" ]; then
        move -1 false
    elif [ "$press" = "a" ]; then
        move -1 true
    elif [ "$press" = "s" ]; then
        move 1 false
    elif [ "$press" = "d" ]; then
        move 1 true
    elif [ "$press" = "q" ]; then
        exit 0
    fi
    status=`check_status_and_proceed`
    if [ "$status" = "dead" ]; then
        echo "You lose!"
        exit 0
    fi
    clear
done












