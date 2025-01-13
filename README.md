# ORB-SLAM3 - Docker

---

## Build the Docker Image

To build the Docker image for ORB-SLAM3, run the following command:

```bash
docker build -t orbslam3:latest .
```

---

## Download the Dataset

To get the required dataset for the example, run:

```bash
wget http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.zip
unzip -d data MH_01_easy.zip
```

## Run ORB-SLAM3

After building the Docker image, use the provided script to run ORB-SLAM3. 

### `run_docker.sh`

```bash
# Allow local connections to X11 (for GUI)
xhost +local:docker

# Run the Docker container with display and volume bindings
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -e XDG_RUNTIME_DIR=/tmp/runtime-docker \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ./data:/root/data/ \
  orbslam3 ./Examples/Stereo/stereo_euroc Vocabulary/ORBvoc.txt Examples/Stereo/EuRoC.yaml /root/data/mav0 /root/data/mav0/mav0/cam0/data.csv /root/data/mav0/mav0/cam1/data.csv
```

Run the script:

```bash
bash run_docker.sh
```
