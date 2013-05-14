class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email,               :null => false
      t.string    :crypted_password
      t.string    :password_salt
      
      t.string    :country_code,        :null => false
      t.string    :avatar
      t.string    :first_name
      t.string    :last_name      
      
      t.boolean   :admin,               :default => false
      
      t.string    :persistence_token
      #t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      #t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      
      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :persistence_token, :unique => true
    add_index :users, :country_code
  end
end
