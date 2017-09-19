module ApplicationHelper
	def full_title(page_title)
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end		
	def meta_desc(page_title)
		base_desc = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_desc
		else
			"#{base_desc} #{page_title}"
		end		
			
	end	
end
