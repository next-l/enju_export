class Export
  def self.perform(message)
    sleep 10
    ExportFile.generate_csv(Item.pluck(:id))
  end
end
