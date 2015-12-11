class PowerOutlet < ActiveRecord::Base
  validates :name, :system_code, :socket_code, presence: true
  validates :system_code,
            format: { with: /[01]{5}/,
                      message: 'The system_code must be five binary digits' }
  validates :socket_code,
            inclusion: { in: 1..4,
                         message: 'The system_code must be five binary digits' }
end
