class ColleaguesController < ApplicationController
  def index
    @colleagues = current_user.colleagues
    
  end
end
