class Live < ApplicationRecord
  enum status: [:init, :pending, :success, :failed, :canceled]

  before_create :generate_code

  def generate_code
    self.code = ('live_' + Time.now.to_i.to_s + self.id.to_s)
  end
end
