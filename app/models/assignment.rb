class Assignment < ActiveRecord::Base
	
	def status_name
	case self.status
	when 0
		"undefined"
	when 1
		"open"
	when 2
		"message"
	when 3
		"denied"
	when 4
		"assigned"
	end
	
	def status_name=(name)
		case name
		when "open"
		  self.status = 1	
		when "message"
			self.status = 2 
		when "denied"
			self.status = 3
		when "assigned"
			self.status = 4
		else
			self.status = 0
		end
	end
end
