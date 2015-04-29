class SearchController < ApplicationController
 
require 'algoliasearch'

Algolia.init :application_id => ENV['ALGOLIA_APPLICATION_ID'],
			 :api_key => ENV['ALGOLIA_API_KEY']

	def indexData
	end
  
  def import

  	if params[:upload].blank? || params[:upload][:xml].blank?
    	
    	@empty_files = true	
		@indexingStatus = 'failure'
	
	else
		upload_directory = "public/upload"
    	original_xml = params[:upload][:xml].original_filename
   
		#paths for uploads
    	xml_path = File.join(upload_directory, original_xml)
    	
    	#upload files to server
    	File.open(xml_path, "wb") { |f| f.write( params[:upload][:xml].read ) }

	    #read XML file
		@xml = Nokogiri::XML(File.read(xml_path))

		result = parse_xml(@xml.root)
		
		@records = result[:records]
		@count = result[:count]


  	  	@index = Algolia::Index.new("algolia-play-fix")

		@records.each_slice(10000) do |batch|
		  @index.add_objects(batch)
		end
	
		puts @records.to_s	
		@indexingStatus = 'success'
	end

	render 'indexData'
  end

  def searchData
  end

  private

	def parse_xml(xml, records=[], count=0)
		
		path = xml.path
		attributes = xml.attributes
		#name = el1.node_name

		if not attributes.blank?
			attributes.map do |k,v|
				#increment total parsed elements
				count += 1
	
				records << { :id => count,:attr => k, :val=> v.to_s}
				
				#log to console FYI
				puts "path : //#{path}[@#{k}='#{v.to_s}']"
				puts "objectID: #{count} ** attritube: #{k} ** value : #{v.to_s}\n"
			end		
		end 

		xml.element_children.all? { |x| parse_xml(x, records, count) }
		
		result = {:records => records, :count => count }
	end
	


end
