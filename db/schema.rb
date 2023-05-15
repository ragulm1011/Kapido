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

ActiveRecord::Schema[7.0].define(version: 2023_05_15_052130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "door_no"
    t.string "street"
    t.string "city"
    t.string "district"
    t.string "state"
    t.integer "pincode"
    t.integer "addressable_id"
    t.string "addressable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bills", force: :cascade do |t|
    t.integer "ride_id"
    t.integer "payment_id"
    t.date "bill_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bill_amount"
  end

  create_table "booking_requests", force: :cascade do |t|
    t.string "city"
    t.string "booking_status"
    t.string "vehicle_type"
    t.integer "from_location_id"
    t.integer "to_location_id"
    t.integer "rider_id"
    t.string "from_location_name"
    t.string "to_location_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "liscense_no"
    t.float "driver_rating"
    t.string "standby_city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "primary_vehicle_id"
  end

  create_table "drivers_vehicles", force: :cascade do |t|
    t.integer "driver_id"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.string "landmark"
    t.string "city"
    t.integer "pincode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "rider_id"
    t.integer "driver_id"
    t.string "mode_of_payment"
    t.integer "amount"
    t.string "credentials"
    t.string "remarks"
    t.date "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bill_no"
  end

  create_table "riders", force: :cascade do |t|
    t.string "gender"
    t.string "aadhar_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.integer "rider_id"
    t.integer "driver_id"
    t.integer "booking_request_id"
    t.date "ride_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ride_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "age"
    t.string "mobile_no"
    t.integer "userable_id"
    t.string "userable_type"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_name"
    t.string "vehicle_type"
    t.integer "no_of_seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vehicle_no"
    t.integer "driver_no"
  end

end
