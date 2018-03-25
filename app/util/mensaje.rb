# encoding: utf-8

class Util::Mensaje
  def self.limpiar_mensaje(mensaje)
    mensaje
  end

  def self.mensajes_error_modelo(errors)
    error = "\n"
    errors.messages.each { |e| error << '* ' + e[1].join(" \n ") + "\n" }
    error
  end
end
