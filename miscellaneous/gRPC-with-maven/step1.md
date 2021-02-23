# Step 1
## Install JAVA JDK or JRE

`sudo apt-get update`{{execute}}

`sudo apt-get install openjdk-8-jdk -y`{{execute}}

## Set Java Environment
1. Set the JAVA_HOME

`export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64`{{execute}}

2. Append Java compiler location to System Path.

`export PATH=$PATH:$JAVA_HOME/bin/`{{execute}}

3. Download Maven Archive

`wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz`{{execute}}

4. Extract the Maven Archive

To uncompress `tar xvzf apache-maven-3.6.3-bin.tar.gz`{{execute}}

5. Set Maven Environment Variables
Add M2_HOME, M2, MAVEN_OPTS to environment variables.

`sudo mv apache-maven-3.6.3 /usr/local`{{execute}}

6. Add Maven bin Directory Location to System Path

`cat << 'eof' >> ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin/
export M2_HOME=/usr/local/apache-maven-3.6.3
export M2=$M2_HOME/bin
export PATH=$PATH:$M2_HOME/bin
eof`{{execute}}

7. Verify Maven Installation

`mvn --version`{{execute}}

https://katacoda.com/nitikorn/scenarios/setup-java-and-maven
https://github.com/jpdna/gRPC-maven-helloworld