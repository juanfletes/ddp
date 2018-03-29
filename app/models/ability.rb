class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Define abilities for the passed in user here. For example:
    #
    usuario ||= Usuario.new # guest user (not logged in)
    if usuario.es_admin?
      can :manage, :all
    elsif usuario.es_coordinador?

      can :read, PersonaNotaSeguimiento
      can :create, PersonaNotaSeguimiento, usuario_id: usuario.id
      can :update, PersonaNotaSeguimiento, usuario_id: usuario.id
      can :destroy, PersonaNotaSeguimiento, usuario_id: usuario.id

      can :read, Actividad
      can :matrimonios, Actividad
      can :read, IntegranteActividad

      can :read, CirculoAmistad

      can :manage, AsignacionSeguimiento

      can :manage, Matrimonio
      can :lista, Matrimonio
      can :guardar_seguimiento, Matrimonio
      can :obtener_nota, Matrimonio

      can :read, Parametro

      can :read, Usuario
      can :edit, Usuario
      can :asignaciones_seguimiento, Usuario
      can :agregar_seguimiento, Usuario
      can :quitar_seguimiento, Usuario

      # can :manage, Persona

    elsif usuario.es_discipulado?

      can :read, Matrimonio
      can :lista, Matrimonio
      can :guardar_seguimiento, Matrimonio
      can :obtener_nota, Matrimonio

      can :read, PersonaNotaSeguimiento
      can :create, PersonaNotaSeguimiento, usuario_id: usuario.id
      can :update, PersonaNotaSeguimiento, usuario_id: usuario.id
      can :destroy, PersonaNotaSeguimiento, usuario_id: usuario.id
    elsif usuario.es_apoyo?
      can :read, Matrimonio
    elsif usuario.consulta?

    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
