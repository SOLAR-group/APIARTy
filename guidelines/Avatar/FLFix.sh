#!/bin/bash

# The path of containing Defects4J bugs.
d4jData=/avatar/AVATAR/D4J/Defects4JData/

# The path of Defects4J git repository.
d4jPath=/avatar/AVATAR/D4J/defects4j/

# The fault localization metric used to calculate suspiciousness value of each code line.
metric=Ochiai

# The buggy project ID: e.g., Chart_1
bugId=$1


java -Xmx4g -cp "/avatar/AVATAR/target/dependency/*" edu.lu.uni.serval.main.Main $d4jData $d4jPath $bugId $metric
