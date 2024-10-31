# robotics_class_sim
Introductory robotics class in Gazebo with ROS 2.

Prerequisites: Ubuntu

## Running the docker container

TODO: What if instead of docker, I ran one sim on my computer, they connect to the ros network, subscribe and build their own publisher?

1. Install [Docker](https://docs.docker.com/engine/install/ubuntu/) and [Rocker](https://github.com/osrf/rocker), which enables x11 support for Docker. It can be installed with: 
```$ sudo apt-get install python3-rocker```

2. Enable nvidia-ctk support for docker graphics acceleration.
```
$ sudo nvidia-ctk runtime configure --runtime=docker
$ sudo systemctl restart docker
```

Docker pulls:
- `docker pull gazebo`
- `docker pull osrf/ros2:devel`

3. In this workspace, use the Dockerfile to build a docker image.
```$ docker build --tag 'ros2-gazebo' . ```

## Startup gazebo simulation environment:
```$ gz sim gazebo/class-world-v2.sdf```

## Startup ros topic conversion:
```$ ros2 run ros_gz_bridge parameter_bridge --ros-args -p config_file:=topics.yaml```