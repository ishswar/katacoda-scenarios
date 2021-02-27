
## Install JAVA JDK or JRE

   `sudo apt-get update`{{execute}}

   `sudo apt-get install openjdk-8-jdk tree -y`{{execute}}

## Get MAVEN
* Download Maven Archive

   `wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz`{{execute}}

* Extract the Maven Archive

   To uncompress `tar xvzf apache-maven-3.6.3-bin.tar.gz`{{execute}}

* Set Maven Environment Variables
   Add M2_HOME, M2, MAVEN_OPTS to environment variables.

   `sudo mv apache-maven-3.6.3 /usr/local`{{execute}}

* Add Maven bin Directory Location to System Path
   
`cat << 'eof' >> ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin/
export M2_HOME=/usr/local/apache-maven-3.6.3
export M2=$M2_HOME/bin
export PATH=$PATH:$M2_HOME/bin
eof`{{execute}}

* Source the .bashrc file

   `source ~/.bashrc`{{execute}}

* Verify Maven Installation

   `mvn --version`{{execute}}

### Expected output : 
  
```bash
Apache Maven 3.6.0
Maven home: /usr/share/maven
Java version: 1.8.0_282, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "4.15.0-122-generic", arch: "amd64", family: "unix"
```

