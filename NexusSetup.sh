#Nexus setup: http://clusterfrak.com/sysops/app_installs/nexus_install/#download-nexus-repository-oss

#go to root user: sudo -i or sudo su

#First section  Execute the commands - Start

sudo -i

#Install the packages that are needed to support Nexus Repository OSS

yum clean all
yum -y install sudo vim wget net-tools java-1.8.0-openjdk.x86_64

#Create Installation Directory

mkdir /opt/nexus
cd /opt/nexus

#Download Nexus Repository OSS

wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
#Unzip the nexus package

tar -xzvf nexus-latest-bundle.tar.gz

#Copy Init Script: Crosscheck the below source path before you run this command

cp /opt/nexus/nexus-2.14.8-01/bin/nexus /etc/init.d/

#Change the Init Script with NEXUS_HOME path : Manual update
#vi /etc/init.d/nexus
#NEXUS_HOME="/opt/nexus/nexus-2.14.8-01"

#Add the Nexus User & set direcxtory permissions.

#First section - end  execute the below commands manually

useradd nexus

chown -R nexus:nexus /opt/nexus/
chown nexus:nexus /etc/init.d/nexus

# Second section  execute the below commands manually - start

#cat /opt/nexus/nexus-2.14.8-01/conf/nexus.properties : Crosscheck this path & nexus.properties content.

#nexus-webapp-context-path=/nexus

# Second section End

#Third section  start  execute the below commands manually

#Login to nexus user & start nexus

su nexus
/etc/init.d/nexus start

#Third section  end

#Fourth section  Check the nexus in the browse using the public IP along with the port.

#Launch the URL in any browser: http://<PublicIP>:8081/nexus

#Fourth section  end

#Note:

#Note-1: Marked with the words "Crosscheck" & "Update" for manual actions. Search for those words in this file and take an action accordingly.

#Note-2: Please "Crosscheck" whether those details are correct are not. Update the paths if they are different.

#Installation Procedure: Follow each section and execute the commands

#Step-1: execute the commands in the #First section, and then paste it on your terminal. All the commands will be executed one by one.

#Step-2: cat /opt/nexus/nexus-2.14.8-01/conf/nexus.properties  check if contents are displayed in your browser. (cat followed by command)

#Step-3: Manually you need to update the file /etc/init.d/nexus with NEXUS HOME as instructed in line number after first section.

#Step-4: Login with below default credentials in nexus. Click the sign in button and provide the below details.

#default user credentials

#Full admin access: Username/pwd: admin/admin123

#Partial admin access: Username/pwd: deployment/deployment123

#Go to maven home & update the settings.xml file with nexus user details.

#Example: vi /root/apache-maven-3.5.3/conf/settings.xml: update this settings file with below nexus credentials.
echo'
	<server>
		<id>deployment</id>
		<username>deployment</username>
		<password>deployment123</password>
	</server>
'
#Add the below details in your project pom.xml file. Make sure the IP is correct.

#<distributionManagement>

#	<repository>

#		<id>deployment</id> <!-- this ID should match with server id which we configure in settings.xml file. -->

#		<name>Nexus Release Repository</name>

#		<url>http://18.219.252.49:8081/nexus/content/repositories/releases/</url>
#	</repository>
#	<snapshotRepository>
#		<id>deployment</id>
#		<name>Nexus Snapshots Repository</name>
#		<url>http://18.219.252.49:8081/nexus/content/repositories/snapshots/</url>

#	</snapshotRepository>

#</distributionManagement>
