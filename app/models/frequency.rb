class Frequency < ActiveRecord::Base
  SOCKET_CODE_TRANSLATION = { A: 1, B: 2, C: 3, D: 4, E: 5 }
  has_many :power_outlets

  validates :system_code, :socket_code_human, presence: true
  validates :system_code,
            format: { with: /[01]{5}/,
                      message: 'The system_code must be five binary digits' }
  validates :socket_code_human,
            inclusion: { in: SOCKET_CODE_TRANSLATION.keys,
                         message: 'The socket_code be a single character '\
                                  'between A and E' }
  validates :socket_code,
            uniqueness: { scope: :system_code,
            message: 'The combination of socket and system code must be unique' }

  before_update :switch_power_outlet

  def socket_code_human=(value)
    self.socket_code = SOCKET_CODE_TRANSLATION[value.to_s.upcase.to_sym]
  end

  def socket_code_human
    SOCKET_CODE_TRANSLATION.invert[socket_code]
  end

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
