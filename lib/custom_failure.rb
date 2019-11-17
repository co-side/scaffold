class CustomFailure < Devise::FailureApp
  protected

  def redirect_url
    home_index_path
  end
end