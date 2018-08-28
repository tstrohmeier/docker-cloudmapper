#
# Dockerfile for cloudmapper
#

FROM tstrohmeier/awscli:latest

MAINTAINER Thomas Strohmeier

RUN apt-get update \
	&& apt-get install -y autoconf automake libtool python3-dev \
	&& apt-get clean \
	&& git clone https://github.com/duo-labs/cloudmapper.git 

WORKDIR cloudmapper/

COPY config.json config.json
COPY credentials  ~/.aws/credentials 

RUN pip3 install -r requirements.txt	\	
	&& python3 cloudmapper.py collect --config config.json \
	&& python3 cloudmapper.py prepare --config config.json

ENTRYPOINT ["python", "cloudmapper.py", "webserver", "--public"]	

EXPOSE 8000