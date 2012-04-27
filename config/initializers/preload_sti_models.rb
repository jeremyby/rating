if Rails.env.development?
  require_dependency File.join("app","models","ratable.rb")
end

%w[company country organization].each do |c|
  require_dependency File.join("app","models","ratables","#{c}.rb")
end