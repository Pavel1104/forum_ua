
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
I18n.default_locale = :ua
