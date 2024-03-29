namespace :users do
  task reset_password_all: :environment do
    User.transaction do
      User.all.each do |user|
        next if user.undefined_passsword?

        password = SecureRandom.hex(4)
        user.password = password
        user.skip_confirmation!
        user.save!
        puts "id: #{user.id}, password: #{password}"
        Users::Mailer.reset_user_info(user, password).deliver
      end
    end
  end
end
