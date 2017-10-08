class User < ActiveRecord::Base
  has_many :medications
  has_secure_password

  def slug
    slug = username.downcase.gsub(" ","-")
    slug = slug.gsub(/[^0-9A-Za-z\-]/, '')
  end

  def all_meds #return all medications as an array
    med_array = []
    self.medications.all.each do |med|
      med_array << med
    end
    return med_array
  end

  def med_names
    med_name_array = []
    self.medications.all.each do |med|
      med_name_array << med.name
    end
    return med_name_array
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
