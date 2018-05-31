package hojaregistrodiario

import grails.transaction.Transactional
import cita.Cita
import java.util.Date
import java.text.SimpleDateFormat
import required.GeneratePDF

@Transactional
class HojaRegistroDiarioService {
	def sessionFactory
    def  grailsApplication
    def mapaResultado = [
      'CIRUGIA GENERAL':'cirugia',
      'MEDICINA INTERNA':'medicina_interna', 
      'PEDIATRIA':'pediatria', 
      'GINECOLOGIA Y OBSTETRICIA':'ginecobstetricia', 
      'TRAUMATOLOGIA Y ORTOPEDIA':'traumatologia',
      'DENTAL':'dental', 
      'PSICOLOGIA':'psicologia',
      'ULTRASONIDOS':'otras',
      'CONSULTA EXTERNA':'consulta_externa'
    ]
    String[] sources = ["cirugia",
      "medicina_interna", 
      "pediatria", 
      "ginecobstetricia",       
      "dental", 
      "otras", 
      "traumatologia",
      "consulta_externa",
      "psicologia"
    ]

    def serviceMethod() {

    }

//metodo que regresa el resultado de la consulta

  def consulta(date1, date2, tipoCita, doctorId)
  {
    def resultados=[]	
	def tipoCitaWhere = ""
	def doctorIdWhere = ""
	
	if(!tipoCita?.isEmpty()){
		tipoCitaWhere = "and doctor.tipo_cita like '%" + tipoCita + "%'";
	}

	if(doctorId != null){
		//nombreDoctorWhere = "and concat(doctor.nombre, ' ', doctor.apellido_pat, ' ', doctor.apellido_mat) like '%" + nombreDoctor + "%'";
		doctorIdWhere = "and doctor.id = " + doctorId
	}
	
	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd")
	def fechaInicio = formater.format(date1);
	def fechaFin = formater.format(date2);
	
	def consulta = 	"select doctor.tipo_cita as tipoCita, " +
		"concat(doctor.nombre, ' ', doctor.apellido_pat, ' ', doctor.apellido_mat) as doctorNombre, " +
        "doctor.curp as doctorCurp, " +
        "doctor.cedula_profesional as cedulaProfesional, " +
        "date_format(cita.fecha, '%d') as diaFecha, " +
        "date_format(cita.fecha,'%m') as mesFecha, " +
        "date_format(cita.fecha,'%y') as anioFecha, " +
        "concat(' ', paciente.nombre, ' ', paciente.apellido_paterno, ' ', paciente.apellido_materno) as nombrePaciente, " +
        "COALESCE(paciente.expediente, '') as expediente, " +
        "COALESCE(paciente.curp, '') as curp, " +
        "COALESCE(paciente.folio_seguro_popular,'') as seguroPaciente, " +
		"COALESCE(TIMESTAMPDIFF(YEAR, paciente.fecha_nacimiento, CURDATE()), '') as edad, " +
        "COALESCE(paciente.sexo, '') as sexo, " +
        "COALESCE(paciente.entidad_federativa,'') as entidadFederativa, " +
        "COALESCE(paciente.fecha_nacimiento, '') as fechaNacimiento " +
		
		"from cita inner join paciente " +
			"on cita.paciente_id = paciente.id " +
			"inner join doctor " +
			"on cita.doctor_id = doctor.id " +
    
		"where cita.fecha >= '"+fechaInicio+" 00:00' "+
			"and cita.fecha <= '"+fechaFin+" 23:59' " +
			tipoCitaWhere +
			doctorIdWhere +
			" and cita.fecha_baja is null " +
		"order by cita.doctor_id, " +
			"cita.fecha " 
			
	def currentSession = sessionFactory.currentSession
	resultados = currentSession.createSQLQuery(consulta)
	
    return resultados.list()
  }
  
  def obten_lista(resultado)
  {

    def key = ""
    def key_ant = ""
    def informe = []
    def value="";
	
    //Object es una instancia del registro n
    for (Object[] r in resultado)
    {

        //La llave es conformada por el nombre del doctor y el tipo de cita
        key = mapaResultado[r[0]]+'|'+r[1] +'|'+r[2]+'|'+r[3]+'|'+r[4]+'|'+r[5]+'|'+r[6]
        //Valors: Datos restantes y variantes
        
        if (key_ant=="")
          key_ant = key
  
        //Como analizar el ultimo caso
        if (key != key_ant)
        { 
          informe+= key_ant+'~'+value
          key_ant = key
          value=""
        }

        value += r[7]+'|'+r[8]+'|'+r[9]+'|'+r[10]+'|'+r[11]+'~'
         print ("key:"+key)
         print ("value."+value)
    } 

    if(value!="")
      informe+=key+'~'+value

    return informe

  }

	def list(params){
    /*SimpleDateFormat permite dar el formato para crear un objeto:Date
      ademas a la fecha obtenida se le agrega la hora para asignar un intervalo
    */
  		def resultados=[]
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
      def date1 = sdf.parse(params.fecha+" 00:00:00")
      def date2 = sdf.parse(params.fecha+" 23:59:59")
      def tipoCita = params.tipoCita;
	  def doctorId = params.doctorId;
      def lista = []
	  def ahora = new Date();
	  def nombreArchivo = params.fecha+"_"+ahora.getHours()+"_"+ahora.getMinutes()+".pdf"

      resultados = consulta(date1, date2, tipoCita, doctorId)
      
      lista = obten_lista(resultados)                        
      
      def lista_ret = [0,params.fecha, tipoCita]
      
      
      if ( resultados.size() < 1 )
      {
        lista_ret[0] = 0
        return lista_ret
      }
    printPDF(lista,params.fecha, nombreArchivo)
    lista_ret[0]=1
	lista_ret[3]= nombreArchivo
	return lista_ret

	}


  def printPDF(def lista,def fecha, def nombreArchivo)
  {
    try {
      def gpdf = new GeneratePDF();

      String[] arregloGenerico = [ "Tipo de cita", "doctorNombre", "curpDoctor",  "cedulaProfesional", "diaFecha", "mesFecha", "anioFecha"]
      String[] variables = ["nombrePaciente", "expediente", "curp", "seguroPaciente", "edad"]
      def s = grailsApplication.mainContext.getResource("temp_pdf/"+nombreArchivo).file      
      def e = grailsApplication.mainContext.getResource("plantillas_consultas").file      
      gpdf.setPathOut("" + s)
      gpdf.setPathTemplates("" + e + "/")
      gpdf.setTemplates(sources)
      gpdf.setPatterns(arregloGenerico, variables)           
      gpdf.generateBook(lista as String[], fecha as String)
    } catch(Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    /*
    try{
      def generar_pdf = new GeneratePDF()
      //Asignar direccion de impresion
      // print "Generando nuevo archivo"

      generar_pdf.setAddressPdf("web-app/temp_pdf/consulta.pdf")
      //Asignar campo de datos
      // print "Termina impresion"
      generar_pdf.setData(lista)
      //Crea el pdf y cuando termina cierra la aplicacion
      generar_pdf.createPdf()
    }catch(Exception e){
      // print "Un error aqui"
      e.// printStackTrace()
    }*/
  }
}
