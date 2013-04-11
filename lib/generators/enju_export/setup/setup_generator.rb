class EnjuExport::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup
    inject_into_class 'app/models/manifestation.rb', Manifestation,
      "  enju_export\n"
    inject_into_class 'app/models/item.rb', Item,
      "  enju_export\n"
    inject_into_class 'app/models/item.rb', Patron,
      "  enju_export\n"
  end
end
