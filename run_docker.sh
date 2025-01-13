xhost +local:docker
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -e XDG_RUNTIME_DIR=/tmp/runtime-docker \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ./data:/root/data/ \
  orbslam3 ./Examples/Stereo/stereo_euroc Vocabulary/ORBvoc.txt Examples/Stereo/EuRoC.yaml /root/data/mav0 /root/data/mav0/mav0/cam0/data.csv /root/data/mav0/mav0/cam1/data.csv

