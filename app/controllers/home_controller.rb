# encoding: utf-8

class HomeController < ApplicationController
  skip_authorization_check

  def index
    @buscar = params[:buscar]
    @dias_atras_seguimiento = Parametro.find_by(codigo: '001')
    @personas_asignadas = current_usuario.cantidad_personas_asignadas
    @personas_con_seguimiento = PersonaNotaSeguimiento.select(:persona_id)
                                                      .joins(persona: :asignado_a)
                                                      .where(personas_nota_seguimiento: { usuario_id: current_usuario.id},
                                                             asignaciones_seguimiento: { usuario_id: current_usuario.id})
                                                      .where('fecha >= ?',
                                                              Date.today - @dias_atras_seguimiento.valor.to_i.day)
                                                      .count

    @personas_sin_seguimiento = @personas_asignadas - @personas_con_seguimiento
    @porcentaje = (@personas_asignadas > 0 ? (@personas_con_seguimiento / (@personas_asignadas*1.0)) * 100 : 0.0).round(2)

  end

  def lista
    @personas = Persona.joins(:asignado_a)
                       .where(asignaciones_seguimiento: { usuario_id: current_usuario.id })
                       .order(:primer_nombre, :primer_apellido)
    @personas = @personas.por_nombre(params[:buscar]) unless params[:buscar].blank?
    render 'personas', layout: false
  end

end
