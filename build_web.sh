#!/bin/bash

flutter build web --web-renderer html
cd build/web
rm web.tar.gz
tar czf web.tar.gz *
scp web.tar.gz ubuntu@66.42.39.26:/home/ubuntu/single_page_web/build
