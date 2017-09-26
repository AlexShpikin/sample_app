class Micropost < ApplicationRecord
	belongs_to :user
	default_scope -> {order('created_at DESC')}
	validates(:content, presence: {message: "Не должно быть пустым"}, length: {maximum: 140})
	validates(:user_id, presence: true)
	def self.from_users_followed_by(user)
	    #followed_user_ids = "SELECT followed_id FROM relationships
	    #                     WHERE follower_id = :user_id"
	    #where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
	    #      user_id: user.id)
	    Micropost.where(user_id:Relationship.where(follower_id:user.id).pluck(:followed_id))
	end
end
