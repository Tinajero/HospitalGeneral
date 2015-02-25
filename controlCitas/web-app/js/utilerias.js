function setNavBarNuevo(entityName){
	var navbar = $("#contenedorNavbarPrincipal");

	//navbar.empty();
	navbar.append("<li><a class='create' href='/"+ entityName +"/create'>Nuevo</a></li>");
//	navbar.append("<li><g:link class='create' action='create'>Nuevo</a></li>");

}
function setNavBarLista(entityName){
	var navbar = $("#contenedorNavbarPrincipal");

	//navbar.empty();
	navbar.append("<li><a class='list' href='index'>Lista</a></li>");


}
function setNavBarShowEdit(text){
	var navbar = $("#contenedorNavbarPrincipal");

	navbar.empty();
	navbar.append(text);
	
}
/**
 * Esta funcion lo que hace es que a los objetos de la clase "alphaonly" evita que se escriban numeros
 * es decir solo permite que se escriba en ellas letras minusculas , y mayusculas, asi como la Ñ, asi como 
 * letras con acentos, y espacios en blanco por eso de los dos nombres.
 * 
 * en ese, es preferible usarla en los textfields
 * 
 * 
 */
function validateClassAlphaonly(){
	$('.alphaonly').bind( 'keyup blur', function(){
		var node = $(this);
		node.val(node.val().replace(/[^a-zA-ZñÑáéíóúùüö ]/g, ''));
		
	});
}