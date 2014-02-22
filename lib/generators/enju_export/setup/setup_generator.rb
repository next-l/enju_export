class EnjuExport::SetupGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_setup_files
    rake("enju_export_engine:install:migrations")
  end
end
