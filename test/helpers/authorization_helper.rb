require 'json'
module AuthorizationHelper
  def sign_up(name, email, password)
    post '/signup/',
         params: {
           user: {
             name: name,
             email: email,
             password: password
           }
         },
         as: :json
  end

  def sign_in(email, password)
    post '/login/',
         params: {
           user: {
             email: email,
             password: password
           }
         },
         as: :json
    response.headers
  end

  def log_out(token)
    delete '/logout/',
           headers: {
             'Authorization': token
           }
  end
end