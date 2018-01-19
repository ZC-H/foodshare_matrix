class User < ApplicationRecord
  include Clearance::User
  has_many	:events
  enum role: [:community,:personal]
end
