# encoding: utf-8

class HomeController < ApplicationController

  def index
    @buscar = params[:buscar]
  end

  def lista
    @personas = if current_usuario.es_admin? || current_usuario.es_coordinador?
                  Persona.where(seguimiento: true).order(:primer_nombre, :primer_apellido)
                else
                  Persona.joins(:asignado_a)
                         .where(asignado_a: { usuario_id: current_usuario.id })
                         .order(:primer_nombre, :primer_apellido)
                end
    @personas = @personas.buscar(params[:buscar]) unless params[:buscar].blank?
    render 'matrimonios', layout: false
  end

end
