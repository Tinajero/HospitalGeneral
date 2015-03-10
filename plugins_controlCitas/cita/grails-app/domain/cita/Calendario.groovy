package cita


class Calendario {

	String subject
  	String location
  	String description
   	Date startTime
  	Date endTime
  	Boolean isAllDayEvent
  	String color
  	String recurringRule

    static constraints = {
    	location nullable: true;
    	description nullable: true;
    	color nullable: true;
    	recurringRule nullable: true

    }
}
