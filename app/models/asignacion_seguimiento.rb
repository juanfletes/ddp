# encoding: utf-8

class AsignacionSeguimiento < ApplicationRecord

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :usuario_id, presence: true

  validates :persona_id, uniqueness: true, presence: true

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  belongs_to :persona
  belongs_to :usuario

end
