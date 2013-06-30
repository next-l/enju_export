class AgentExportQueue
  @queue = :agent_export

  def self.perform(result_ids, columns, export_file_id)
    Agent.generate_csv(result_ids, columns, ExportFile.find(export_file_id))
  end
end
