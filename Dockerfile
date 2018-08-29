#
# Dockerfile for cloudmapper
#

FROM tstrohmeier/awscli:latest

MAINTAINER Thomas Strohmeier

RUN apt-get update \
	&& apt-get install -y autoconf automake libtool python3-dev \
	&& apt-get clean \
	&& git clone https://github.com/duo-labs/cloudmapper.git \
	&& cd cloudmapper/ && pip3 install -r requirements.txt

WORKDIR cloudmapper/

COPY credentials  /root/.aws/credentials 
COPY config.json config.json

RUN python3 cloudmapper.py collect --config config.json
RUN python3 cloudmapper.py prepare --config config.json

ENTRYPOINT ["python", "cloudmapper.py", "webserver", "--public"]	

EXPOSE 8000