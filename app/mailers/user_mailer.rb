# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
    def welcome_email(user_email)
      mail(to: user_email, subject: 'Welcome to Our App!')
    end
  end
  