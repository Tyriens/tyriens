class GaleriesController < ApplicationController
  def show
    @images = current_user.images.order(created_at: :desc)
  end
end
