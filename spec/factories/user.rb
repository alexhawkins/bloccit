 # create_table "users", force: true do |t|
 #    t.string   "name"
 #    t.string   "email",                  default: "",    null: false
 #    t.string   "encrypted_password",     default: "",    null: false
 #    t.string   "reset_password_token"
 #    t.datetime "reset_password_sent_at"
 #    t.datetime "remember_created_at"
 #    t.integer  "sign_in_count",          default: 0,     null: false
 #    t.datetime "current_sign_in_at"
 #    t.datetime "last_sign_in_at"
 #    t.string   "current_sign_in_ip"
 #    t.string   "last_sign_in_ip"
 #    t.string   "confirmation_token"
 #    t.datetime "confirmed_at"
 #    t.datetime "confirmation_sent_at"
 #    t.string   "unconfirmed_email"
 #    t.datetime "created_at"
 #    t.datetime "updated_at"
 #    t.string   "role"
 #    t.string   "avatar"
 #    t.text     "description"
 #    t.boolean  "email_favorites",        default: false
 #  end

FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    #This will generate a unique email for each person, 
    #which is great because Devise has a validation to 
    #check email uniqueness.
    sequence(:email) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end