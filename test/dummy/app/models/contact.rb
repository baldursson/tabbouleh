class Contact < ActiveRecord::Base
  validates :name, presence: { message: "was not entered" }, length: { minimum: 8, maximum: 50 }
  validates :phone_number, length: { within: 7..12 }, numericality: true
  validates :zip_code, length: { is: 5 }, numericality: { only_integer: true }
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :terms, acceptance: true
  validates :email, confirmation: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :email_confirmation, presence: true
  validates :human_test_one, numericality: { greater_than: 10, less_than: 20 }
  validates :human_test_two, numericality: { less_than_or_equal_to: 30 }
end
