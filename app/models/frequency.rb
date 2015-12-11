class Frequency < ActiveRecord::Base
  has_many :power_outlets

  validates :system_code, :socket_code, presence: true
  validates :system_code,
            format: { with: /[01]{5}/,
                      message: 'The system_code must be five binary digits' }
  validates :socket_code,
            inclusion: { in: 1..4,
                         message: 'The system_code must be five binary digits' }
  validates :socket_code,
            uniqueness: { scope: :system_code,
            message: 'The combination of socket and system code must be unique' }


  before_update :switch_power_outlet

  def switch_power_outlet
    if is_on_changed?
      system(CONFIG[:commands][:switch] % {
        system_code: system_code,
        socket_code: socket_code,
        on_off: is_on ? 1 : 0
      })
    end
  end
end
