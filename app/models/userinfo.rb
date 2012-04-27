class UserInfo
  attr_accessor :provider, :uid, :name, :email
  
  def initialize(callback)
    @provider = callback['provider'].capitalize
    @uid = callback['uid']
    
    if @provider == 'Facebook'
      @name = callback['info']['name']
      @email = callback['info']['email']
    end
  end
  
end