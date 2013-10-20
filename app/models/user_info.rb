class UserInfo
  attr_accessor :provider, :uid, :name, :email, :token, :image, :link
  
  def initialize(callback)    
    @provider = callback['provider']
    @uid = callback['uid']
    @token = callback['credentials']['token']
    @image = callback['info']['image']
    
    case @provider 
      when 'facebook'
        @name = [callback['info']['first_name'], callback['info']['last_name']]
        @email = callback['info']['email']
        @link = callback['info']['urls']['Facebook']
      when 'twitter' # Twitter does not give user's email away, so we have to ask for it
        # name = callback['info']['name'].split(' ')
        # last_name = name.pop if name.size > 1
        @name = [callback['info']['nickname'], '']
        @link = callback['info']['urls']['Twitter']
      when 'google'
        @name = [callback['info']['first_name'], callback['info']['last_name']]
        @email = callback['info']['email']
        @link = callback['extra']['raw_info']['link']
    end
  end
end