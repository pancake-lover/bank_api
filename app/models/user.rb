class User < ApplicationRecord
  has_secure_password
  has_many :transfers

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :dob, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.from_token_request request
    username = request.params['auth'] && request.params['auth']['username']
    find_by username: username
  end
end
