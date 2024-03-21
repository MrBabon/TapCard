# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_21_092648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "association_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "entreprise_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entreprise_id"], name: "index_association_requests_on_entreprise_id"
    t.index ["user_id"], name: "index_association_requests_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.bigint "user1_id", null: false
    t.bigint "user2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user1_id"], name: "index_chatrooms_on_user1_id"
    t.index ["user2_id"], name: "index_chatrooms_on_user2_id"
  end

  create_table "contact_entreprises", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "entreprise_id", null: false
    t.bigint "event_id", null: false
    t.string "category"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entreprise_id"], name: "index_contact_entreprises_on_entreprise_id"
    t.index ["event_id"], name: "index_contact_entreprises_on_event_id"
    t.index ["user_id"], name: "index_contact_entreprises_on_user_id"
  end

  create_table "contact_groups", force: :cascade do |t|
    t.bigint "repertoire_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "deletable", default: true
    t.index ["repertoire_id"], name: "index_contact_groups_on_repertoire_id"
  end

  create_table "directors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_directors_on_organization_id"
    t.index ["user_id"], name: "index_directors_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "entreprise_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entreprise_id"], name: "index_employees_on_entreprise_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "entrepreneurs", force: :cascade do |t|
    t.bigint "entreprise_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entreprise_id"], name: "index_entrepreneurs_on_entreprise_id"
    t.index ["user_id"], name: "index_entrepreneurs_on_user_id"
  end

  create_table "entreprises", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "website"
    t.string "linkedin"
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "parrainage_code"
    t.string "headline"
    t.string "industry"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.string "link"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "registration_code"
    t.string "city"
    t.string "country"
    t.string "region"
    t.index ["organization_id"], name: "index_events_on_organization_id"
  end

  create_table "exhibitors", force: :cascade do |t|
    t.bigint "entreprise_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entreprise_id"], name: "index_exhibitors_on_entreprise_id"
    t.index ["event_id"], name: "index_exhibitors_on_event_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible_in_participants", default: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "repertoires", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repertoires_on_user_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.bigint "entreprise_id", null: false
    t.bigint "exhibitor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.bigint "entrepreneur_id"
    t.index ["entreprise_id"], name: "index_representatives_on_entreprise_id"
    t.index ["exhibitor_id"], name: "index_representatives_on_exhibitor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "linkedin"
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false, null: false
    t.string "phone"
    t.string "job"
    t.text "biography"
    t.string "industry"
    t.string "website"
    t.string "qr_code"
    t.string "entreprise_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_contact_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contact_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "personal_note"
    t.index ["contact_group_id"], name: "index_users_contact_groups_on_contact_group_id"
    t.index ["user_id"], name: "index_users_contact_groups_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "association_requests", "entreprises"
  add_foreign_key "association_requests", "users"
  add_foreign_key "chatrooms", "users", column: "user1_id"
  add_foreign_key "chatrooms", "users", column: "user2_id"
  add_foreign_key "contact_entreprises", "entreprises"
  add_foreign_key "contact_entreprises", "events"
  add_foreign_key "contact_entreprises", "users"
  add_foreign_key "contact_groups", "repertoires"
  add_foreign_key "directors", "organizations"
  add_foreign_key "directors", "users"
  add_foreign_key "employees", "entreprises"
  add_foreign_key "employees", "users"
  add_foreign_key "entrepreneurs", "entreprises"
  add_foreign_key "entrepreneurs", "users"
  add_foreign_key "events", "organizations"
  add_foreign_key "exhibitors", "entreprises"
  add_foreign_key "exhibitors", "events"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
  add_foreign_key "repertoires", "users"
  add_foreign_key "representatives", "entreprises"
  add_foreign_key "representatives", "exhibitors"
  add_foreign_key "users_contact_groups", "contact_groups"
  add_foreign_key "users_contact_groups", "users"
end
