module RequestHelpers
  def authenticated_header(user)
    post '/api/auth/login', params: { user: { email: user.email, password: 'password' } }
    token = JSON.parse(response.body)['token']
    { 'Authorization': "Bearer #{token}" }
  end
end
