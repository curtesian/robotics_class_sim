# robotics_class_sim
Introductory robotics class in Gazebo with ROS 2.

Prerequisites: 
- Ubuntu 24.04
- ROS 2 Jazzy
- Gazebo Harmonic
- [ros_gz](https://github.com/gazebosim/ros_gz)

## Startup gazebo simulation environment:
```$ gz sim gazebo/class-world-v2.sdf```

## Startup ros topic conversion:
```$ ros2 run ros_gz_bridge parameter_bridge --ros-args -p config_file:=topics.yaml```

## TELEOP
To enable teleop, enable the Key Publisher by hitting the vertical three ellipses in the top right of the GUI. Search for *Key Publisher* and select. The controls are:
- **Up-arrow**: Forward
- **Down-arrow**: Backward
- **Left-arrow**: Left turn
- **Right-arrow**: Right turn
- **Ctrl key**: Stop motion 