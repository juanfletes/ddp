# encoding: utf-8

class Actividad < ApplicationRecord

  include UpcaseAttributes
  include PgSearch

  audited
  strip_attributes

  enum tipo: { actividad_mensual: 1,
               cena: 2,
               retiro: 3,
               boda_civil: 4,
               boda_eclesiastica: 5,
               charla_prematrimonial: 6 }

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :nombre, presence: true,
                     length: { maximum: 1000 }

  validates :objetivo, presence: true,
                       length: { maximum: 10_000 }

  validates :reporte, length: { maximum: 10_000 }

  validates :observacion, length: { maximum: 10_000 }

  validates :tipo, presence: true,
                   inclusion: { in: tipos.keys }

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  has_many :integrantes,
           class_name: 'IntegranteActividad',
           foreign_key: 'actividad_id'

  # ------------------------------------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------------------------------------
  before_destroy :relaciones?

  # ------------------------------------------------------------------------------------------------
  # Métodos
  # ------------------------------------------------------------------------------------------------

  def relaciones?
    errors.add(:base, 'Tiene participantes') if integrantes.any?
    throw :abort if errors.any?
  end

  def tiene_integrantes?
    integrantes.any?
  end

  pg_search_scope :buscar,
                  against: [:nombre],
                  using: {
                    tsearch: {
                      dictionary: 'spanish',
                      normalization: 2
                    }
                  },
                  order_within_rank: 'fecha DESC'

  def cantidad_integrantes
    integrantes.count
  end

  def self.todas
    count
  end

end
