# encoding: UTF-8
namespace :db do
  desc "Drop, create and migrate"
  task :rebuild => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
  
  
  namespace :seed do
    desc "Retrieve DBpedia data for each of all countries, and store data locally"
    task :dbgraph => :environment do
      countries = ENV['country'].blank? ? Country.all : [ Country.find_by_code!(ENV['country']) ]

      countries.each do |c|
        if c.dbgraph.blank? #&& !%w(ci so so1).include?(c.code)
          link = "http://dbpedia.org/page/" + CGI::escape(c.to_s.split.join("_"))

          puts "Loading '#{link}'..."

          graph = RDF::Graph.load(link)

          if graph.count > 0
            string = RDF::Writer.for(:json).buffer do |writer|
              graph.each_statement do |s|
                writer << s
              end
            end
            
            c.create_dbgraph(:value => string)
            
            # c.create_dbgraph(:value => string.encode(Encoding.find('ASCII'), {
            #   :invalid           => :replace,  # Replace invalid byte sequences
            #   :undef             => :replace,  # Replace anything not defined in ASCII
            #   :replace           => ''        # Use a blank for those replacements
            #   })
            # )

            puts "=> #{graph.count} statements have been retrieved and saved for #{c}."
          else
            puts "=> No statement got retrieved for #{c}."
          end
        else
          puts "Dbgraph is already generated."
        end
      end
    end

    desc "Generate the interesting fact list for all countries"
    task :facts => :environment do
      countries = ENV['country'].blank? ? Country.all : [ Country.find_by_code!(ENV['country']) ]

      countries.each do |c|
        if c.dbgraph.present?
          @link, @abstract, @largest_city, @capital, @motto, @area_rank, @calling_code, @drives_on, @population_estimate_rank,
            @population_census_rank, @gdp_nominal_rank, @gdp_ppp_per_capita_rank, @demonym = nil

          graph = RDF::Reader.for(:json).new(c.dbgraph.value).graph

          dbo = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
          dbprop = RDF::Vocabulary.new("http://dbpedia.org/property/")

          graph.find_all {|subject, predicate, object|
            # (predicate == dbo.abstract                  and object.language == I18n.locale          and @abstract = object)         or
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
          
          # c.create_abstract(:value => @abstract.to_s)

          facts = []
          facts << {:value => "The largest city of #{c} is <em>#{@largest_city.to_s.split('/').last.split('_').join(' ')}</em>."} if @largest_city.present?
          facts << {:value => "#{c}'s capital city is <em>#{@capital.to_s.split('/').last.split('_').join(' ')}</em>."} if @capital.present?
          facts << {:value => "The national motto of #{c} is: <em>#{@motto.to_s}</em>."} if @motto.present?
          facts << {:value => "The total area of #{c} ranks the <em>#{@area_rank.to_s.to_i.ordinalize}</em> in the world."} if @area_rank.present?
          facts << {:value => "The calling code for #{c} is <em>#{@calling_code.to_s}</em>."} if @calling_code.present?
          facts << {:value => "People in #{c} drive on the <em>#{@drives_on.to_s}</em> side."} if @drives_on.present?
          facts << {:value => "The estimated population of #{c} ranks the <em>#{@population_estimate_rank.to_s.to_i.ordinalize}</em> in the world."} if @population_estimate_rank.present?
          facts << {:value => "The population of #{c} ranks the <em>#{@population_census_rank.to_s.to_i.ordinalize}</em> in the world."} if @population_census_rank.present?
          facts << {:value => "The nominal GDP of #{c} ranks the <em>#{@gdp_nominal_rank.to_s.to_i.ordinalize}</em> in the world."} if @gdp_nominal_rank.present?
          facts << {:value => "The GDP (PPP) per capita of #{c} ranks the <em>#{@gdp_ppp_per_capita_rank.to_s.to_i.ordinalize}</em> in the world."} if @gdp_ppp_per_capita_rank.present?
          facts << {:value => "People from #{c} is referred as <em>#{@demonym.to_s}</em>."} if @demonym.present?

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
  end
end
