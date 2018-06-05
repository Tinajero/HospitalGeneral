package cita


import grails.converters.JSON
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured
import paciente.Paciente
import doctor.Doctor
@Transactional(readOnly = true)
@Secured(['ROLE_USER'])
class CitaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def CitaService
    def DoctorService
	def SpringSecurityService springSecurityService 
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cita.findAllByFechaBajaIsNull(params), model:[citaCount: Cita.count()]
    }

    def show(Cita cita) {        
        respond cita
    }

    def create() {
        respond new Cita(params)
				       
    }

    @Transactional
    def save(Cita cita) {        
        if (cita == null) {
            notFound()
            return
        }
			
        if (cita.paciente.expediente != null) {
            def p = Paciente.findByExpedienteAndFechaBajaIsNull(cita.paciente.expediente)            
			if(p){			
                cita.paciente = p           
            }
        }
        //Colocar Si un paciente subsecuente ocupa un lugar de "Primera Vez" y si un paciente de primera vez ocupa un "subsecuente"
        if (cita.tipoCita != null) {
            //decimos qué tipo de cita fue asignada al horario seleccionado
            if(cita.tipoCita == 0){
                cita.asignadaA = "primera vez"
            }else if(cita.tipoCita == 1){
                cita.asignadaA = "subsecuente"
            }
        }
        
		def idUsuarioCreacion = springSecurityService.principal.id
		cita.usuarioCreacionId = idUsuarioCreacion
		cita.fechaCreacion = new Date();
				
		cita.paciente.usuarioCreacionId = idUsuarioCreacion
		cita.paciente.fechaCreacion = new Date();
		
        cita.validate()
		cita.paciente.validate()
        if (cita.hasErrors() || cita.paciente.hasErrors() ) { 
            respond cita.errors, view:'create', model:[cita:cita]
            return
        }			
        cita.paciente.save flush:true		
        cita.save flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*' { respond cita, [status: CREATED] }
        }
    }

    def edit(Cita cita) {
        respond cita
    }

    @Transactional
    def update(Cita cita) {
		
        if (cita == null) {
            notFound()
            return
        }
		
		def idUsuarioModificacion = springSecurityService.principal.id
		cita.usuarioModificacionId = idUsuarioModificacion
		cita.fechaModificacion = new Date();
		
		//Colocar Si un paciente subsecuente ocupa un lugar de "Primera Vez" y si un paciente de primera vez ocupa un "subsecuente"
		if (cita.tipoCita != null) {
			//decimos qué tipo de cita fue asignada al horario seleccionado
			if(cita.tipoCita == 0){
				cita.asignadaA = "primera vez"
			}else if(cita.tipoCita == 1){
				cita.asignadaA = "subsecuente"
			}
		}
		
        if (cita.hasErrors()) {
            respond cita.errors, view:'edit'
            return
        }
		
        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*'{ respond cita, [status: OK] }
        }
    }

    @Transactional
    def delete(Cita cita) {

        if (cita == null) {
            notFound()
            return
        }

		def idUsuarioElimina = springSecurityService.principal.id
		cita.usuarioBajaId = idUsuarioElimina
		cita.fechaBaja = new Date();
		
        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Cita.label', default: 'Cita'), cita.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cita.label', default: 'Cita'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
    def tipoCitaCambiada(String tipoCita, String turno){                       
        def doctores = DoctorService.getDoctoresWhitTipoCita( tipoCita, Integer.parseInt(turno) );        
        def noSelection = ['':'Seleccione un Medico']
        render g.select(id:'cbDoctores', name:'cita.doctor.id',
            from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control' , onchange:'cambioDoctor(this.value);',			
           noSelection:noSelection, required:'true'
        )
    }

    def mostrarHorario(int doctorID, String fecha){
        def ret = CitaService.mostrarHorario(doctorID, fecha);
        render ret as JSON
    }
    def otraFuncion(){
        render "Hola Mundo"
    }
    //Funciones para Autocomplete en Citas
    def autocompleteByFullExpediente(String expediente){
        println "entra a autocompleteByFullExpediente";
        println expediente;
        def paciente = CitaService.getPacientesWithFullExpediente( expediente );
        render paciente as JSON
    }
    def autocompleteByExpediente(String expediente){
        println "entra a autocompleteByExpediente";
        println expediente;
        def pacientes = CitaService.getPacientesWithExpediente( expediente );
        render pacientes as JSON
    }
    def autocompleteByNombre(String nombre){
        println "entra a autocompleteByNombre";
        println nombre;
        def pacientes = CitaService.getPacientesWithNombre( nombre );
        render pacientes as JSON
    }
    def autocompleteByApaterno(String apaterno){
        println "entra a autocompleteByApaterno";
        println apaterno;
        def pacientes = CitaService.getPacientesWithApaterno( apaterno );
        render pacientes as JSON
    }
    def autocompleteByAmaterno(String amaterno){
        println "entra a autocompleteByAmaterno";
        println amaterno;
        def pacientes = CitaService.getPacientesWithAmaterno( amaterno );
        render pacientes as JSON
    }
    //End Funciones para Autocomplete en Citas
    def getBussyDays(String startTime,String endTime, Long doctorId){
        print "getBussyDays citaControler: "
        print startTime
        print endTime
        print doctorId
        def bussyDays = CitaService.getBussyDays(startTime, endTime, doctorId)
        render bussyDays as JSON
    }
}
