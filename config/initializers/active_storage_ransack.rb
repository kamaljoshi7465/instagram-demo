Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[blob_id created_at id name record_id record_type updated_at]
    end
  end

  ActiveStorage::Blob.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[filename content_type created_at id byte_size checksum metadata]
    end
  end
end
