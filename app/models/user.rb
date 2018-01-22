class User < ApplicationRecord
  include Clearance::User
  has_many	:events
  enum role: [:community,:personal]

  # ========== Followers: Do not touch; black magic ==========

  # follower_joins "names" the Follow join table for accessing through the follower association
  has_many :follower_joins, foreign_key: :followtarget_id, class_name: "Follow"
  # source: :follower matches with the belong_to :follower identification in the Follow model 
  has_many :followers, through: :follower_joins, source: :follower

  # followtarget_joins "names" the Follow join table for accessing through the followtarget association
  has_many :followtarget_joins, foreign_key: :follower_id, class_name: "Follow"    
  # source: :followtarget matches with the belong_to :followtarget identification in the Follow model   
  has_many :followtargets, through: :followtarget_joins, source: :followtarget

  # ==========================================================

mount_uploader :avatar, AvatarUploader
end
