class StaticController < ApplicationController
  layout 'static'

  def terms
    render 'terms'
  end

  def help
    render 'help'
  end
end
