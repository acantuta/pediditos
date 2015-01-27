# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150126215415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categoriaentidades", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categoriaproductos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "entidad_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categoriaproductos", ["entidad_id"], name: "index_categoriaproductos_on_entidad_id", using: :btree

  create_table "detallepedidos", force: :cascade do |t|
    t.integer  "cantidad"
    t.integer  "costo_unit"
    t.integer  "costo_total"
    t.text     "comentario"
    t.integer  "producto_id"
    t.integer  "pedido_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "detallepedidos", ["pedido_id"], name: "index_detallepedidos_on_pedido_id", using: :btree
  add_index "detallepedidos", ["producto_id"], name: "index_detallepedidos_on_producto_id", using: :btree

  create_table "entidades", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "costo_delivery"
    t.integer  "pedido_minimo"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "categoriaentidad_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "tiempo_envio_aprox",  limit: 255
  end

  add_index "entidades", ["categoriaentidad_id"], name: "index_entidades_on_categoriaentidad_id", using: :btree

  create_table "pedidos", force: :cascade do |t|
    t.text     "comentario"
    t.string   "direccion_entrega"
    t.integer  "costo_total"
    t.integer  "usuario_id"
    t.integer  "entidad_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "cache"
    t.string   "estado",            default: "NUEVO"
  end

  add_index "pedidos", ["entidad_id"], name: "index_pedidos_on_entidad_id", using: :btree
  add_index "pedidos", ["usuario_id"], name: "index_pedidos_on_usuario_id", using: :btree

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "precio"
    t.integer  "entidad_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "productos", ["deleted_at"], name: "index_productos_on_deleted_at", using: :btree
  add_index "productos", ["entidad_id"], name: "index_productos_on_entidad_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre_completo"
    t.string   "dni"
    t.string   "telefono"
    t.string   "direccion"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "entidad_id"
  end

  add_index "usuarios", ["entidad_id"], name: "index_usuarios_on_entidad_id", using: :btree

  add_foreign_key "categoriaproductos", "entidades"
  add_foreign_key "detallepedidos", "pedidos"
  add_foreign_key "detallepedidos", "productos"
  add_foreign_key "entidades", "categoriaentidades"
  add_foreign_key "pedidos", "entidades"
  add_foreign_key "pedidos", "usuarios"
  add_foreign_key "productos", "entidades"
  add_foreign_key "usuarios", "entidades"
end
