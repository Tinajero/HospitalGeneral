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
    <div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main"> hola
            <g:each in="${lista}" status="i" var="dato">
                ${dato}
            </g:each>
    </div>
</body>

</html>