class PatronExportQueue
  @queue = :patron_export

  def self.perform(result_ids, columns, export_file_id)
    Patron.generate_csv(result_ids, columns, ExportFile.find(export_file_id))
  end
end
