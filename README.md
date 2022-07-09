# MoniTests

This project aims to explore JavaMOP for the 101Companies domain.
## Configuration

   * Install AspectJ locally. Follow the instructions from https://www.eclipse.org/aspectj/downloads.php

   * create a directory to hold the projects

```{shell}
$ mkdir projects
$ cd projects
```

   * clone and build the rv-monitor and java-mop projects
   
```{shell}
$ git clone https://github.com/PAMunb/rv-monitor.git
$ cd rv-monitor
$ git checkout statistics-1.4
$ mvn clean package install -DskipTests
$ cd ..

$ git clone https://github.com/PAMunb/javamop.git
$ cd javamop
$ git checkout statistics-4.0
$ mvn clean package install
$ cd ..
````

   * clone the maven plugin and build it

```{shell}
$ git clone https://github.com/PAMunb/mop-maven-plugin.git
$ cd mop-maven-plugin
$ mvn compile package install
```

   * clone this repository and configure your environment

```{shell}
$ export ASPECTJ_HOME=<PATH-TO-YOUR-ASPECTJ-INSTALLATION>
$ source ./config.sh
```

   * execute the test cases

```{shell}
$ mvn test
```

