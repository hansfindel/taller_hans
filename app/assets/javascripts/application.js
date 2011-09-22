// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

//= require rails.validations
   
$(document).ready(function(){

function validar(){
	var mail=validaUser();
	var pass=validaPass();
	if(mail && pass){
		return true;
	}
	return false;
};

function validaUser() {
	var valid = true;
	var val = $('span.data input#mail').val();
  if (val == ''){
	alert("hola");	
  	valid=false;  	
  }
	return valid;
};

function validaPass() {
	var valid = true;
	var val = $('span.data input#password').val();
	var texto =''
  if (val == ''){
    texto=" *Este campo es requerido";  	
  }
  else if (val.length<4){
  	texto=" *Los passwords tienen más de 4 letras";  	
  }
  else if (val.length>16){
  	texto=" *Los passwords tienen menos de 16 letras";	
  }
  if (texto != ''){
	alert("hola");
  	valid=false;  	
  }
	return valid;
};

$('#mail').blur(function() {
  validaUser(); 
});

$('#password').blur(function() {
  validaPass(); 
});

 $("input").submit(function() {
 	alert("hola");
   return (validar());
 });

});
