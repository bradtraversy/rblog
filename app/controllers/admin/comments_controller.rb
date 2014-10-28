class Admin::CommentsController < Admin::ApplicationController
	before_filter :verify_logged_in
  def destroy
  end
end
