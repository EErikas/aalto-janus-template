# aalto-janus-template
Docker Image with Janus Gateway FFmpeg and some extras.

## Set up:
### Building with `Docker`:
```bash
docker build .
```
### Pulling from `DockerHub`:
```
docker pull eerikas/aalto-janus-template
```

## FFmpeg Access
You can interact with ffmpeg installation on this machine in the following ways:
### By accessing it via CLI by entering command:
```bash
docker exec -it <container name> /bin/bash
# If you downloaded this repository it should look sth like this:
docker exec -it cs-e4260-assignment-3-template-janus-1 /bin/bash
```
Once you enter the CLI, you can launch the tool by simply calling `ffmpeg` followed by parameters, 
for example, the following command:
```bash
ffmpeg -version
```
Returns such result:
```bash
ffmpeg version 4.3.4-0+deb11u1 Copyright (c) 2000-2021 the FFmpeg developers
built with gcc 10 (Debian 10.2.1-6)
configuration: --prefix=/usr --extra-version=0+deb11u1 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opencl --enable-opengl --enable-sdl2 --enable-pocketsphinx --enable-libmfx --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
libavutil      56. 51.100 / 56. 51.100
libavcodec     58. 91.100 / 58. 91.100
libavformat    58. 45.100 / 58. 45.100
libavdevice    58. 10.100 / 58. 10.100
libavfilter     7. 85.100 /  7. 85.100
libavresample   4.  0.  0 /  4.  0.  0
libswscale      5.  7.100 /  5.  7.100
libswresample   3.  7.100 /  3.  7.100
libpostproc    55.  7.100 / 55.  7.100
```
### By making API calls to `localhost:4001/ffmpeg/`
You need to make a POST request to this url in a following JSON format:
```json
{
    "args": [
        "-version"
    ]

}
```
The response should be something like this:
```json
{
    "key": "0aa4287b",
    "result_url": "http://127.0.0.1:4001/ffmpeg/?key=0aa4287b&wait=false",
    "status": "running"
}
```
`result_url` can be used to view the output of the command, in this case it would be:
```json
{
    "end_time": 1661370887.2870166,
    "error": "",
    "key": "0aa4287b",
    "process_time": 0.05430722236633301,
    "report": "ffmpeg version 4.3.4-0+deb11u1 Copyright (c) 2000-2021 the FFmpeg developers\nbuilt with gcc 10 (Debian 10.2.1-6)\nconfiguration: --prefix=/usr --extra-version=0+deb11u1 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opencl --enable-opengl --enable-sdl2 --enable-pocketsphinx --enable-libmfx --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared\nlibavutil      56. 51.100 / 56. 51.100\nlibavcodec     58. 91.100 / 58. 91.100\nlibavformat    58. 45.100 / 58. 45.100\nlibavdevice    58. 10.100 / 58. 10.100\nlibavfilter     7. 85.100 /  7. 85.100\nlibavresample   4.  0.  0 /  4.  0.  0\nlibswscale      5.  7.100 /  5.  7.100\nlibswresample   3.  7.100 /  3.  7.100\nlibpostproc    55.  7.100 / 55.  7.100\n",
    "returncode": 0,
    "start_time": 1661370887.2327094
}
```
## Example `docker-compose.yml` file:
``` yaml
version: '3'
services:
  janus:
    image: eerikas/aalto-janus-template
    
    # Files can be uploaded through here:
    volumes:
      - ./html:/server/www/
    ports:
      # Web GUI:
      - "4000:4000"
      # FFmpeg API:
      - "4001:4001"
      # Janus ports:
      - "8088:8088"
      - "8089:8089"
      - "8889:8889"
      - "8000:8000"
      - "7088:7088"
      - "7089:7089"

```
