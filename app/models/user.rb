class User < ActiveRecord::Base
  has_many :medications
  has_secure_password

  def slug
    slug = username.downcase.gsub(" ","-")
    slug = slug.gsub(/[^0-9A-Za-z\-]/, '')
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
