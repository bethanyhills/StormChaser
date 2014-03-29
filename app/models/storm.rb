class Storm < ActiveRecord::Base
  belongs_to :tornado_date
  belongs_to :path
end
