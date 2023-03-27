class MasksController < ApplicationController
  def index
    @masks = Mask.all  
  end
end