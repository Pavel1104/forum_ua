
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
I18n::Simple.send(:include, I18n::Pluralization)
I18n.default_locale = :ua
