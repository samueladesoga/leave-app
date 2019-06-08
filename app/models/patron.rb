class Patron < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable, :confirmable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # self.abstract_class = true
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  has_many :leave_requests

  def send_devise_notification(notification, *args)
  	devise_mailer.send(notification, self, *args).deliver_later
  end

end
