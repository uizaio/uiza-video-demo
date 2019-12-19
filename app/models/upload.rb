class Upload < ApplicationRecord
  enum status: [:init, :pending, :success, :failed, :canceled]

  scope :find_by_code, -> (code) { where(code: code) }

  before_create :generate_code

  def generate_code
    self.code = (Time.now.to_i.to_s + self.id.to_s)
  end
end
