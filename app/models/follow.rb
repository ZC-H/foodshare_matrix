class Follow < ApplicationRecord
	belongs_to :follower, foreign_key: "follower_id", class_name: "User"
	belongs_to :followtarget, foreign_key: "followtarget_id", class_name: "User"
end