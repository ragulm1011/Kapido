FactoryBot.define do
  factory :admin_user do
    email { "MyString" }
    encrypted_password { "MyString" }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2023-05-24 12:07:37" }
    remember_created_at { "2023-05-24 12:07:37" }
  end
end
