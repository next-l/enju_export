class ExportFile < ActiveRecord::Base
  attr_accessible :export_content_type, :export_file_name, :export_file_size, :state

  belongs_to :user
  validates_associated :user_id

  if Setting.uploaded_file.storage == :s3
    has_attached_file :export, :storage => :s3, :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
      :s3_permissions => :private
  else
    has_attached_file :export,
      :path => ":rails_root/private/system/:class/:attachment/:id_partition/:style/:filename"
  end
  validates_attachment_content_type :export, :content_type => ['text/csv', 'text/plain', 'text/tab-separated-values', 'application/octet-stream']

  state_machine :initial => :pending do
    event :sm_start do
      transition [:pending, :started] => :started
    end

    event :sm_complete do
      transition :started => :completed
    end

    event :sm_fail do
      transition :started => :failed
    end
  end
end
