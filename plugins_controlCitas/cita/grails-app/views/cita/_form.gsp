<%@ page import="cita.Cita" %>


<div class="form-group ${hasErrors(brean: paciente, field: expediente, 'has error')} required">
	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="cita.paciente.label" default='Expediente'/>
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="paciente.expediente" id="expediente" placeholder="Introduce Expediente" class="form-control" required="" value="${cita?.paciente?.expediente}"/>
	</div>
  
</div>

<div class="form-group ${hasErrors(brean: paciente, field: nombre, 'has error')} required">
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="cita.paciente.nombre.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2">
		<g:textField name="paciente.apellidoPaterno" class="form-control" required="" placeholder="Apellido Paterno" value="${cita?.paciente?.apellidoPaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="paciente.apellidoMaterno" class="form-control" required="" placeholder="Apellido Materno" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="paciente.nombre" class="form-control" required="" placeholder="Nombre(s)" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: poblacion, 'has error')} required">
	<label for="Poblacion" class="col-sm-2 control-label">
		<g:message code="cita.paciente.poblacion.label" default="Poblacion" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="paciente.poblacion" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: telefono, 'has error')} required">
	<label for="Telefono" class="col-sm-2 control-label">
		<g:message code="cita.paciente.telefono.label" default="Telefono" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<input type="tel" name="paciente.numeroTelefono" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has error')} required">
	<label for="Tipo Cita" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Tipo de cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
	<%--	<g:select id="doctor" name="doctor.tipoCita" from="${ doctor.Doctor.list() }" optionKey="tipoCita" optionValue="tipoCita"required="" value="cita?.doctor?.tipoCita}" class="form-control"/> 
  optionKey="tipoCita" optionValue="tipoCita"
  --%>
    <g:select id="TipoCita" name="doctor.tipoCita" from="${doctor.Doctor.listUnique()}"  required="" value="${cita?.doctor?.tipoCita}" class="form-control" noSelection="[null:'']" onchange="categoryChanged(this.value);"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Medico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<%-- <g:select id="doctor" name="doctor.id" from="${doctor.Doctor.list()}" optionKey="id" optionValue="nombre" required="" value="cita?.doctor?.nombre}" class="many-to-one form-control"/> --%>
    <span id="subContainer"> </span>
    <script>
      /*function categoryChanged(tipoCita){
        console.log(tipoCita);
        <g:remoteFunction controller="cita" action="tipoCitaCambiada" update="subContainer" params="'tipoCita='+tipoCita" />
      }*/

     function categoryChanged(categoryId) {
        console.log(categoryId);
        jQuery.ajax({type:'POST',data:'tipoCita='+categoryId, url:'tipoCitaCambiada',success:function(data,textStatus){jQuery('#subContainer').html(data);},error:function(XMLHttpRequest,textStatus,errorThrown){}});
    }
    </script>

	</div>
</div>


<!-- <div class="fieldcontain ${hasErrors(bean: cita, field: 'fecha', 'error')} required">
	<label for="fecha" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:datePicker name="fecha" precision="day"  value="${cita?.fecha}"  />
	</div>	
</div> -->

<!-- <div class="fieldcontain ${hasErrors(bean: cita, field: 'paciente', 'error')} required">
	<label for="paciente">
		<g:message code="cita.paciente.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="paciente" name="paciente.id" from="${paciente.Paciente.list()}" optionKey="id" required="" value="${cita?.paciente?.id}" class="many-to-one"/>

</div> -->



<div>

      <div id="calhead" style="padding-left:1px;padding-right:1px;">          
            <div class="cHead"><div class="ftitle">My Calendar</div>
            <div id="loadingpannel" class="ptogtitle loadicon" style="display: none;">Loading data...</div>
             <div id="errorpannel" class="ptogtitle loaderror" style="display: none;">Sorry, could not load your data, please try again later</div>
            </div>          
            
            <div id="caltoolbar" class="ctoolbar">
              <div id="faddbtn" class="fbutton">
                <div><span title='Click to Create New Event' class="addcal">

                New Event                
                </span></div>
            </div>
            <div class="btnseparator"></div>
             <div id="showtodaybtn" class="fbutton">
                <div><span title='Click to back to today ' class="showtoday">
                Today</span></div>
            </div>
              <div class="btnseparator"></div>

            <div id="showdaybtn" class="fbutton">
                <div><span title='Day' class="showdayview">Day</span></div>
            </div>
              <div  id="showweekbtn" class="fbutton fcurrent">
                <div><span title='Week' class="showweekview">Week</span></div>
            </div>
              <div  id="showmonthbtn" class="fbutton">
                <div><span title='Month' class="showmonthview">Month</span></div>

            </div>
            <div class="btnseparator"></div>
              <div  id="showreflashbtn" class="fbutton">
                <div><span title='Refresh view' class="showdayflash">Refresh</span></div>
                </div>
             <div class="btnseparator"></div>
            <div id="sfprevbtn" title="Prev"  class="fbutton">
              <span class="fprev"></span>

            </div>
            <div id="sfnextbtn" title="Next" class="fbutton">
                <span class="fnext"></span>
            </div>
            <div class="fshowdatep fbutton">
                    <div>
                        <input type="hidden" name="txtshow" id="hdtxtshow" />
                        <span id="txtdatetimeshow">Loading</span>

                    </div>
            </div>
            
            <div class="clear"></div>
            </div>
      </div>
      <div style="padding:1px;">

        <div class="t1 chromeColor">
            &nbsp;</div>
        <div class="t2 chromeColor">
            &nbsp;</div>
        <div id="dvCalMain" class="calmain printborder">
            <div id="gridcontainer" style="overflow-y: visible;">
            </div>
        </div>
        <div class="t2 chromeColor">

            &nbsp;</div>
        <div class="t1 chromeColor">
            &nbsp;
        </div>   
        </div>
     
  </div>