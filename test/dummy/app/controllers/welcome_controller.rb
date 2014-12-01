class WelcomeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  end

  def exception
    message = params[:message] || 'SomeException'
    raise RuntimeError.new(message)
  end
end
