# app/workers/email_worker.rb
class EmailWorker
    include Sidekiq::Worker

    def perform(user_email)
        UserMailer.welcome_email(user_email).deliver_now
    end
end