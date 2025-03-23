# HospitalGeneral


To run use the following

grails -Dhttps.protocols=TLSv1.2 clean --stacktrace

To create War
grails -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2" war controlCitas.war --stacktrace