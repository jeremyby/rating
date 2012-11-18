class UserInfo
  attr_accessor :provider, :uid, :name, :email, :token
  
  def initialize(callback)
    @provider = callback['provider']
    @uid = callback['uid']
    
    case @provider 
      when 'facebook'
        @name = [callback['info']['first_name'], callback['info']['last_name']]
        @email = callback['info']['email']
        @token = callback['credentials']['token']
      when 'twitter' # Twitter does not give user's email away, so it can only used to connect, not signup
        @token = callback['credentials']['token']
      when 'google'
        @name = [callback['info']['first_name'], callback['info']['last_name']]
        @email = callback['info']['email']
        @token = callback['credentials']['token']
    end
  end
end