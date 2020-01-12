class Post < ApplicationRecord
  mount_uploaders :image, ImageUploader

  validate  :image_size

  private

    # Validates the size of an uploaded image.
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end

end
