FactoryBot.define do
    factory :doorkeeper_application, class: 'Doorkeeper::Application' do
        name {"Postman API Checker"}
        redirect_uri {""}
        scopes {""}
    end 
end