package hojaregistrodiario

import grails.transaction.Transactional
import cita.Cita
import java.util.Date
import java.text.SimpleDateFormat
import rkl.GenerarPdfv2

@Transactional
class HojaRegistroDiarioService {

    def serviceMethod() {

    }

//metodo que regresa el resultado de la consulta

  def consulta(date1, date2, tipoCita)
  {
    def resultados=[]
    def select ="select  date_format(c.fecha,'%H:%i'), d.nombre, d.apellidoPat, d.apellidoMat, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.tipoCita\
     from Cita as c, Doctor as d, Paciente as p ";
    def where = "where c.fecha >=? and c.fecha<=? and d.id = c.doctor and p.id = c.paciente";

    //si no se selecciono cita entonces procede con solo la fecha especificada
    if (tipoCita == "")
      resultados = Cita.executeQuery(	select + where + "  ORDER BY c.doctor, c.fecha ASC",[ date1, date2])
    else
      resultados = Cita.executeQuery(	select + where +  " and d.tipoCita = ?  ORDER BY c.doctor, c.fecha ASC",[ date1, date2, tipoCita])
//and d.tipoCita = ?  , params.tipoCita
    return resultados
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
      def lista = []

      resultados = consulta(date1, date2, tipoCita)

      if (tipoCita == "" )
        tipoCita="Todas"
		/*
    construcción de lista de mapas
    El objeto (lista) se rellenara con mapas para almacenar la informacion pertinente a la hora
      un mapa contine fecha, doctor y paciente
  */
    def lista_ret = [0,params.fecha, tipoCita]
    print "resultados obtenidos"
    if ( resultados.size() < 1 )
    {
      lista_ret[0] = 0
      print "Sin resultado"
      return lista_ret

    }
    print "En for"
		for ( Object[] r in resultados )
    {
			def map =	[	'fecha': r[0],
							'doctor': r[1]+" " + r[2]+" "+ r[3],
							'paciente' : r[4] +" "+ r[5] +" "+ r[6],
              'tipoCita' : r[7],
						]
				lista += map
        print map
		}

    printPDF(lista)
    lista_ret[0]=1
return lista_ret

	}


  def printPDF(def lista)
  {
    try{
      def generar_pdf = new GenerarPdfv2()
      //Asignar direccion de impresion
      print "Generando nuevo archivo"
      generar_pdf.setAddressPdf("web-app/temp_pdf/consulta.pdf")
      //Asignar campo de datos
      print "Termina impresion"
      generar_pdf.setData(lista)
      //Crea el pdf y cuando termina cierra la aplicacion
      generar_pdf.createPdf()
    }catch(Exception e){
      print "Un error aqui"
      e.printStackTrace()
    }
  }
}
