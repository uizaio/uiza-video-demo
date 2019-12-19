class Live < ApplicationRecord
  enum status: [:init, :pending, :success, :failed, :canceled]
end
