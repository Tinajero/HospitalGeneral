package busquedas

import grails.transaction.Transactional
import org.hibernate.Criteria


@Transactional
class BusquedaDinamicaService {
    def sessionFactory
    private List<String> listaPropiedades;
    def serviceMethod()
    {

    }

    def busquedaDinamica(params){
        
        def datosMostrar = obtieneParametrosMostrar(params)
        print datosMostrar
        def tiposCitas =obtieneCitas(params)
		def turnoMostrar = obtieneTurnosSeleccionados(params)
        print tiposCitas
        def currentSession = sessionFactory.currentSession

        def q = "select DATE_FORMAT(cita.fecha,'%Y-%m-%d') as fecha, doctor.tipo_cita as tipoCita, doctor.id as idDoctor " + datosMostrar +
                " from cita inner join paciente on cita.paciente_id = paciente.id "+
                "inner join doctor on doctor.id = cita.doctor_id " +
                "where FIND_IN_SET(doctor.tipo_cita, \""+ tiposCitas +"\") " +
				turnoMostrar + " " +
                "and cita.fecha >= '" + params.fechaInicio + " 00:00:00'" +
                " and cita.fecha <= '" + params.fechaFin + " 23:59:58' and cita.fecha_baja is null" +
				" and paciente.fecha_baja is null" 
				" order by doctor.tipo_cita,cita.fecha;"
        print ">> QUERY" + q;
        def data = currentSession.createSQLQuery(q) 
        data.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);//if you are using alias for query e.g bank.credit_amount as creditAmount     
        final result = convertirAObjetos(data.list())
        
        print ">>> RESULTADO" + result;
        return result;
    }

    def convertirAObjetos(listaResultados){
        //Cita cita;
        def listaAgrupador =[]
        def agrupados = [:]
        if (listaResultados == null || listaResultados.size() == 0 )
            return listaAgrupador;
        def anterior = listaResultados[0].idDoctor;
        def fechaAnterior = listaResultados[0].fecha
        def cita = [:]
        println anterior
        def doctor = [:]
        def primer = listaResultados[0]
        def listaCitas = []
        def listaFechas = []
        def fecha = [:]
        doctor.put('idDoctor', anterior )                                
        if (primer.containsKey('nombreDoctor')){
            doctor.put('nombreDoctor' , primer.nombreDoctor) 
            doctor.put('paternoDoctor', primer.paternoDoctor)
            doctor.put('maternoDoctor', primer.maternoDoctor)
			doctor.put('servicio', primer.tipoCita)
        }

        
		fecha.put('fecha', fechaAnterior)
		def row
        
        for (int i = 0; i < listaResultados.size(); ){
			
			
            row = listaResultados[i];
			
            def fechaActual = row.fecha;
            if ( row.idDoctor == anterior ){             
                if (fechaActual == fechaAnterior){                    
					cita = row;                  
                    listaCitas.add(row);					
                    
					++i;
					
					if(i == listaResultados.size() ){
						fecha.put('citas', listaCitas)
						listaFechas.add(fecha);						
						doctor.put('fechas', listaFechas)
						listaAgrupador.add(doctor)
						break;
					}
					
					
										
                } else {      
					              
                    fecha.put('citas', listaCitas)                    
                    listaFechas.add(fecha);
					listaCitas = []
					fecha = [:]
					fecha.put('fecha', fechaActual)
                   
                    fechaAnterior = fechaActual
                }

            } else {                                
                
				
				fecha.put('citas', listaCitas)
				listaFechas.add(fecha);
				listaCitas = []
				
                doctor.put('fechas', listaFechas)
                listaAgrupador.add(doctor)
                println row.idDoctor
				listaCitas = []
				listaFechas = []
				fecha = [:]
				fechaAnterior = row.fecha
				fecha.put('fecha', fechaAnterior)
                anterior = row.idDoctor;
                doctor = [:]
                doctor.put('idDoctor', row.idDoctor )                                
                if (row.containsKey('nombreDoctor')){
                    doctor.put('nombreDoctor' , row.nombreDoctor) 
                    doctor.put('paternoDoctor', row.paternoDoctor)
                    doctor.put('maternoDoctor', row.maternoDoctor)
					doctor.put('servicio', row.tipoCita)
                }
				
				
            }

        }

        for (int i  =0; i<listaAgrupador.size();i++){
            def d = listaAgrupador[i];
            println "."+d.nombreDoctor
            for (int j = 0; j < d.fechas.size();j++){
                def f = d.fechas[j];
                println ">"+f.fecha
                for (int m= 0 ; m < f.citas.size();m++){
                    def c = f.citas[m]
                    println "#"+c
                }
            }
        }
		
		println listaAgrupador
		return listaAgrupador
    }

    def obtieneParametrosMostrar(params){      
        listaPropiedades = new ArrayList<String>();   
        StringBuilder sb = new StringBuilder();
        Boolean tieneAntesDatos = true;
        if (params.Hora == "on"){
            listaPropiedades.add("Hora");
            sb.append(",DATE_FORMAT(cita.fecha,'%H:%i') as Hora");
            tieneAntesDatos = true;
        }

        if (params.nombrePacienteCheck == "on"){
            listaPropiedades.add("Paciente");
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("concat(paciente.nombre, ' ', paciente.apellido_materno, ' ', paciente.apellido_paterno) as Paciente ");
            tieneAntesDatos = true;
        }

        if (params.Localidad == "on"){
            listaPropiedades.add("Localidad");
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("paciente.poblacion as Localidad");
            tieneAntesDatos = true;
        }
        if (params.telefonoCheck == "on"){
            listaPropiedades.add("Telefono");
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("paciente.numero_telefono as Telefono");
            tieneAntesDatos = true;
        }
        if (params.nombreDoctorCheck == "on"){            
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("doctor.nombre as nombreDoctor, doctor.apellido_mat as maternoDoctor, doctor.apellido_pat as paternoDoctor");
            tieneAntesDatos = true;
        }
		if (params.numeroExpedientePacienteCheck == "on"){
			listaPropiedades.add("Expediente");
			if(tieneAntesDatos)
				sb.append(", ")
			sb.append("paciente.expediente as Expediente");
			tieneAntesDatos = true;
		}
		

        return sb.toString()
        
    }
	
	def obtieneTurnosSeleccionados(params){
		def parteConsulta = "";
		StringBuilder sb = new StringBuilder();
		Boolean tieneDatos = false;		
		println "#####"
		if(params.turnoVespertino == "on"){
			sb.append("doctor.turno = 2")	
			tieneDatos = true;
		}
		if(params.turnoMatutino == "on"){
			if(tieneDatos)
				sb.append(" and ")
			sb.append("doctor.turno = 1")
			tieneDatos = true;
		}
		
		if (tieneDatos){
			parteConsulta =" and " + sb.toString();
		} 
		print parteConsulta
		return parteConsulta
		
	}

    def obtieneCitas(params){
        def citas = "";
        StringBuilder sb = new StringBuilder();
        Boolean tieneAntesDatos = false;

        if (params.optradio_CIRUGIAGENERAL == "on"){
            sb.append("CIRUGIA GENERAL");
            tieneAntesDatos = true;
        }
        if (params.optradio_MEDICINAINTERNA == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("MEDICINA INTERNA");
            tieneAntesDatos = true;
        }
        if (params.optradio_PEDIATRIA == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("PEDIATRIA");
            tieneAntesDatos = true;            
        }
        if (params.optradio_GINECOLOGIAYOBSTETRICIA == "on"){
             if(tieneAntesDatos)
                sb.append(",")
            sb.append("GINECOLOGIA Y OBSTETRICIA");
            tieneAntesDatos = true;
        }
            
        if (params.optradio_TRAUMATOLOGIAYORTOPEDIA == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("TRAUMATOLOGIA Y ORTOPEDIA");      
            tieneAntesDatos = true;
        }
        if (params.optradio_DENTAL == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("DENTAL"); 
            tieneAntesDatos = true;   
        }
        if (params.optradio_PSICOLOGIA == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("PSICOLOGIA");  
            tieneAntesDatos = true;    
        }
        if (params.optradio_ULTRASONIDOS == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("ULTRASONIDOS");
            tieneAntesDatos = true;    
        }
        if (params.optradio_CONSULTAEXTERNA == "on"){
            if(tieneAntesDatos)
                sb.append(",")
            sb.append("CONSULTA EXTERNA");
            tieneAntesDatos = true; 
        }        

        return sb.toString();
    }

    def obtenPropiedades(){
        return listaPropiedades
    }
}