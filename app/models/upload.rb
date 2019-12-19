class Upload < ApplicationRecord
  enum status: [:init, :pending, :success, :failed, :canceled]
end
