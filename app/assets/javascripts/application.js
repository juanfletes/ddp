// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require pnotify/index
//= require theme
//= require moment
//= require daterangepicker


// valores por defecto para peticiones ajax
$.ajaxSetup({
  type: 'POST',
  timeout: 60000,
  beforeSend: function(jqXHR, settings) {
    if (settings.url == 'none') {
      jqXHR.abort();
    } else {
      //notice.open();
    }
  },
  success: function() {
    //notice.remove();
  },
  error: function(x, t) {
    if (t === 'timeout') {
      mostrarMensaje('Error Timeout', 'Error tiempo de solicitud agotado', 'error');
    }
    notice.remove();
  },
  statusCode: {
    200: function() {
      //notice.remove();
    },
    401: function() {
      //notice.remove();
      document.location = '/';
    },
    405: function() {
      //notice.remove();
      document.location = '/';
    },
    422: function() {
      //notice.remove();
      document.location = '/login';
    },
    505: function() {
      //notice.remove();
      mostrarMensaje('Error 505', 'Error en el Servidor', 'error');
    },
    404: function() {
      //notice.remove();
    }
  }
});

/*Funcion para mandar notificaciones*/
function mostrarMensaje(titulo, mensaje, tipo) {
  var hideMsg = tipo != 'error';
  new PNotify({
    type:          tipo,
    title:         titulo,
    hide:          hideMsg,
    text:          mensaje,
    history:       {
      history: false
    },
    mouse_reset:   false,
    buttons:       {
      closer: true,
      sticker: true
    },
    animate_speed: 'fast',
    delay:         3000,
    remove:        true,
    mobile: {
      swipe_dismiss: true,
      styling: true
    }
  });
}

/*Funcion mostrar mensajes flash*/
function mostrarFlash(type, message) {
  if (type == 'alert') {
    tipo   = 'error';
    titulo = 'Error';
  } else if (type == 'notice') {
    tipo   = 'success';
    titulo = 'Información';
  } else if (type == 'info') {
    tipo   = 'info';
    titulo = 'Información';
  }
  mostrarMensaje(titulo, message, tipo);
}
