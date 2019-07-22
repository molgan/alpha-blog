class User < ApplicationRecord
  has_many :articles
  before_save {self.email = email.downcase}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensivity: false}, length: {minimum: 3, maximum: 25}
  validates :email, presence: true, uniqueness: {case_sensivity: false}, length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
end