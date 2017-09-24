class MicropostsController < ApplicationController
	before_action :signed_in_user, only:[:create, :destroy]

	def create
		@micropost = current_user.microposts.build(micropost_param)
		@user = current_user
		if @micropost.save
			flash[:success] = 'Micropost create'
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end
	def destroy
	end

	private
		def micropost_param
			params.required(:micropost).permit(:content)
		end
		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nill?
		end
end