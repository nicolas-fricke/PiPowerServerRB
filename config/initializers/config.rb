config_file_path = Rails.root.join('config', 'config.yml')
CONFIG = YAML.load_file(config_file_path)[Rails.env].deep_symbolize_keys
