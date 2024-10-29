### Add gazebo folder to path in your bashrc
```
export IGN_GAZEBO_RESOURCE_PATH=[path-here]/robotics_class_sim/gazebo:$IGN_GAZEBO_RESOURCE_PATH
source ~/.bashrc
```

Then gazebo with the class world using the command:
```
ign gazebo class-world.sdf
```
