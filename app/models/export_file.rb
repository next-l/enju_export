class ExportFile < ActiveRecord::Base
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

  def self.generate_csv(ids, attrs = [], role = nil)
    file = Tempfile.new(["#{self.name.downcase}_", '.tsv'])
    file.write([
                 'item_identifier',
                 'library',
                 'acquired_at',
                 'original_title',
                 'creator',
                 'pub_date',
                 'publisher',
                 'budget_type',
                 'bookstore',
                 'price',
                 'note'
               ].join("\t") + "\n")

    Item.where(:id => ids).where('required_role_id >= ?', role.try(:id).to_i).find_each do |item|
      if item.manifestation
        file.write(
          [
            item.item_identifier,
            item.shelf.library.display_name.localize,
            item.acquired_at.try(:strftime, '%Y%m%d'),
            item.manifestation.original_title,
            item.manifestation.creators.select(:full_name).collect(&:full_name).join("; "),
            item.manifestation.pub_date,
            item.manifestation.publishers.select(:full_name).collect(&:full_name).join("; "),
            item.budget_type.try(:name),
            item.bookstore.try(:name),
            item.price,
            item.note
          ].join("\t") + "\n"
        )
      else
        file.write(
          [
            item.item_identifier,
            item.shelf.library.display_name.localize,
            item.acquired_at.try(:strftime, '%Y%m%d'),
            "",
            "",
            "",
            "",
            item.budget_type.try(:name),
            item.bookstore.try(:name),
            item.price,
            item.donation,
            item.note
          ].join("\t") + "\n"
        )
      end
    end
    file.close
    file
    #self.export = File.new(file.path)
    #sm_complete!
  end
end

# == Schema Information
#
# Table name: export_files
#
#  id                  :integer          not null, primary key
#  export_file_name    :string(255)
#  export_content_type :string(255)
#  export_file_size    :string(255)
#  state               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#

