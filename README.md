# How to use this image
## start a freeradius instance
This image does not have any freeradius configs by default. In order to start freeradius the configs
need to be passed in to /tmp/config folder at runtime.

## start freeradius
```
$ docker run -t -v $CONFIG_PATH:/tmp/config --name freeradius -d stepsaway/baseimage-freeradius freeradius -x -f
```
