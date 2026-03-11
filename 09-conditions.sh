#!/bin/bash

NUMBER=$1

if [ $NUMBER -lt 10 ]
then
    echo "given nunmber $NUMBER is lessthen 10"
else 
    echo "given number $NUMBER is greterthen 10"
fi