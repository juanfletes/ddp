# encoding: utf-8

class PersonaNotaSeguimiento < ApplicationRecord

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :fecha, presence: true

  validates :persona_id, presence: true

  validates :notas, presence: true,
                    length: { maximum: 10_000 }

  before_save :validar_si_acepta_seguimiento

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  belongs_to :persona
  belongs_to :usuario

  # ------------------------------------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------------------------------------

  def validar_si_acepta_seguimiento
    return true if persona.seguimiento
    errors.add(:base, 'No está permitido registrar seguimiento')
    throw :abort
  end

end
