<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="mainVentanilla">
    <g:set var="entityName" value="${message(code: 'BusquedaDinamica.label', default: 'Busqueda Dinamica')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">


        <g:form url="[resource:busquedasDinamica, action:'realizarBusqueda']">
            <h2>Busqueda Dinamica</h2>
            <fieldset class="form-horizontal">
                <g:render template="form" />
            </fieldset>
            <fieldset class="buttons">
                <g:submitButton name="buscar" class="btn btn-primary" value="Realizar Busqueda" />
            </fieldset>
        </g:form>

    </div>
    
</body>

</html>