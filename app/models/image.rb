class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validate :file_format

  private

  def file_format
    return unless file.attached?

    if !file.content_type.in?(%w(image/jpeg image/png))
      errors.add(:file, "doit être au format JPG ou PNG")
    end
  end
end
