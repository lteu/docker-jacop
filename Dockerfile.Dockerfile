FROM debian:stretch
MAINTAINER Jacopo Mauro

RUN apt-get update && \
	apt-get install -y \
		openjdk-8-jre-headless \
 		wget \
 		git && \
	rm -rf /var/lib/apt/lists/* && \
  mkdir -p /tool/jacop && \
	cd /tool/jacop && \
	wget http://central.maven.org/maven2/org/jacop/jacop/4.6.0/jacop-4.6.0.jar && \

	echo '#! /bin/sh \n\
java -jar /tool/jacop/jacop-4.6.0.jar "$@"' > /tool/jacop/fzn-jacop && \
	chmod 700 fzn-jacop && \
	git clone https://github.com/radsz/jacop.git && \
	mv jacop/src/main/minizinc/org/jacop/minizinc/ mzn-lib && \
	rm -rf jacop

ENV PATH "$PATH:/tool/jacop/"

# minizinc lib files in /tool/jacop/mzn-lib
