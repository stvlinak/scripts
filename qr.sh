#!/bin/bash

CONTENT=$1

qrencode -t UTF8 "$1" | cat
