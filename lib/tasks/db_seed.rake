# encoding: UTF-8
namespace :db do
  namespace :seed do
    desc "Simply test there are no syntx error in this Rake file"
    task :test => :environment do
      puts "It looks all ok, at least syntax ok."
    end
    
    desc "Retrieve DBpedia data for each of all countries, and store data locally"
    task :dbgraph => :environment do      
      Country.all.each do |c|
        if c.dbgraph.blank? && c.code != "ci"
          name = (c.name.include? ",") ? c.full_name : c.name
        
          link = "http://dbpedia.org/page/" + CGI::escape(name.split.join("_"))
          
          # puts "opening #{link}"
          
          graph = RDF::Graph.load(link)
        
          if graph.count > 0
            string = RDF::Writer.for(:json).buffer do |writer|
              graph.each_statement do |s|
                writer << s
              end
            end
          
            c.create_dbgraph(:value => string)
          
            puts "#{graph.count} statements have been retrieved and saved for #{c}"
          else
            puts "no statement got retrieved for #{c}"
          end
        end
      end
    end
  
    desc "Generate the interesting fact list for all countries"
    task :facts => :environment do
      Country.all.each do |c|
        if c.dbgraph.present?
          @link, @largest_city, @capital, @motto, @area_rank, @calling_code, @drives_on, @population_estimate_rank,
          @population_census_rank, @gdp_nominal_rank, @gdp_ppp_per_capita_rank, @demonym = nil
          
          graph = RDF::Reader.for(:json).new(c.dbgraph.value).graph
                
          dbo = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
          dbprop = RDF::Vocabulary.new("http://dbpedia.org/property/")
      
          graph.find_all {|subject, predicate, object|
            (predicate == RDF::FOAF.primaryTopic        and @link = subject)                        or
            (predicate == dbprop.largestCity            and @largest_city = object)                 or
            (predicate == dbo.capital                   and @capital = object)                      or
            (predicate == dbprop.nationalMotto          and @motto = object)                        or
            (predicate == dbprop.areaRank               and @area_rank = object)                    or
            (predicate == dbprop.callingCode            and @calling_code = object)                 or
            (predicate == dbprop.drivesOn               and @drives_on = object)                    or
            (predicate == dbprop.populationEstimateRank and @population_estimate_rank = object)     or
            (predicate == dbprop.populationCensusRank   and @population_census_rank = object)       or
            (predicate == dbprop.gdpNominalRank         and @gdp_nominal_rank = object)             or
            (predicate == dbprop.gdpPppPerCapitaRank    and @gdp_ppp_per_capita_rank = object)      or
            (predicate == dbo.demonym                   and @demonym = object)
          }
        
          c.update_attribute(:link, @link.to_s)
          
          facts = []
          
          facts << {:value => "The largest city of #{c} is #{@largest_city.to_s.split('/').last.split('_').join(' ')}."} if @largest_city.present?
          facts << {:value => "#{c}'s capital city is #{@capital.to_s.split('/').last.split('_').join(' ')}."} if @capital.present?
          facts << {:value => "The national motto of #{c} is: #{@motto.to_s}."} if @motto.present?
          facts << {:value => "The total area of #{c} ranks the #{@area_rank.to_s.to_i.ordinalize} in the world."} if @area_rank.present?
          facts << {:value => "The calling code for #{c} is #{@calling_code.to_s}."} if @calling_code.present?
          facts << {:value => "People in #{c} drive on the #{@drives_on.to_s} side."} if @drives_on.present?
          facts << {:value => "The estimated population of #{c} ranks the #{@population_estimate_rank.to_s.to_i.ordinalize} in the world."} if @population_estimate_rank.present?
          facts << {:value => "The population of #{c} ranks the #{@population_census_rank.to_s.to_i.ordinalize} in the world."} if @population_census_rank.present?
          facts << {:value => "The nominal GDP of #{c} ranks the #{@gdp_nominal_rank.to_s.to_i.ordinalize} in the world."} if @gdp_nominal_rank.present?
          facts << {:value => "The GDP (PPP) per capita of #{c} ranks the #{@gdp_ppp_per_capita_rank.to_s.to_i.ordinalize} in the world."} if @gdp_ppp_per_capita_rank.present?
          facts << {:value => "People from #{c} is referred as #{@demonym.to_s}."} if @demonym.present?
          
          c.facts.create(facts)
          
          puts "#{facts.size} facts are created for #{c}"
        else
          puts "No facts for #{c}"
        end
        
        Country.find_by_code("ug").facts.create(:value => "The capital city of Uganda is Kampala.")
        Country.find_by_code("ci").facts.create(:value => "The capital city of Côte d'Ivoire is Yamoussoukro.")
        Country.find_by_code("ci").update_attribute(:link, "http://en.wikipedia.org/wiki/Côte_d'Ivoire")
      end
    end
    
    # desc "Generate a list of 10 books for all countries"
    # task :books => :environment do
    #   require 'amazon/aws'
    #   require 'amazon/aws/search'
    #   
    #   include Amazon::AWS
    #   include Amazon::AWS::Search      
    # 
    #   req = Request.new('YOURKEYID', 'yourassociateid-20', 'us', false)
    #   req.config['secret_key_id'] = 'YourSecretKeyId'
    #   
    #   
    #   
    #   Country.real.each do |c|
    #       name = (c.name.include? ",") ? c.full_name : c.name
    #       
    #       
    #       
    #   end
    # end
  end
end