class Question < ActiveRecord::Base

attr_accessible :content

  belongs_to :evaluation

  has_many :question_results, :dependent => :destroy

  validates :content, :presence => true

  default_scope :order => 'questions.created_at ASC'
end
