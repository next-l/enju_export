class ExportFile < ActiveRecord::Base
  attr_accessible :export_content_type, :export_file_name, :export_file_size, :state

  belongs_to :user
  validates_associated :user_id

  has_attached_file :export

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
