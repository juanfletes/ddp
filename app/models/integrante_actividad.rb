# encoding: utf-8

class IntegranteActividad < ApplicationRecord

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------
  belongs_to :actividad
  belongs_to :matrimonio

end
