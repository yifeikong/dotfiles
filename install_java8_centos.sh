#!/bin/sh

wget --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm" \
    -O jdk-8-linux-x64.rpm
sudo rpm -Uvh jdk-8-linux-x64.rpm
sudo alternatives --install /usr/bin/java java /usr/java/jdk1.8.0/jre/bin/java 20000
sudo alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0/bin/jar 20000
sudo alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0/bin/javac 20000
sudo alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0/jre/bin/javaws 20000

echo "current \$JAVA_HOME is $JAVA_HOME"

SET_JAVA_HOME='export JAVA_HOME=/usr/java/jdk1.8.0'
$SET_JAVA_HOME
echo $SET_JAVA_HOME >> $HOME/.bashrc
echo "setting it to /usr/java/jdk1.8.0"
echo "\$JAVA_HOME is now $JAVA_HOME and added to bashrc"
