# encoding: UTF-8

namespace :run do
  desc "Run custom things"
  task :custom => :environment do
    Poll.first.save_translation(['美国是对世界和平有正面作用的国家吗？', '', '', ''], 'zh')
    
    I18n.with_locale(:zh) do
      Poll.create(:user_id => 1, :country_code => 'us', :body => '美国人民反对棱镜计划吗？', :yes => '是', :no => '否')
    end
    
    Poll.last.save_translation(['Do people of the United Stated oppose the PRISM project?', '', '', ''], 'en')
  end
end