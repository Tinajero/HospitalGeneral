package busquedas

import grails.transaction.Transactional
import org.hibernate.Criteria
import cita.Cita
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
        print tiposCitas
        def currentSession = sessionFactory.currentSession
        def q = "select DATE_FORMAT(cita.fecha,'%Y-%m-%d') as Fecha " + datosMostrar +
                " from cita inner join paciente on cita.paciente_id = paciente.id "+
                "inner join doctor on doctor.id = cita.doctor_id " +
                "where FIND_IN_SET(doctor.tipo_cita, \""+ tiposCitas +"\") " +
                "and cita.fecha >= '" + params.fechaInicio + "'" +
                " and cita.fecha <= '" + params.fechaFin + "';"
        print q;
        def data = currentSession.createSQLQuery(q) 
        data.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);//if you are using alias for query e.g bank.credit_amount as creditAmount     
        final result = data.list()
        print result;
        return result;
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

        return sb.toString()
        
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
