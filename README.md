# HospitalGeneral


To run use the following

grails -Dhttps.protocols=TLSv1.2 clean --stacktrace

To create War
grails -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2" war controlCitas.war --stacktrace


To install the dependencies you need the certs of the repository add to java

Le tuve que instalar un certificado de seguyridad a Java para que puediera leer lo del repo

Windows
C:\Program Files\Java\jre1.8.0_421\lib\security\cacerts
keytool -import -alias example -keystore  "C:\Program Files\Java\jre1.8.0_421\lib\security\cacerts" -file certificado.jfrog.grails.crt

Mac
sudo keytool -importcert -trustcacerts -file /Users/daniel/Development/frameworks/certs/_.jfrog.io.pem -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home/jre/lib/security/cacerts -alias jfrogGrails

(changeit pass del cacert default)

### ejecutarlo con otro puerto
grails runApp -Dgrails.server.port.http=8090


para ejecutar con java 8 tuve que actualizar el release de spring que estan en la carpeta de grails para que levantara
https://stackoverflow.com/questions/28880781/incompatible-jvm-in-ggts-eclipse-and-java-1-8



### El mysql 8 tienes que cambiarle al password legaccy
> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Anitalavalatina01';
> FLUSH PRIVILEGES;

#### Para saber que metodo usa tu usuario
SELECT user, host, plugin FROM mysql.user;

### Generar Backup de Base de datos

sudo mysqldump -u root -p controlCitaDB > backup28Mar25.sql

scp -i /Users/daniel/Development/Development/repository/key/WebServerTest.pem ubuntu@ec2-18-219-43-224.us-east-2.compute.amazonaws.com:/home/ubuntu/backups/backup28Mar25.sql /Users/daniel/Development/Development/repository/backupsDatabaseHosp
// ssh -i /Users/daniel/Development/Development/repository/key/WebServerTest.pem ubuntu@ec2-18-219-43-224.us-east-2.compute.amazonaws.com

### Feature Backup de database
PAra poder ejeecutar el respaldo de la base de datos en el servicio es necesario tener acceso globalmente a mysqldump
Eso lo puedes hacer agregando al path del sistema operativo el folder en donde se encuentra mysqldump
