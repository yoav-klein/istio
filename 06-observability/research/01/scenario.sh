#!/bin/bash


min=10
max=20

function delay() {
    ms=$1
    curl server/delay/$ms
}

function cycle() {
    num=$1
    delay=$2

    for i in $(seq 1 $num); do
        delay $delay
    done
}


function scenario_a() {
    cycle 50 20
    cycle 30 80
    cycle 10 200
    cycle 10 500
}


while $true; do
    scenario_a
done

