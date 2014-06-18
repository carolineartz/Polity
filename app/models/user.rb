class User < ActiveRecord::Base

  # include Paperclip::Glue


  belongs_to :user_address
  has_many :legislation_voices
  has_many :legislators

  has_many :created_meetings, class_name: "CommunityMeeting", foreign_key: :creator_id
  has_many :meeting_attendances
  has_many :meetings, through: :meeting_attendances, source: :community_meetings

  validates :email, presence: true, uniqueness: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{self.first_name.downcase.capitalize} #{self.last_name.downcase.capitalize}"
  end

  def ward
    self.user_address.ward
  end

  def ward_number
    address = UserAddress.find(self.user_address_id)
    Ward.find_by_id(address.ward_id).ward_number
  end

  def alderman
    address = UserAddress.find(self.user_address_id)
    current_legislator = Legislator.where(:represented_ward_id => address.ward_id).first
    User.find(current_legislator.alderman_id)
  end


  def street_address1
    address = UserAddress.find(self.user_address_id)
    address.address1
  end

  def street_address2
    address = UserAddress.find(self.user_address_id)
    address.address2
  end

  def zip
    address = UserAddress.find(self.user_address_id)
    address.zip
  end
end
