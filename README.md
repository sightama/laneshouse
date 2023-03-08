# L&GInn / Laneshouse / Gracehouse

##Python Django LTS PoE Camera Live Stream Framework Example project

This simple django project uses html img tags and local RTSP stream feeds being converted to MJPEG via VLC to broadcast (in this example) 4 PoE Cameras hooked up to an LTS security DVR system. Fun side project why not broadcast to the world WCGW?

![alt text](https://github.com/sightama/laneshouse/blob/main/laneshouse/static/images/example.jpg?raw=true)



## Running the server
Prereq:
  - Windows (RIP) - You could do it with linux but I won't support you trying to create the vlc command.
  - Follow guide at bottom to install wsl2 and docker desktop to work in wsl
  - Setup the following port forwarding on your router for your server IP:
    - 80, 9911,9912,9913,9914

1. Open a console and get into wsl
2. Clone project in wsl and pip install -r requirements.txt
3. export HOST_EXTERNAL_IP="<external-ip-here>"
4. Modify templates/index.html -> Change the src options to point at your localhost or external ip and keep ports the same.
5. docker-compose up

Now the server is operating and serves 4 html img tags linking to locally run RTSP streams. Let's set those up
4. Open up 1+ windows (not wsl) cmd tabs to run below commands to instantiate feeds; They are accessible on their ports @ localhost or via external IP addr
```
start vlc -vvv -Idummy rtsp://<dvruser>:<pass>@192.168.1.199:8554/streaming/channels/101 --sout #transcode{vcodec=MJPG,venc=,fps=10,width=640,height=360}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:9911/}
start vlc -vvv -Idummy rtsp://<dvruser>:<pass>@192.168.1.199:8554/streaming/channels/201 --sout #transcode{vcodec=MJPG,venc=,fps=10,width=640,height=360}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:9912/}
start vlc -vvv -Idummy rtsp://<dvruser>:<pass>@192.168.1.199:8554/streaming/channels/301 --sout #transcode{vcodec=MJPG,venc=,fps=10,width=640,height=360}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:9913/}
start vlc -vvv -Idummy rtsp://<dvruser>:<pass>@192.168.1.199:8554/streaming/channels/401 --sout #transcode{vcodec=MJPG,venc=,fps=10,width=640,height=360}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:9914/}
```

## Killing the server
1. Press Ctrl + C o nthe docker compose window
2. Type this into windows terminal:
```
killall -9 VLC
```

### Relevant Addresses and RTSP Format for LTS Security Cameras
  - Local dvr system/cameras IP = 192.168.1.199
  - Public server IP = 73.138.53.30
  - LTS RTSP Stream link working examples (03072023)
    - BACK PATIO
      - rtsp://<user>:<pass>@192.168.1.199:8554/streaming/channels/101
    - FRONT NIGHT VISION
      - rtsp://<user>:<pass>@192.168.1.199:8554/streaming/channels/201
    - YARD
      - rtsp://<user>:<pass>@192.168.1.199:8554/streaming/channels/301
    - CATS
      - rtsp://<user>:<pass>@192.168.1.199:8554/streaming/channels/401

### Troubleshooting/Useful Links
  - LTS streams op: https://ltsecurityinc.zendesk.com/hc/en-us/articles/360005417193-HTTP-RTSP-MJPEG-Links
    - If you change end value to 2 its smaller stream
  - https://ikriv.com/blog/?p=4833

Note: I tried getting the above commands to run in a linux docker container and came up with this run statement before I gave up.If you wanna pick up where I left off and make a PR you're more than welcome to:
```
vlc -vvv -Idummy rtsp://<user>:<pass>@192.168.1.199:8554/streaming/channels/201 --sout-transcode-venc=ffmpeg{strict=1} --sout-transcode-vcodec=MJPG --sout-transcode-fps=10 --sout-transcode-width=640 --sout-transcode-height=360 --sout-standard-access=http --sout-standard-mux=mpjpeg --sout-standard-dst=:9911/
```