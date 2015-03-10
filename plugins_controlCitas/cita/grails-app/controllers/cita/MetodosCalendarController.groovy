package cita
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
@Secured(['ROLE_USER'])
class MetodosCalendarController {

    def index() { }

    def metodo () {
    	String operacion = params['method']
    	println "me mandaraon "  + operacion
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
    	Calendario calendario
    	calendario.subject = sub
    	calendario.startTime = st
    	calendario.endTime = et
    	calendario.isAllDayEvent = ade



    }
    def listCalendar(day, type){

    	Calendario calendario
    	def startTime, endTime
    	println day
    	println type
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
    			//println startTime
    			endTime = Date.parse("MM/dd/yyyy", day)
    			//creamos un objeto Calendar el cual tiene el metodo add
    			Calendar calendar = Calendar.getInstance()
    			// creamos el calendar con fecha a la que nos dieron
    			calendar.setTime(endTime) 
    			// y se le suma un mes segun lo hace en el php
    			calendar.add(Calendar.MONTH, 1)
    			// por ultimo regresamos a tipo Date
    			endTime = calendar.getTime()
    			//println endTime
    			break

    		case "week" :

    			startTime = Date.parse("MM/dd/yyyy", day)
    			Calendar calendar = Calendar.getInstance()
    			calendar.setTime(startTime)
    			calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY)
    			startTime = calendar.getTime()
    			//println startTime
    			endTime = startTime + 7
    			//println endTime
    			break
    		case "day" :
    			startTime = Date.parse("MM/dd/yyyy", day)
    			endTime = startTime + 1
    			//println startTime
    			//println endTime
    			break
    	}
    	return listCalendarByRange(startTime, endTime)

    }
    def listCalendarByRange(startTime, endTime){
    	def ret = [:]
    	JSON.use('deep')
    	ret['events'] = []
    	ret["issort"] = true
    	ret["start"] = startTime
    	ret["end"] = endTime
    	ret['error'] = null
    	Calendario calendario 
    	def query = Calendario.executeQuery("from Calendario cal where cal.startTime >= :startTime and cal.startTime < :endTime", [startTime:startTime, endTime:endTime])
    	def i = 0;
    	query.each{
    		//println it as  JSON
    		println i
    		ret['events'][i] = [
    							it.id, 
    							it.subject, 
    							it.startTime,
    							it.endTime,
    							it.isAllDayEvent,
    							0,//mas de un dia el evento
    							0,// evento recurring
    							it.color,
    							1,//editable
    							it.location,
    							''//attends ? no se ara que es eso
							]
    		i++;
    	}
    	//println ret as JSON
    	return ret
    }
    
}
