# robotics_class_sim
Introductory robotics class in Gazebo with ROS 2.

Prerequisites: 
- Ubuntu 24.04
- ROS 2 Jazzy
- Gazebo Harmonic

## Startup gazebo simulation environment:
```$ gz sim gazebo/class-world-v2.sdf```

## Startup ros topic conversion:
```$ ros2 run ros_gz_bridge parameter_bridge --ros-args -p config_file:=topics.yaml```
