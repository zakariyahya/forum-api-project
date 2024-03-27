# app/controllers/emails_controller.rb
class EmailsController < ApplicationController
    def send_email
      user_email = params[:email]
      EmailWorker.perform_async(user_email)
      render json: { message: 'Email will be sent asynchronously.' }, status: :accepted
    end
  end
  