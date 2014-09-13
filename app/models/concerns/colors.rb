module Colors
  extend ActiveSupport::Concern

  SELECT_COLOR_HASH = {
    black:  :black,
    gray:   :gray,
    red:    :red,
    green:  :green,
    blue:   :blue,
    yellow: :yellow,
    orange: :orange,
    purple: :purple
  }

  COLOR_HEX_HASH = {
    black:  '000000',
    gray:   '808080',
    red:    'ff0000',
    green:  '00ff00',
    blue:   '0000ff',
    yellow: 'ffff00',
    orange: 'ffa500',
    purple: '800080'
  }

  def color_hex
    COLOR_HEX_HASH[color.to_sym]
  end
end
