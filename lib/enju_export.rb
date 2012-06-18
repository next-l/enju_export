require "enju_export/engine"

module EnjuExport
  module ActsAsMethods
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_export
        include ExportCSV
      end
    end

    module ExportCSV
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def generate_csv(ids, attrs, export_file, role = nil)
          export_file.sm_start!
          file = Tempfile.new("#{self.name.downcase}_")
          self.where('required_role_id >= ?', role.try(:id).to_i).find_each(:conditions => {:id => ids}) do |record|
            file.write(attrs.map{|attr| record.send(attr)}.join(',') + "\n")
          end
          file.close
          export_file.export = File.new(file.path)
          export_file.sm_complete!
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, EnjuExport::ActsAsMethods
