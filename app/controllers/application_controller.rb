class ApplicationController < ActionController::Base
  helper_method :cart, :current_client, :current_artist



  def current_client#added in the current client
    return unless session[:client_id]
    @current_client ||= Client.find(session[:client_id])
  end

 def current_artist
   return unless session[:artist_id]
   @current_artist ||= Artist.find(session[:artist_id])
 end


  def cart
    session[:cart] ||= []
  end

  def add_art_to_the_cart(art_id)
    cart << art_id
  end

  def find_the_arts
    @arts_in_the_cart = Art.find(cart)
  end

  def client_logged_in?
    !!current_client
  end

  def artist_logged_in?
    !!current_artist
  end



  def authorized_client
    if !client_logged_in?
      flash[:notice] = "Please login!"
        redirect_to login_path
    end
  end

  def authorized_artist
    if !artist_logged_in?
      flash[:notice] = "Please login as Artist!"
      redirect_to "/login/artist"
    end
  end



end
