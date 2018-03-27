json.extract! persona, :id, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :fecha_nacimiento, :direccion, :bautizado, :epp, :edl, :observacion, :telefono, :celular, :email, :seguimiento, :created_at, :updated_at
json.url persona_url(persona, format: :json)
