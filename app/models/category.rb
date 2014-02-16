class Category < ActiveRecord::Base;
  has_and_belongs_to_many :posts

  validates :name, presence: true

  after_validation :generate_slug!

  def generate_slug!
    the_slug = to_slug(self.name)
    cat = Category.find_by slug: the_slug
    count = 2
    while cat && cat != self
      the_slug = the_slug + '-' + count.to_s
      cat = Category.find_by slug: the_slug
      count += 1
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
  end

  def to_param
    self.slug
  end
end