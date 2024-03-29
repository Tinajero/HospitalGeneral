
package cita
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
import java.text.SimpleDateFormat
import java.util.concurrent.TimeUnit

@Secured(['ROLE_USER'])
class MetodosCalendarController {
    def CitaService;
    def CalendarioService
    def index() {  }  

    def consulta (){
        String operacion = params['method']
        //println "me mandaraon "  + params
        def ret         
        def startDate = Date.parse("yyyy-MM-dd", params['start'] )
        //println startDate
        def endDate = Date.parse("yyyy-MM-dd", params['end'] )
       // JSON.use('deep')
        ret = listCalendarByRangeAndDoctor( startDate, endDate, params['DoctorId'])
       // ret = "[\"0\",            {                \"allDay\": \"\",                \"title\": \"Test event\",                \"id\": \"821\",                                \"start\": \"2015-06-02T19:24:00Z\"            },            \"1\",            {                \"allDay\": \"\",                \"title\": \"Test event 2\",                \"id\": \"822\",                                \"start\": \"2015-06-03T19:24:00Z\"            }        ]"
        ////println ret
        //ret.size().times{
        //    //println ret[it] as JSON 
        //    render ret[it] as JSON
        //}
        render ret as JSON
    }
    def metodo () {
    	String operacion = params['method']
    	//println "me mandaraon "  + operacion
    	def ret 
    	JSON.use('deep')
    	switch( operacion ){
    		case "add" : 
    			ret = addCalendar(params['CalendarStartTime'], params['CalendarEndTime'], params['CalendarTitle'], params['IsAllDayEvent']   )
    			break
    		case "list" :
    			ret = listCalendar(params['showdate'], params['viewtype'])
    			break
    		case "update":
    			ret = updateCalendar( params['calendarId'], params['calendarStartTime'], params['calendarEndTime'])
    			break
    		case "remove":
    			ret = removeCalendar( params['calendarId'])
    			break
    		case "adddetails" :
    			st = params['stpartdate'] + " " + params['stparttime']
    			et = params['etpartdate'] + " " + params['etpartdate']
    			if ( params['id'] ) {
    				ret = updateDetailedCalendar( params['id'], st, et, params['subject'], params['IsAllDayEvent']?1:0, params['description'], params['location'], params['colorvalue'], params['timezone'] )

    			} else {
					ret = addDetailedCalendar( st, et, params['subject'], params['IsAllDayEvent']?1:0, params['description'], params['location'], params['colorvalue'], params['timezone'] )    				
    			}
    			break

    	}
    	//model :[ret:ret as JSON]
    	render ret as JSON
    	


    }

    def addCalendar(st, et, sub, ade){

    	def ret = [:]
    	def stt = Date.parse("MM/dd/yyyy hh:mm", st)
    	def ett = Date.parse("MM/dd/yyyy hh:mm", et)
    	Calendario calendario = new Calendario()

    	def isAllDayEvent = ade =="0"? false:true
    	
    	calendario.subject = sub
    	calendario.startTime = stt
    	calendario.endTime = ett
    	calendario.isAllDayEvent =  isAllDayEvent
		

    	calendario.save flush:true

    	ret['IsSuccess'] = true
      	ret['Msg'] = 'add success'
      	ret['Data'] = calendario.id
      	return ret
    }
    def listCalendar(day, type){

    	Calendario calendario
    	def startTime, endTime
    	//println day
    	//println type
    	switch(type) {
				/* 
    			la conversion fue dificil de encontrar 
    			http://stackoverflow.com/questions/3817862/groovy-string-to-date
    			http://www.java2s.com/Tutorial/Java/Date/Date_Convert/Convert_Calendar_to_Date_in_Java.htm
    			http://stackoverflow.com/questions/12899848/how-to-add-one-month-to-a-date-and-get-the-same-day
    			http://stackoverflow.com/questions/9307884/retrieve-current-weeks-mondays-date
    			*/
    		case "month":
    			// obtenemos el objeto Fecha, pues nos dan solo una cadena
    			startTime = Date.parse("MM/dd/yyyy", day)
    			////println startTime
    			endTime = Date.parse("MM/dd/yyyy", day)
    			//creamos un objeto Calendar el cual tiene el metodo add
    			Calendar calendar = Calendar.getInstance()
    			// creamos el calendar con fecha a la que nos dieron
    			calendar.setTime(endTime) 
    			// y se le suma un mes segun lo hace en el php
    			calendar.add(Calendar.MONTH, 1)
    			// por ultimo regresamos a tipo Date
    			endTime = calendar.getTime()
    			////println endTime
    			break

    		case "week" :

    			startTime = Date.parse("MM/dd/yyyy", day)
    			Calendar calendar = Calendar.getInstance()
    			calendar.setTime(startTime)
    			calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY)
    			startTime = calendar.getTime()
    			////println startTime
    			endTime = startTime + 7
    			////println endTime
    			break
    		case "day" :
    			startTime = Date.parse("MM/dd/yyyy", day)
    			endTime = startTime + 1
    			////println startTime
    			////println endTime
    			break
    	}
    	return listCalendarByRange(startTime, endTime)

    }
    def listCalendarByRangeAndDoctor(startTime, endTime, doctorId){
    	def ret = []
    	JSON.use('deep')
        
    	Calendario calendario         
        def doctor = Long.parseLong(doctorId, 10);
    	def query = Cita.executeQuery("from Cita cit where cit.fecha >= :startTime and cit.fecha < :endTime and cit.doctor.id = :doctorId and cit.fechaBaja is null ORDER BY cit.fecha", [startTime:startTime, endTime:endTime, doctorId:doctor])
        def i = 0;
               
    	query.each{            
    		ret[i] = [    							
						title: it.paciente.nombre + " " + it.paciente.apellidoPaterno + " " + it.paciente.apellidoMaterno,
	                    start: it.fecha.toString(),      					                          
	                    allDay : false,
						color: it.tipoCita.colorHexadecimal                        
					 ]
			
//			if(i > 0 && mismaFecha(ret[i-1]["start"] , it.fecha)){
//				ret[i-1]["end"] = it.fecha;
//			}
			
    		i++;
    	}
		
//		//println ret
		
    	return ret
    }
	
	def mismaFecha(fechaA, fechaB){
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		
		cal1.setTime(fechaA);
		cal2.setTime(fechaB);
		
		return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
			cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR) 	
	}
    
}
