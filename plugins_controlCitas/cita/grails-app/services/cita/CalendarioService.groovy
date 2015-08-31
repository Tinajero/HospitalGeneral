package cita

import grails.transaction.Transactional

@Transactional
class CalendarioService {
	
    def serviceMethod() {


    }

    def setStartTime(def start){
    	startTime = start
    }
    def setEndTime(def end){
    	endTime = end
    }
    def getStartTime(){
    	return start;
    }
    def getEndTime(){
    	return end;
    }

}
