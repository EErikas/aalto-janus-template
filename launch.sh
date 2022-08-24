#!/bin/bash
python3 -m http.server --directory /server/www/ 4000 &
python3 /server/ffmpeg-endpoint/app.py &
/usr/local/bin/janus -F /usr/local/etc/janus 