#!/bin/bash

tar czf web.tar.gz build/web/*
scp web.tar.gz 66.42.39.26:/tmp
