class GlobalController < ApplicationController
  def index
    @contacts = Contact.all
  end
end
