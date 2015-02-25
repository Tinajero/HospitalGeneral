<%@ page import="controlcitas.Usuario" %>



<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'username', 'error')} required">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="usuario.username.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<div  class="col-sm-4">
		<g:textField name="username" class="form-control" required="" value="${usuarioInstance?.username}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} required">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="usuario.password.label" default="Contraseña" />
		<span class="required-indicator">*</span>
	</label>
	
	<div  class="col-sm-4">
		<g:passwordField  name="password" required="" id="inputPassword" class="form-control" />
		
	</div>
</div>

<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} required">
	<label for="password2" class="col-sm-2 control-label">
		Repita la contraseña
		
	</label>
	
	<div  class="col-sm-4">
		<g:passwordField  name="password2" required="" id="inputPasswordConfirm" data-match="#inputPassword" data-match-error="Lo sentimos, la contraseña dada no coincide"  class="form-control"  />
		<div class="help-block with-errors"></div>
	</div>
</div>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'accountExpired', 'error')} ">--%>
<%--	<label for="accountExpired" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.accountExpired.label" default="Account Expired" />--%>
<%--		--%>
<%--	</label>--%>
<%--	--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="accountExpired"  value="${usuarioInstance?.accountExpired}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'accountLocked', 'error')} ">--%>
<%--	<label for="accountLocked" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.accountLocked.label" default="Account Locked" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="accountLocked" value="${usuarioInstance?.accountLocked}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'enabled', 'error')} ">--%>
<%--	<label for="enabled" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.enabled.label" default="Enabled" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="enabled" value="${usuarioInstance?.enabled}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'passwordExpired', 'error')} ">--%>
<%--	<label for="passwordExpired" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.passwordExpired.label" default="Password Expired" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="passwordExpired" value="${usuarioInstance?.passwordExpired}" />--%>
<%--	</div>--%>
<%--</div>--%>

