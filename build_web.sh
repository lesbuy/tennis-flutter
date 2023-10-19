#!/bin/bash

flutter build web --web-renderer html
tar czf web.tar.gz build/web/*
scp web.tar.gz ubuntu@66.42.39.26:/tmp
