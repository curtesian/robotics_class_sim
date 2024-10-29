## Sensor configurations for husky models
The current default for the class is Sensor Config 5 with the following modifications:

1. Remove the left, right, and rear Blackfly cameras to reduce bandwidth. Only need the front camera for class purposes.
2. Copy all components of MARBLE_HUSKY_SENSOR_CONFIG_5 folder to the main gazebo folder so it is properly sourced by the world sdf file. Move contents of the husky SDF model into the world model.
3. Change one of the LIDARs to act as an ultrasonic range finder.

### MARBLE_HUSKY_SENSOR_CONFIG_1
CU's husky config with 3 D435i RGBD cameras, a pan-tilt turret, the Ouster OS1 64 channel lidar, and an RPLidar S1

### MARBLE_HUSKY_SENSOR_CONFIG_2
CU's husky config with 3 D435i RGBD cameras, a pan-tilt turret, the Ouster OS1 64 channel lidar, and an RPLidar S1 (same as 1)

### MARBLE_HUSKY_SENSOR_CONFIG_3
CU's husky config with 3 D435i RGBD cameras, a pan-tilt turret, the Ouster OS1 64 channel lidar, an RPLidar S1, and a Vividia HTI-301 LWIR thermal Camera

### MARBLE_HUSKY_SENSOR_CONFIG_4
CU's husky config with 3 D435i RGBD cameras, a pan-tilt turret, the Ouster OS1 64 channel lidar, an RPLidar S1 and a Vividia HTI-301 LWIR thermal Camera

### MARBLE_HUSKY_SENSOR_CONFIG_5
CU's husky config with 4 FLIR Blackfly Cameras, two Ouster OS1 64 channel lidars, two picoflex TOF cameras, and an RPLidar S1
