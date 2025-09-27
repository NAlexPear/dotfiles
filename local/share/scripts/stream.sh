# kill all of the spawned child processes on SIGINT
trap 'kill 0' SIGINT;

# pipe webcam video to the video5 loopback device
ffmpeg -f v4l2 \
  -framerate 30 \
  -video_size 800x600 \
  -i /dev/video0 \
  -vcodec rawvideo \
  -filter:v "crop=480:480:200:100,setsar=1" \
  -f v4l2 \
  /dev/video5 &

# wait a bit for ffmpeg to initialize
sleep 1

# use gstreamer to overlay the cropped loopback output on the screen
gst-launch-1.0 -v v4l2src device=/dev/video5 ! glimagesink sync=False &

# record a region of the screen
gpu-screen-recorder -w region -region $(slurp -f "%wx%h+%x+%y") -a default_input -o "$1.mp4" &

# wait for all to finish (until the process is killed)
wait
