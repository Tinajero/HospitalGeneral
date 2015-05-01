package cita

import grails.transaction.Transactional

@Transactional
class CitaService {

    def serviceMethod() {

    }

}

class Calendario{
    
    //Variables privadas
    Calendar cG_cal = null //=  new GregorianCalendar(i_agno, i_mes, i_dia)
    def s_diaDeLaSemana = ['NO hay dia','Domingo','Lunes','Martes','Miercoles','Jueves', 'viernes','sabado']
    def i_diaSemana
    def s_diaSemana
    def i_diasMes
    def s_calendario = []
        
    //variables publicas
    def i_agno     //Valores a asignar=     2015
    def i_mes      //valores a asignar=    Calendar.MARCH
    def i_dia      //valores a asignar=    1
    
  
    def setDia(dia){
        this.i_dia = dia
    }
    
    def setMes(mes){
        this.i_mes = mes
    }
    
    def setAgno(agno){
        this.i_agno = agno
    
    }
    def getCalendario(){
       cG_cal = new GregorianCalendar(i_agno, i_mes, i_dia)
       setDias()
    }
    
    def setDias(){
         //Obtener numero de dias del mes selccionado
        i_diasMes      = cG_cal.getActualMaximum(Calendar.DAY_OF_MONTH)
        //Obtener el nombre del dia
        i_diaSemana    = cG_cal.get(Calendar.DAY_OF_WEEK)
        s_diaSemana    = s_diaDeLaSemana [  cG_cal.get(Calendar.DAY_OF_WEEK) ]
    }
    def imprimeValores(){
       
       println 'Dias del mes:'+i_diasMes+'el primer dia es:'+ s_diaSemana
       
    }
    
    def creaCalendario(){
        s_calendario = []
       def i_contador = 1
             
       for ( s_x  in s_diaDeLaSemana)
       {   
           i_contador++
           if ( i_contador > 2 )
               s_calendario.push(s_x)
       }

       i_contador = 1
       while ( i_contador < i_diaSemana)
       {
             s_calendario.push("x")   
             i_contador++
       }
       
       i_contador = 1
       
       while (  i_contador  <    i_diasMes+1 )
       {
         s_calendario.push(i_contador++)  
       
       }
        
    
    }
    
    def imprimeCalendario(){
        def i_contador = 1
    
        for (x in s_calendario)
        {
            print x+"\t|"
            if( i_contador++ % 7 == 0)
                println ""
        }
        
        println "======================"
    
    }
    
}
