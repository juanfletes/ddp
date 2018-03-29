# encoding: utf-8

class AsignacionSeguimiento < ApplicationRecord

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  # validates :usuario_id, presence: true

  # validates :persona_id, uniqueness: true, presence: true

  before_save :validar_sexo

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  belongs_to :persona
  belongs_to :usuario

  def validar_sexo
    return true if persona.sexo == usuario.sexo
    errors.add(:base, 'El sexo de la persona a dar seguimiento debe de ser igual al sexo del usuario')
    throw :abort
  end
end
