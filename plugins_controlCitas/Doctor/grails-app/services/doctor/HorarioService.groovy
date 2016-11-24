package doctor

import grails.transaction.Transactional
import grails.converters.*
import org.codehaus.groovy.grails.web.json.*;

@Transactional
class HorarioService {

    def crearHorarioParaDoctor(Doctor doctor,String horarioJson){
        try {            
             def matrizHorarios = JSON.parse(horarioJson);                          
             for (int i = 0 ; i < matrizHorarios.size(); i++){                 
                 for (int j = 0; j < matrizHorarios[i].size(); j++ ){                     
                     if ( matrizHorarios[i][j] != null && matrizHorarios[i][j].toString() != "null" ){
                         Horario  horario = new Horario();
                         horario.hora = Integer.parseInt(matrizHorarios[i][j].hora)                                                  
                         horario.minuto = Integer.parseInt(matrizHorarios[i][j].minuto)                                                  
                         horario.tipoCita = matrizHorarios[i][j].tipoHora=="subsecuente"?1:0;                         
                         horario.doctor = doctor                        
                         horario.diaDeLaSemana = i;                         
                         horario.save flush:true                         
                     }
                 }
             }
           

        } catch(Exception e){            
            e.printStackTrace();
        }
    }

    def obtenerHorarioJsonDeDoctorDiaSemana( doctorId, diaDeSemana){

         def resultado = Horario.executeQuery("select horario.hora, horario.minuto, horario.tipoCita from Horario horario where horario.doctor.id = :doctorId and horario.diaDeLaSemana = :diaDeSemana",[doctorId: doctorId, diaDeSemana: diaDeSemana]);
         
         return resultado
    }
}
