# encoding: utf-8

class Persona < ApplicationRecord

  include UpcaseAttributes
  include PgSearch

  audited
  strip_attributes

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :primer_nombre, presence: true,
                            length: { maximum: 20 },
                            format: { with: /\A[a-zA-Z\sáéíóúAÉÍÓÚÑñ]{0,100}\z/ }

  validates :segundo_nombre, length: { maximum: 20,
                                       allow_blank: true },
                             format: { with: /\A[a-zA-Z\sáéíóúAÉÍÓÚÑñ]{0,100}\z/,
                                       allow_blank: true }

  validates :primer_apellido, presence: true,
                              length: { maximum: 20 },
                              format: { with: /\A[a-zA-Z\sáéíóúAÉÍÓÚÑñ]{0,100}\z/ }

  validates :segundo_apellido, length: { maximum: 20,
                                         allow_blank: true },
                               format: { with: /\A[a-zA-Z\sáéíóúAÉÍÓÚÑñ]{0,100}\z/,
                                         allow_blank: true }

  validates :sexo, presence: true,
                   length: { maximum: 1 },
                   inclusion: { in: %w(F M) }

  validates :direccion, length: { maximum: 10_000,
                                  allow_blank: true }

  validates :observacion, length: { maximum: 10_000,
                                    allow_blank: true }

  validates :celular, length: { maximum: 10 },
                      format: { with: /\A[0-9]{0,10}\z/ }

  validates :telefono, length: { maximum: 10 },
                       format: { with: /\A[0-9]{0,10}\z/ }

  validates :email, length: { maximum: 30,
                              allow_blank: true },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/i,
                              allow_blank: true }

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  has_one :integrante_actividades

  has_one :asignado_a,
          class_name: 'AsignacionSeguimiento',
          foreign_key: 'persona_id'

  has_one :matrimonio_esposo,
          class_name: 'Matrimonio',
          foreign_key: 'esposo_id',
          inverse_of: :esposo

  has_one :matrimonio_esposa,
          class_name: 'Matrimonio',
          foreign_key: 'esposa_id',
          inverse_of: :esposa

  has_one :usuario,
          class_name: 'Usuario',
          foreign_key: 'persona_id'

  has_many :notas_seguimiento,
           class_name: 'PersonaNotaSeguimiento',
           foreign_key: 'persona_id'

  # ------------------------------------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------------------------------------
  before_destroy :relaciones?

  # ------------------------------------------------------------------------------------------------
  # Métodos
  # ------------------------------------------------------------------------------------------------

  def relaciones?
    errors.add(:base, 'Está relacionado a un matrimonio') if matrimonio_esposo.exist?
    errors.add(:base, 'Está relacionado a un matrimonio') if matrimonio_esposa.exist?
    errors.add(:base, 'Tiene notas de seguimiento') if notas_seguimiento.any?
    throw :abort if errors.any?
  end

  def nombre_completo
    [primer_nombre,
     segundo_nombre,
     primer_apellido,
     segundo_apellido].reject(&:blank?).join(' ')
  end

  pg_search_scope(:por_nombre,
                  against: [:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido],
                  using: {
                    tsearch: {
                      dictionary: 'spanish',
                      normalization: 2
                    }
                  })

  def usuario_seguimiento
    asignado_a.first
  end

  def tiene_notas_seguimiento?
    notas_seguimiento.any?
  end

  def esta_asignado_al_usuario?(usuario)
    AsignacionSeguimiento.where(persona_id: id, usuario_id: usuario.id).any?
  end

  def tiene_matrimonio?
    matrimonio_esposo.present? || matrimonio_esposa.present?
  end

  def obtener_matrimonio
    try(:matrimonio_esposo) || try(:matrimonio_esposa)
  end

  def con_nota_seguimiento_dentro_del_periodo(usuario)
    @dias_atras = Parametro.find_by(codigo: '001')
    notas_seguimiento.where(personas_nota_seguimiento: { usuario_id: usuario.id })
                             .where('fecha >= ?', Date.today - @dias_atras.valor.to_i.day).any?
  end

end
