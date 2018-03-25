json.extract! usuario, :id, :email, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
