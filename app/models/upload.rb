class Upload < ApplicationRecord
  enum status: [:init, :pending, :success, :failed, :canceled]

  scope :find_by_code, -> (code) { where(code: code) }
end
