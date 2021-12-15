# https://nakedsecurity.sophos.com/2021/12/13/log4shell-explained-how-it-works-why-you-need-to-know-and-how-to-fix-it/

# C. Repackage your log4j-core-*.jar file by unzipping it, deleting the component called org/apache/logging/log4j/core/lookup/JndiLookup.class, 
# and zipping the other files back up again.
# 7-zip
# This works because Java Archives (.jar files) are actually just ZIP files with a specific internal layout.

$fold = "C:\temp\Log4Issue\log4j-core-2.15.0\log4j-core-2.15.0\*"
$zipfile = "C:\temp\Log4Issue\zipped\newlog4j-core-2.15.0.zip"
Compress-Archive -Path $fold -DestinationPath $zipfile

#Apache tomcat
# In your Tomcat /bin folder, you should have a tomcat5w.exe admin app (or in later versions tomcat6w.ex, tomcat8w.exe, etc).
#  Go to the Java tab and add the args in the "Java Options:" box.

-Dlog4j2.formatMsgNoLookups=True
