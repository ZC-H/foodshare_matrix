class StaticController < ApplicationController

  def homedash
  	if !current_user
  		redirect_to '/sign_in'
  	end
  end

end