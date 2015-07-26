package cita

import grails.transaction.Transactional

@Transactional
class CitaService {

	def DoctorService 	
    def serviceMethod() {

    }

     /**
    * Servicio que regresa el horario del doctor dado un dia y un doctor
    * y checa las citas de ese dia para que
    * lo que regrese diga a que horas estan disponibles
    */
    def getHorarioWhitDoctorAndDate( int doctorId, String fechaQuery ){
        //print "CitaService "
        //print "fecha " + fechaQuery + " doctorid " + doctorId
        def doctorIdLong = new Long(doctorId)
        def inicioDia = Date.parse("d-M-yyyy HH:mm:ss", fechaQuery +" 00:00:00")        
        def finDia = Date.parse("d-M-yyyy HH:mm:ss", fechaQuery +" 23:59:59")
       	def query = Cita.executeQuery("from Cita cit where cit.fecha >= :startTime and cit.fecha < :endTime and cit.doctor.id = :doctorId", [startTime:inicioDia, endTime:finDia, doctorId:doctorIdLong])
       	return query     
    }


}



