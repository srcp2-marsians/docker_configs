FROM nvidia/cudagl:10.2-devel-ubuntu18.04
MAINTAINER Paritosh Kelkar <paritoshskelkar@gmail.com>

COPY installers /tmp/installers
RUN bash /tmp/installers/pre_install.sh
RUN bash /tmp/installers/install_ros.sh

