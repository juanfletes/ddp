# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180323001811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actividades", force: :cascade do |t|
    t.string "nombre", limit: 1000, null: false
    t.date "fecha", null: false
    t.string "objetivo", limit: 10000, null: false
    t.string "reporte", limit: 100000
    t.integer "tipo", null: false
    t.string "observacion", limit: 10000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_actividades_on_nombre", unique: true
  end

  create_table "asignaciones_seguimiento", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id", null: false
    t.index ["persona_id"], name: "index_asignaciones_seguimiento_on_persona_id", unique: true
    t.index ["usuario_id"], name: "index_asignaciones_seguimiento_on_usuario_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "circulo_amistades", force: :cascade do |t|
    t.string "nombre", limit: 500, null: false
    t.string "direccion", limit: 1000, null: false
    t.string "horario", limit: 500, null: false
    t.boolean "pasivo", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_circulo_amistades_on_nombre", unique: true
  end

  create_table "integrante_actividades", force: :cascade do |t|
    t.bigint "actividad_id", null: false
    t.bigint "matrimonio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_id"], name: "index_integrante_actividades_on_actividad_id"
  end

  create_table "integrante_circulo_amistades", force: :cascade do |t|
    t.bigint "circulo_amistad_id", null: false
    t.bigint "persona_id", null: false
    t.integer "tipo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circulo_amistad_id"], name: "index_integrante_circulo_amistades_on_circulo_amistad_id"
    t.index ["persona_id"], name: "index_integrante_circulo_amistades_on_persona_id", unique: true
  end

  create_table "matrimonios", force: :cascade do |t|
    t.integer "esposo_id", null: false
    t.integer "esposa_id", null: false
    t.boolean "boda_civil", default: false, null: false
    t.boolean "boda_eclesiastica", default: false, null: false
    t.string "observacion", limit: 10000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["esposa_id"], name: "index_matrimonios_on_esposa_id", unique: true
    t.index ["esposo_id"], name: "index_matrimonios_on_esposo_id", unique: true
  end

  create_table "parametros", force: :cascade do |t|
    t.string "codigo", limit: 10, null: false
    t.string "nombre", limit: 1000, null: false
    t.string "valor", limit: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_parametros_on_codigo", unique: true
    t.index ["nombre"], name: "index_parametros_on_nombre", unique: true
  end

  create_table "personas", force: :cascade do |t|
    t.string "primer_nombre", limit: 100, null: false
    t.string "segundo_nombre", limit: 100
    t.string "primer_apellido", limit: 100, null: false
    t.string "segundo_apellido", limit: 100
    t.string "sexo", limit: 1, null: false
    t.date "fecha_nacimiento"
    t.string "direccion"
    t.boolean "bautizado", default: false, null: false
    t.boolean "epp", default: false, null: false
    t.boolean "edl", default: false, null: false
    t.string "observacion", limit: 10000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telefono", limit: 10
    t.string "celular", limit: 10
    t.string "email", limit: 250
    t.boolean "seguimiento", default: true
  end

  create_table "personas_nota_seguimiento", force: :cascade do |t|
    t.date "fecha", null: false
    t.bigint "persona_id", null: false
    t.bigint "usuario_id", null: false
    t.string "notas", limit: 10000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_personas_nota_seguimiento_on_persona_id"
    t.index ["usuario_id"], name: "index_personas_nota_seguimiento_on_usuario_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primer_nombre", null: false
    t.string "segundo_nombre"
    t.string "primer_apellido", null: false
    t.string "segundo_apellido"
    t.bigint "persona_id"
    t.string "sexo", limit: 1
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["persona_id"], name: "index_usuarios_on_persona_id"
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "usuarios_roles", id: false, force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_usuarios_roles_on_role_id"
    t.index ["usuario_id", "role_id"], name: "index_usuarios_roles_on_usuario_id_and_role_id"
    t.index ["usuario_id"], name: "index_usuarios_roles_on_usuario_id"
  end

  add_foreign_key "asignaciones_seguimiento", "personas"
  add_foreign_key "asignaciones_seguimiento", "usuarios"
  add_foreign_key "integrante_actividades", "actividades"
  add_foreign_key "integrante_actividades", "matrimonios"
  add_foreign_key "integrante_circulo_amistades", "circulo_amistades"
  add_foreign_key "integrante_circulo_amistades", "personas"
  add_foreign_key "matrimonios", "personas", column: "esposa_id"
  add_foreign_key "matrimonios", "personas", column: "esposo_id"
  add_foreign_key "personas_nota_seguimiento", "personas"
  add_foreign_key "personas_nota_seguimiento", "usuarios"
  add_foreign_key "usuarios", "personas"
end
