class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items
  validates_uniqueness_of :name, scope: :user_id # Prevents user from creating a list with the same name more than once

  def parse_date # Function to format the date field
    months = { 1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun", 7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec" }
    month_number = Date._parse(self.deadline_date.to_s)[:mon]
    day = Date._parse(self.deadline_date.to_s)[:mday].to_s
    year = Date._parse(self.deadline_date.to_s)[:year].to_s
    month = months[month_number]
    month + " " + day + ", " + year
  end
end
