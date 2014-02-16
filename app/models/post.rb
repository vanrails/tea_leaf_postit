class Post < ActiveRecord::Base;
  belongs_to :user
  belongs_to :creator, :foreign_key => 'user_id', :class_name => 'User'
  has_many :comments
  has_and_belongs_to_many :categories
  has_many :votes, as: :votable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  after_validation :generate_slug!

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    count = 2
    while post && post != self
      the_slug = the_slug + '-' + count.to_s
      post = Post.find_by slug: the_slug
      count += 1
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
    str.downcase
  end

  def to_param
    self.slug
  end
end