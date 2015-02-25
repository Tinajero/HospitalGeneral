<html>
<head>
	<meta name='layout' content='main'/>
	<title><g:message code="springSecurity.login.title"/></title>
	<style type='text/css' media='screen'>
<%--	#login {--%>
<%--		margin: 15px 0px;--%>
<%--		padding: 0px;--%>
<%--		text-align: center;--%>
<%--	}--%>
<%----%>
<%--	#login .inner {--%>
<%--		width: 340px;--%>
<%--		padding-bottom: 6px;--%>
<%--		margin: 60px auto;--%>
<%--		text-align: left;--%>
<%--		border: 1px solid #aab;--%>
<%--		background-color: #f0f0fa;--%>
<%--		-moz-box-shadow: 2px 2px 2px #eee;--%>
<%--		-webkit-box-shadow: 2px 2px 2px #eee;--%>
<%--		-khtml-box-shadow: 2px 2px 2px #eee;--%>
<%--		box-shadow: 2px 2px 2px #eee;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .fheader {--%>
<%--		padding: 18px 26px 14px 26px;--%>
<%--		background-color: #f7f7ff;--%>
<%--		margin: 0px 0 14px 0;--%>
<%--		color: #2e3741;--%>
<%--		font-size: 18px;--%>
<%--		font-weight: bold;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .cssform p {--%>
<%--		clear: left;--%>
<%--		margin: 0;--%>
<%--		padding: 4px 0 3px 0;--%>
<%--		padding-left: 105px;--%>
<%--		margin-bottom: 20px;--%>
<%--		height: 1%;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .cssform input[type='text'] {--%>
<%--		width: 120px;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .cssform label {--%>
<%--		font-weight: bold;--%>
<%--		float: left;--%>
<%--		text-align: right;--%>
<%--		margin-left: -105px;--%>
<%--		width: 110px;--%>
<%--		padding-top: 3px;--%>
<%--		padding-right: 10px;--%>
<%--	}--%>
<%----%>
<%--	#login #remember_me_holder {--%>
<%--		padding-left: 120px;--%>
<%--	}--%>
<%----%>
<%--	#login #submit {--%>
<%--		margin-left: 15px;--%>
<%--	}--%>
<%----%>
<%--	#login #remember_me_holder label {--%>
<%--		float: none;--%>
<%--		margin-left: 0;--%>
<%--		text-align: left;--%>
<%--		width: 200px--%>
<%--	}--%>
<%----%>
<%--	#login .inner .login_message {--%>
<%--		padding: 6px 25px 20px 25px;--%>
<%--		color: #c33;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .text_ {--%>
<%--		width: 120px;--%>
<%--	}--%>
<%----%>
<%--	#login .inner .chk {--%>
<%--		height: 12px;--%>
<%--	}--%>
body {
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #eee;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
}
.form-signin .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

	</style>
</head>

<body>
<div id='login'>
	<div class='inner'>
		<div class='fheader'><g:message code="springSecurity.login.header"/></div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>

		<form method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='text_' name='j_username' id='username'/>
			</p>

			<p>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='text_' name='j_password' id='password'/>
			</p>

			<p id="remember_me_holder">
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
			</p>

			<p>
				<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
			</p>
		</form>
	</div>
	
</div>


 	<div class="container">
		<g:if test='${flash.message}'>--%>
			<div class='login_message'>${flash.message}</div>
		</g:if>
		
		
<%--      <form class="form-signin">--%>
<form action='${postUrl}' method='POST' id='loginForm' class="form-signin" autocomplete='off'>
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address"  name='j_username' id='username' required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" name='j_password' id='password' required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me" name='${rememberMeParameter}' id='remember_me'> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->


<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
