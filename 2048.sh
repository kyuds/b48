#!/bin/bash

# CONSTANTS
declare -a board
HOR_CNT=7
VER_CNT=3

# SETTINGS #
SIZE=4 # creates a SIZE x SIZE grid for play

# HELPERS #

# initialize all empty, SIZExSIZE board. 
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

# one-time only function to generate an erasing
# sequence string. Generated string is stored in
# CLEAR_STRING (see line 55) and evoked to clear
# the board before rewrite. 
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
    echo $(( $xcoor + $ycoor * $SIZE ))
}

function move_h() {
    echo "Not implemented"
}

function move_v() {
    echo "Not implemented"
}

# basic move function based on keyboard.
# separates into two sub functions that handle
# movement for vertically and horizontally.
function move() {
    move_factor="$1"
    vertical="$2"
    
    #if [ "$vertical" = "true" ]; then
    #    move_v $move_factor
    #else
    #    move_h $move_factor
    #fi 
}

# logic to generate at maximum two new positions
# in which "2"s are placed onto the board. This
# function also helps to detect if the player has
# lost (no more empty spots) or won (exceeded the
# number representable on the board). 
function new_twos() {
    local -a spots
    num_empty=0
    max_num=0

    for ((i=0; i<$(( $SIZE * $SIZE )); i++)); do
        if [ "${board[i]}" = " " ]; then
            spots[num_empty]="$i"
            num_empty=$(( $num_empty + 1 ))
        else
            if [ "${board[i]}" -gt $max_num ]; then
                max_num="${board[i]}"
            fi
        fi
    done
    
    if [ ${#max_num} -gt $HOR_CNT ]; then
        echo "You Win!"
        exit 0
    fi

    if [ $num_empty -gt 1 ]; then
        entries=($(gshuf -i 0-$(( $num_empty - 1 )) -n 2))
        board[${spots[${entries[0]}]}]="2"
        board[${spots[${entries[1]}]}]="2"
    elif [ $num_empty -eq 1 ]; then
        board[${spots[0]}]="2"
    else
        echo "You Lose!"
        exit 0
    fi
}

function initialize() {
    init_board
    new_twos
    print_board
}

# GAME PLAY
initialize

while true; do
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
    else
        continue
    fi
    clear
    new_twos
    print_board
done












