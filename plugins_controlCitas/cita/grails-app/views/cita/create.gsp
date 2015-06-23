<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

		<script type="text/javascript">
  
	      $(function() {
	      var availableTags = [
	      "ActionScript",
	      "AppleScript",
	      "Asp",
	      "BASIC",
	      "C",
	      "C++",
	      "Clojure",
	      "COBOL",
	      "ColdFusion",
	      "Erlang",
	      "Fortran",
	      "Groovy",
	      "Haskell",
	      "Java",
	      "JavaScript",
	      "Lisp",
	      "Perl",
	      "PHP",
	      "Python",
	      "Ruby",
	      "Scala",
	      "Scheme"
	      ];
	      $( "#tags" ).autocomplete({
	      source: availableTags
	      });
	      });

	</script>
	
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">

			<div id="create-cita" class="content scaffold-create" role="main">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${cita}">
				<ul class="errors" role="alert">
					<g:eachError bean="${cita}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:form url="[resource:cita, action:'save']" >
					<fieldset class="form-horizontal">
						<g:render template="form"/>
					</fieldset>
					<fieldset class="buttons col-sm-offset-2">
						<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>

				<div class="ui-widget">
					<label for="tags">Tags: </label>
					<input id="tags">
				</div>

			</div>
		</div>
		<script>
			$(document).ready( setNavBarLista("${entityName}")  );
		</script>

		<script type="text/javascript">
		
		$(document).ready(function(){
			$.ajax({
				type: "GET",
				url: "controlCitas/cita/getAllExpedientes",
				success: function(response){

					$("#expediente").autocomplete({
						source: response
					});
				}
			});
		});

		</script>
	</body>
</html>
