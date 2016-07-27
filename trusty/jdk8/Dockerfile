FROM buildpack-deps:trusty
MAINTAINER yanguanyu 
# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# ADD sources.list /etc/apt/sources.list


ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_102
ENV JRE_HOME ${JAVA_HOME}/jre

RUN apt-get update && apt-get install ca-certificates curl -y && \
	curl --silent --location --retry 3 --cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
	--header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.tar.gz \
	| tar xz -C /tmp && \
	mkdir -p /usr/lib/jvm && mv /tmp/jdk1.8.0_102 "${JAVA_HOME}" && \
	apt-get autoclean && apt-get --purge -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install "/usr/bin/java" "java" "${JRE_HOME}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
	update-alternatives --set java "${JRE_HOME}/bin/java" && \
	update-alternatives --set javac "${JAVA_HOME}/bin/javac"

