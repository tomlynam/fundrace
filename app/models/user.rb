class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_attached_file :avatar, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg", 
                    :storage => :dropbox,
				            :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true

  ##validates :avatar, presence: true 

  has_many :listings, dependent: :destroy

end
