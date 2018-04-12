class Link < ApplicationRecord
  belongs_to :user

  validates :user, :source_link, presence: true
  validates_uniqueness_of :source_link, :shortcode
  validate :check_if_source_link_is_valid_url
  validate :generate_short_code, on: :create
  before_create :generate_short_code


  
  def check_if_source_link_is_valid_url
    invalid_url = true
    begin
      uri = URI.parse(self.source_link)
      invalid_url = false
    rescue URI::InvalidURIError
      invalid_url = true
    end
    
    if invalid_url
      errors.add(:source_link, "is not a valid URL")
    end
  end

  def generate_short_code
    failed_to_create_short_code = false
    begin
      retries ||= 0
      chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
      self.shortcode = 6.times.map { chars.sample }.join
      if List.exists?(shortcode: self.shortcode)
        failed_to_create_short_code = true
        raise
      else
        failed_to_create_short_code = false
      end
    rescue
      retry if (retries += 1) < 100
    end
    if failed_to_create_short_code
      errors.add(:source_link, "Unable to generate short code, please try again later")
    end
  end
end
