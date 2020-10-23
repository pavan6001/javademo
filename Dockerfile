FROM tomcat:8
#Take war file and copy to webapps folder of Tpmcat
COPY dist/*.war /usr/local/tomcat/webapps/*.war
