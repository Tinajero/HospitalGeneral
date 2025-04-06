<!DOCTYPE html>
<html>
<!-- TODO Add a button to download the backUp of the database DatabaseBackupController -->
<head>
	<meta name="layout" content="mainAdmin">
	<g:set var="entityName" value="${message(code: 'backup.label', default: 'backup')}" />
	<title>
		<g:message code="default.create.label" args="[entityName]" />
	</title>
</head>

<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		<div id="create-backup" class="content scaffold-create" role="main">
			<h1>
				<g:message code="default.create.label" args="[entityName]" />
			</h1>
			<div class="row">
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
			</div>
			<div>
				<div class="backup-info">
					<h3>¿En qué consiste esta funcionalidad de respaldo?</h3>
					<p>
					  La generación de un respaldo crea una <strong>instantánea completa de la base de datos</strong> en el momento en que se ejecuta. 
					</p>
					<p>
					  El archivo resultante contiene <strong>información sensible</strong> y constituye una <strong>copia íntegra de los datos almacenados</strong>,
					</p>
					<p>  
					  por lo que debe ser resguardado y manejado con la debida precaución.
					</p>
					<p>  </p>
					<span></span>

					<p>
						Al completar la descarga, el navegador guardará un archivo ZIP en su carpeta de descargas. Este archivo estará nombrado con la <strong>fecha y hora exacta de creación</strong>, 
						lo que facilita su identificación y organización.
					  </p>
				  </div>				  
			</div>
			<g:form url = "[resource : databaseBackup, action : 'downloadBackup']">
				<fieldset class="buttons col-sm-offset-2">
					<g:submitButton name="backup" class="btn btn-default"
						value="${message(code: 'default.button.create.label', default: 'Create Backup')}" />
				</fieldset>
			</g:form>
		</div>
	</div>
	<script>
		$(document).ready(setNavBarLista("${entityName}"));
	</script>
	<asset:javascript src="funcionesCita.js" />
	<!-- script usados para el autocomplete de la vista de creacion Citas-->
	<asset:javascript src="autoCompleteMax.js" />
</body>

</html>