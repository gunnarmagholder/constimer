class HomeController < ApplicationController
  def index
    if current_user
      if current_user.isRole('user')
        @assignment_request = Assignment.find_by_user_and_status(current_user.id, 1)
      end
    end
  end

  def faq
  end

  def about
  end

end
