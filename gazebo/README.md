### Add gazebo folder to path in your bashrc
```
export IGN_GAZEBO_RESOURCE_PATH=[path-here]/robotics_class_sim/gazebo:$IGN_GAZEBO_RESOURCE_PATH
```

Also add sensor plugin path
```
export IGN_GAZEBO_SYSTEM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/ign-gazebo-6/plugins:$IGN_GAZEBO_SYSTEM_PLUGIN_PATH
```

Then source your environment:
```
source ~/.bashrc
```

Run gazebo with the class world using the command:
```
ign gazebo class-world.sdf
```
