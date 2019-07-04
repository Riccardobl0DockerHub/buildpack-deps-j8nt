FROM multiarch/crossbuild

RUN apt-get -y update && apt-get -y upgrade 

RUN apt-get install -y unzip

# Install java
COPY GetJava8.sh /tmp/GetJava8.sh
RUN chmod +x /tmp/GetJava8.sh &&\
mkdir -p /opt/java/jdk/lin64 &&\
mkdir -p /opt/java/jdk/win64 &&\
mkdir -p /opt/java/jre/lin64 &&\
mkdir -p /opt/java/jre/win64 

RUN /tmp/GetJava8.sh linux64 jdk /opt/java/jdk/lin64
RUN /tmp/GetJava8.sh win64 jdk /opt/java/jdk/win64 

RUN /tmp/GetJava8.sh linux64 jre /opt/java/jre/lin64 
RUN /tmp/GetJava8.sh win64 jre /opt/java/jre/win64

ENV JAVA_HOME=/opt/java/jdk/lin64

# Install gradle
RUN curl https://downloads.gradle.org/distributions/gradle-4.10-bin.zip -o /tmp/gradle.zip
RUN if [ "`sha256sum /tmp/gradle.zip | cut -d' ' -f1`" != "248cfd92104ce12c5431ddb8309cf713fe58de8e330c63176543320022f59f18" ];\
    then \
        echo "Error. This version of gradle is corrupted."; \
        exit 1;\
    fi && \
    mkdir -p /tmp/gradle && \
    unzip -q -d /tmp/gradle /tmp/gradle.zip &&\
    cp -Rf /tmp/gradle/gradle-*/* / &&\
    rm -Rf /tmp/gradle && rm -f /tmp/gradle.zip && \
    echo "Installed gradle `gradle -v`"
