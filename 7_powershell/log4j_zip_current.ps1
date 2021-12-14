$fold = "a-path\apache-log4j-2.15.0-bin\apache-log4j-2.15.0-bin\log4j-core-2.15.0\*" # zip the diretory you are standing in
$zipfile = "a-path\apache-log4j-2.15.0-bin\apache-log4j-2.15.0-bin\log4j-core-2.15.0\log4j-core-2.15.0.zip" # to this dir
Compress-Archive -Path $fold -DestinationPath $zipfile

