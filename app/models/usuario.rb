# encoding: utf-8

class Usuario < ApplicationRecord

  rolify
  audited
  strip_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable, :recoverable

  # ------------------------------------------------------------------------------------------------
  # Validaciones
  # ------------------------------------------------------------------------------------------------

  validates :primer_nombre, presence: true,
                            format: { with: /\A[a-zA-Z Ññ]*\z/ },
                            length: { maximum: 100 }

  validates :segundo_nombre, format: { with: /\A[a-zA-Z Ññ]*\z/ },
                             length: { maximum: 100 }

  validates :primer_apellido, presence: true,
                              format: { with: /\A[a-zA-Z Ññ]*\z/ },
                              length: { maximum: 100 }

  validates :segundo_apellido, format: { with: /\A[a-zA-Z Ññ]*\z/ },
                               length: { maximum: 100 }

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  # ------------------------------------------------------------------------------------------------
  # Relaciones
  # ------------------------------------------------------------------------------------------------

  has_many :notas_seguimiento,
           class_name: 'PersonaNotaSeguimiento',
           foreign_key: 'usuario_id'

  has_many :asignaciones_seguimiento,
           class_name: 'AsignacionSeguimiento',
           foreign_key: 'usuario_id'

  belongs_to :persona,
             class_name: 'Persona',
             foreign_key: 'persona_id',
             optional: true

  # ------------------------------------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------------------------------------
  before_destroy :relaciones?

  # ------------------------------------------------------------------------------------------------
  # Métodos
  # ------------------------------------------------------------------------------------------------

  def relaciones?
    errors.add(:base, 'Tiene matrimonios asignados') if asignaciones_seguimiento.any?
    errors.add(:base, 'Tiene notas de seguimiento') if notas_seguimiento.any?
    #errors.add(:base, 'Está relacionado a una persona') if persona.exists?
    throw :abort if errors.any?
  end

  def nombre_completo
    [primer_nombre,
     segundo_nombre,
     primer_apellido,
     segundo_apellido].reject(&:blank?).join(' ')
  end

  def es_admin?
    has_role?(:admin)
  end

  def es_coordinador?
    has_role?(:coordinador)
  end

  def es_discipulado?
    has_role?(:discipulado)
  end

  def es_apoyo?
    has_role?(:apoyo)
  end

  def es_consulta?
    has_role?(:consulta)
  end

  #  def role_ids
  #    rol_ids
  #  end

  # def role_ids=(value)
  #   rol_ids = value
  # end

  def es_matrimonio_asignado?(matrimonio)
    asignaciones_seguimiento.where(persona_id: matrimonio.esposo_id)
                            .or(asignaciones_seguimiento.where(persona_id: matrimonio.esposa_id))
                            .any?
  end

end
