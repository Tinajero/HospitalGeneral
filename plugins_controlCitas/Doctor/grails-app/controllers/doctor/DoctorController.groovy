package doctor

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class DoctorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def DoctorService
    def HorarioService
	def SubServicioService
    def index(Integer max) {
        //Opcional. modificar la actualizacion de intervalos
        
        

        params.max = Math.min(max ?: 10, 100)
        respond Doctor.list(params), model:[doctorCount: Doctor.count()]
    }

    def show(Doctor doctor) {
        respond doctor
    }

    def create() {
        def horario = []
        def maxim = 0
		def subServicios = SubServicioService.obtienesLosSubServicios() // as grails.converters.JSON
        respond new Doctor(params),model:[horario: horario, horarioLength: maxim, subServiciosInstance:subServicios]
    }

    @Transactional
    def save(Doctor doctor) {
        

        if (doctor == null) {
            notFound()
            return
        }
              
      doctor.diasLaborales = DoctorService.obtenerDiasLaboralesPorHorario(params.horario)              
      doctor.validate()
      
      
  
        if (doctor.hasErrors()) {
            print "tiene errores"
            print doctor.errors
            respond doctor.errors,view:'create', model:[doctor:doctor]
            return
        }
   
        doctor.save flush:true
        HorarioService.crearHorarioParaDoctor(doctor, params.horario)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'doctor.label', default: 'Doctor'), doctor.id])
                redirect doctor
            }
            '*' { respond doctor, [status: CREATED] }
        }
    }
    
    def edit(Doctor doctorInstance) {
        print "edit recibe " + doctorInstance
       // def horario = DoctorService.jsonHorario(doctorInstance.horario);
       def horario = HorarioService.obtenerHorarioDeDoctor(doctorInstance?.id)
	   def subServicios = SubServicioService.obtienesLosSubServicios()
       def maxim = 0  
       for (int i = 0; i < horario.size() ; i++){
           if (maxim < horario[i].size()) maxim = horario[i].size()
       }
       print horario
       respond doctorInstance, model:[horario: horario, horarioLength: maxim, subServiciosInstance:subServicios]
    }

    @Transactional
    def update(Doctor doctorInstance) {
        
       
        doctorInstance.diasLaborales = DoctorService.obtenerDiasLaboralesPorHorario(params.horario)              
        doctorInstance.validate()
      
    
        if (doctorInstance == null) {
            print "1fst"
            notFound()
            return
        }


        if (doctorInstance.hasErrors()) {
            print "2d"
            respond doctorInstance.errors, view:'edit'
            return
        }

        doctorInstance.save flush:true
        HorarioService.eliminarHorariosDeDoctor(doctorInstance.id)
        HorarioService.crearHorarioParaDoctor(doctorInstance, params.horario)

        request.withFormat {
            form multipartForm {
               print "3er"
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Doctor.label', default: 'Doctor'), doctorInstance.id])
                redirect doctorInstance
            }
            '*'{ respond doctorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Doctor doctor) {

        if (doctor == null) {
            notFound()
            return
        }
        HorarioService.eliminarHorariosDeDoctor(doctor.id)
        doctor.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Doctor.label', default: 'Doctor'), doctor.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'doctor.label', default: 'Doctor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	def obtieneSubServicioDeServicio(){
		def servicio = params.servicio
		//println "servicioo" + servicio
		def subServicios = SubServicioService.obtieneLosSubServiciosDeUnServicio(servicio);
		def noSelection = ['':'Seleccione tipo de subServicio']
		render g.select(id:'comboSubServicios', name:'subServicio',
			from:subServicios, optionKey:'id', optionValue:'nombre', 
			class:'form-control' , 
		    noSelection:noSelection
		)
		//onchange:'cambioDoctor(this.value);',
	}
}
