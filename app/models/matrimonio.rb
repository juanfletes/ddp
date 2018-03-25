# encoding: utf-8

class Matrimonio < ApplicationRecord

  include PgSearch
  include UpcaseAttributes

  audited
  strip_attributes

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :esposo_id, uniqueness: true, presence: true

  validates :esposa_id, uniqueness: true, presence: true

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  belongs_to :esposo,
             class_name: 'Persona',
             foreign_key: 'esposo_id'

  belongs_to :esposa,
             class_name: 'Persona',
             foreign_key: 'esposa_id'

  has_many :actividades,
           class_name: 'IntegranteActividad',
           foreign_key: 'matrimonio_id'

  # ------------------------------------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------------------------------------
  before_destroy :relaciones?
  before_save :validar_boda_eclesiastica

  # ------------------------------------------------------------------------------------------------
  # Métodos
  # ------------------------------------------------------------------------------------------------

  def relaciones?
    errors.add(:base, 'Tiene participación en actividades') if actividades.any?
    throw :abort if errors.any?
  end

  pg_search_scope(:buscar,
                  associated_against: { esposo: [:primer_nombre,
                                                 :segundo_nombre,
                                                 :primer_apellido,
                                                 :segundo_apellido],
                                        esposa: [:primer_nombre,
                                                 :segundo_nombre,
                                                 :primer_apellido,
                                                 :segundo_apellido] },
                  using: {
                    tsearch: {
                      dictionary: 'spanish',
                      normalization: 2
                    }
                  })

  def self.todos
    count
  end

  def self.sin_matrimonio
    where(boda_civil: false).count
  end

  def self.solo_boda_civil
    where(boda_civil: true, boda_eclesiastica: false).count
  end

  def self.boda_civl_y_eclesiastica
    where(boda_civil: true, boda_eclesiastica: true).count
  end

  def tiene_actividades?
    actividades.any?
  end

  def participa_en_actividad?(actividad)
    actividades.where(actividad_id: actividad.id).exists?
  end

  def nombre
    esposo.primer_apellido + ' ' + esposa.primer_apellido
  end

  def situacion
    boda_eclesiastica || boda_civil ? 'MATRIMONIO' : 'PAREJA'
  end

  def situacion_nombre
    situacion + ' ' + nombre
  end

  def estado_civil
    if boda_eclesiastica
      2
    elsif boda_civil
      1
    else
      0
    end
  end

  def validar_boda_eclesiastica
    if boda_eclesiastica && !boda_civil
      errors.add(:base, 'No está permitido registrar boda eclesiástica si no ha marcado boda civil')
      throw :abort
    else
      return true
    end
  end

end
