package busquedas

import grails.transaction.Transactional
import cita.Cita
@Transactional
class BusquedaDinamicaService {
    def sessionFactory
    def serviceMethod()
    {

    }

    def busquedaDinamica(params){
        
        def datosMostrar = obtieneParametrosMostrar(params)
        print datosMostrar
        def tiposCitas =obtieneCitas(params)
        print tiposCitas
        def currentSession = sessionFactory.currentSession
        def q = "select DATE_FORMAT(cita.fecha,'%Y-%m-%d')" + datosMostrar +
                " from cita inner join paciente on cita.paciente_id = paciente.id "+
                "inner join doctor on doctor.id = cita.doctor_id " +
                "where FIND_IN_SET(doctor.tipo_cita, \""+ tiposCitas +"\") " +
                "and cita.fecha >= '" + params.fechaInicio + "'" +
                " and cita.fecha <= '" + params.fechaFin + "';"
        print q;
        def data = currentSession.createSQLQuery(q)      
        final result = data.list()
        print result;
        return result;
    }

    def obtieneParametrosMostrar(params){        
        StringBuilder sb = new StringBuilder();
        Boolean tieneAntesDatos = false;
        if (params.Hora == "on"){
            sb.append(",DATE_FORMAT(cita.fecha,'%H:%i')");
            tieneAntesDatos = true;
        }

        if (params.nombrePacienteCheck == "on"){
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("paciente.nombre nombrePaciente, paciente.apellido_materno maternoPaciente, paciente.apellido_paterno apellidoPaterno");
            tieneAntesDatos = true;
        }

        if (params.Localidad == "on"){
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("paciente.poblacion");
            tieneAntesDatos = true;
        }
        if (params.telefonoCheck == "on"){
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("paciente.numero_telefono");
            tieneAntesDatos = true;
        }
        if (params.nombreDoctorCheck == "on"){
            if(tieneAntesDatos)
                sb.append(", ")
            sb.append("doctor.nombre, doctor.apellido_mat, doctor.apellido_pat");
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
}
