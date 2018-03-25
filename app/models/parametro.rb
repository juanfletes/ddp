# encoding: utf-8

class Parametro < ApplicationRecord

  audited
  strip_attributes

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :codigo, presence: true,
                     uniqueness: true,
                     length: { maximum: 10 }

  validates :nombre, presence: true,
                     uniqueness: true,
                     length: { maximum: 1000 }

  validates :valor, presence: true,
                    uniqueness: true,
                    length: { maximum: 1000 }

end
