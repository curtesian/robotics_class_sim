FROM gazebo:latest
# Gazebo latest uses ubuntu:focal as the base distro
# place here your application's setup specifics
CMD [ "gzserver", "my-gazebo-app-args" ]

# Environment params
ENV WS=/root/dev
ENV ROS_PATH=$WS/ros2_ws
ENV GAZEBO_PATH=$WS/gazebo
ENV ROS_DISTRIBUTION=foxy
ENV DEBIAN_FRONTEND=noninteractive


# Install essentials
RUN \
	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		apt-utils \
		software-properties-common \
	&& apt-get update \
	&& apt-get install -y \
		curl \
		gdb \
		git-gui \
		meld \
		mesa-utils \
		mpg123 \
		nautilus \
		libgl1-mesa-glx \
		libgl1-mesa-dri \
		stress \
		stress-ng \
		terminator \
		tmux \
		unzip \
		vim \
		vlc \
		wget \
	&& sed -i 's/geteuid/getppid/' /usr/bin/vlc \
	&& rm -rf /var/lib/apt/lists/*

# Setup rr, C++ reversable debugging
RUN \
	apt-get update \
	&& apt-get install -y \
		capnproto \
		ccache \
		cmake \
		coreutils \
		g++-multilib \
		libcapnp-dev \
		make \
		manpages-dev \
		ninja-build \
		pkg-config \
		python3-pexpect \
	# && git clone https://github.com/mozilla/rr.git \
	# && mkdir obj \
	# && cd obj \
	# && cmake ../rr \
	# && make -j8 \
	# && make install \
	&& rm -rf /var/lib/apt/lists/*


# Add github command line
RUN \
	apt-get update \
	#&& apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
	#&& apt-add-repository https://cli.github.com/packages \
	#&& apt-get update \
	#&& apt-get install -y \
	#	gh \
    && apt-get -y install git \
	&& rm -rf /var/lib/apt/lists/*

# Setup Pycharm
ARG PYCHARM_VERSION=pycharm-community-2020.3.3
RUN \
	wget https://download.jetbrains.com/python/${PYCHARM_VERSION}.tar.gz \
	&& mv pycharm-community-* pycharm-community.tar.gz \
	&& tar xfz pycharm-*.tar.gz -C /opt/ \
	&& rm pycharm-community.tar.gz \
	&& echo "alias pycharm=\"/opt/${PYCHARM_VERSION}/bin/pycharm.sh\"" >> /root/.bashrc 

# Setup ROS2 Foxy from source as per
# https://docs.ros.org/en/foxy/Installation/Alternatives/Ubuntu-Development-Setup.html
RUN \
    # setup locale
	apt-get update && apt-get install locales \
	&& locale-gen en_US en_US.UTF-8 \
	&& update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
    # install development tools and ros tools
	&& apt-get update && apt-get install -y curl gnupg2 lsb-release \
	&& curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
	&& sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' \
	&& apt-get update \
	&& apt-get install -y \
		build-essential \
		cmake \
		git \
		libbullet-dev \
		python3-colcon-common-extensions \
		python3-flake8 \
		python3-pip \
		python3-pytest-cov \
		python3-rosdep \
		python3-setuptools \
        python3-testresources \
		python3-vcstool \
		wget 

	# install some pip packages needed for testing
RUN \
    apt-get update \
	&& python3 -m pip install -U \
		argcomplete \
		flake8-blind-except \
		flake8-builtins \
		flake8-class-newline \
		flake8-comprehensions \
		flake8-deprecated \
		flake8-docstrings \
		flake8-import-order \
		flake8-quotes \
		pytest-repeat \
		pytest-rerunfailures \
		pytest \
        pybind11-global \
		setuptools \
	# install Fast-RTPS dependencies
	&& apt-get install --no-install-recommends -y \
		libasio-dev \
		libtinyxml2-dev \
	# install Cyclone DDS dependencies
	&& apt-get install --no-install-recommends -y \
		libcunit1-dev \
	# setup the workspace
	&& mkdir -p $ROS_PATH/src \
	&& cd $ROS_PATH \
	&& wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos \
	&& vcs import src < ros2.repos \
	# install package dependencies
	&& rosdep init \
	&& rosdep update --include-eol-distros \
	&& rosdep install --from-paths src --ignore-src --rosdistro foxy -y --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers" \
	# setup bloom for making releases
	#&& apt-get install -y \
	#	python3-catkin-pkg \
	#	python3-bloom \
	&& rm -rf /var/lib/apt/lists/*

# Build the ROS2 workspace
RUN \
cd $ROS_PATH \
&& colcon build --symlink-install


# Personal preferences
RUN \
	echo " \
skip -gfi /usr/include/c++/*/*\n\
skip -gfi /usr/include/c++/*/*/*.h\n\
	" >> ~/.gdbinit \
	&& echo " \
sysctl kernel.perf_event_paranoid=1 > /dev/null\n\
source $ROS_PATH/install/setup.bash\n\
source /usr/share/vcstool-completion/vcs.bash\n\
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash\n\
alias gb='git branch -a'\n\
alias gcb='git checkout -b'\n\
alias gd='git diff HEAD'\n\
alias gg='git gui'\n\
alias gl='git log --pretty=oneline --graph'\n\
alias gs='git status'\n\
alias rh='cd $ROS_PATH'\n\
alias cdrr='cd /root/.local/share/rr/'\n\
alias cb='rh; colcon build --symlink-install'\n\
alias cbd='cb --cmake-args -DCMAKE_BUILD_TYPE=Debug'\n\
alias cbs='cb --packages-select'\n\
alias cbds='cbd --packages-select'\n\
alias cbu='cb --packages-up-to'\n\
alias cbdu='cbd --packages-up-to'\n\
alias code='code --user-data-dir /root/.visual_code/'\n\
alias ct='colcon test'\n\
alias ctl='ct --mixin linters-only'\n\
alias cts='ct --packages-select'\n\
alias ctls='ctl --packages-select'\n\
alias ctr='colcon test-result --verbose'\n\
alias ctra='colcon test-result --verbose --all'\n\
alias ctrd='colcon test-result --delete'\n\
alias gdb1='gdb --eval-command run --batch'\n\
alias vcscheckout='vcs custom --git --args checkout'\n\
alias STRESS='stress -c $(nproc) -m $(nproc) -i $(nproc) -d $(nproc)'\n\
function repeat { while \$1; do \$2:; done; }\n\
function repeatg { while gdb1 \$1; do \$2:; done; }\n\
function cbts { cbs $1 && cts $1 && ctr; }\n\
function update_ros2 { \n\
	rh\n\
	rm ros2.repos\n\
	wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos\n\
	vcs custom --args remote update\n\
	vcs import src < ros2.repos\n\
	vcs pull src\n\
	cb\n\
}\n\
bash -c 'echo /root/core_dumps/core.%e.%t > /proc/sys/kernel/core_pattern'\n\
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$ROS_PATH/build/test_rclcpp\n\
	" >> ~/.bashrc