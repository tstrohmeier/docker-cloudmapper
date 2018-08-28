#
# Dockerfile for cloudmapper
#

FROM tstrohmeier/awscli:latest as builder

MAINTAINER Thomas Strohmeier

RUN apt-get update \
	&& apt-get install -y autoconf automake libtool python3-dev \
	&& apt-get clean
	&& git clone https://github.com/duo-labs/cloudmapper.git 

WORKDIR cloudmapper/

RUN	 python3 -m venv ./venv  \
	&& . venv/bin/activate  \
	&& pip3 install -r requirements.txt 

COPY config.json cloudmapper/config.json	

RUN	 python3 cloudmapper.py prepare --config config.json

ENTRYPOINT ["python", "cloudmapper.py", "webserver"]	