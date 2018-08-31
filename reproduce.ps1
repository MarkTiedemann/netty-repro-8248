
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download OpenJDK 10.0.2+13 (Eclipse OpenJ9)
Invoke-WebRequest `
  -Uri "https://github.com/AdoptOpenJDK/openjdk10-openj9-releases/releases/download/jdk-10.0.2%2B13_openj9-0.9.0/OpenJDK10-OPENJ9_x64_Windows_jdk-10.0.2.13_openj9-0.9.0.zip" `
  -Out "OpenJDK10-OPENJ9_x64_Windows_jdk-10.0.2.13_openj9-0.9.0.zip"

# Extract .zip file
Expand-Archive `
  -Path "OpenJDK10-OPENJ9_x64_Windows_jdk-10.0.2.13_openj9-0.9.0.zip" `
  -DestinationPath .

# Download Netty 4.1.29
Invoke-WebRequest `
  -Uri "https://search.maven.org/remotecontent?filepath=io/netty/netty-all/4.1.29.Final/netty-all-4.1.29.Final.jar" `
  -Out "netty-all-4.1.29.Final.jar"

# Compile Main
& "jdk-10.0.2+13\bin\javac.exe" `
  --class-path "netty-all-4.1.29.Final.jar" `
  "Main.java"

# Execute Main
& "jdk-10.0.2+13\bin\java.exe" `
  --class-path "netty-all-4.1.29.Final.jar;." `
  --show-version `
  "Main"
