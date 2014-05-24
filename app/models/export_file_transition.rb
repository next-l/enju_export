class ExportFileTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :export_file, inverse_of: :export_file_transitions
end
