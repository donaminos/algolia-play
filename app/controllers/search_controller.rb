class SearchController < ApplicationController
 
require 'algoliasearch'

Algolia.init :application_id => ENV['ALGOLIA_APPLICATION_ID'],
			 :api_key => ENV['ALGOLIA_API_KEY']

	def indexData
	end
  
  def import
  		data = [{
  "objectID" => 44,
  "title" => "Breaking Well",     
  "episodes"=> [              
    "Crazy Handful of Nothin'",
    "Gray Matter"
    ],
  "like_count"=> 978,          
  "avg_stuff"=> 1.23456,
  "actors"=> [                 
    {
      "name"=> "Walter White",
      "portrayed_by"=> "Bryan Cranston"
    },
    {
      "name"=> "Skyler White",
      "portrayed_by"=> "Anna Gunn"
    }
  ]
},{
  "objectID" => 43,
  "title" => "Breaking Well",     
  "episodes"=> [              
    "Crazy Handful of Nothin'",
    "Gray Matter"
    ],
  "like_count"=> 978,          
  "avg_stuff"=> 1.23456,
  "actors"=> [                 
    {
      "name"=> "Walter White",
      "portrayed_by"=> "Bryan Cranston"
    },
    {
      "name"=> "Skyler White",
      "portrayed_by"=> "Anna Gunn"
    }
  ]
}
]
  	  
  	  	@index = Algolia::Index.new("algolia-play-test")
			# `load_data_from_database` must return an array of Hash representing your objects
		data.each_slice(1000) do |batch|
		  @index.add_objects(batch)
		end
		
		@indexingStatus = 'success'
		
		render 'indexData'
  end

  def searchData
  end

	


end
