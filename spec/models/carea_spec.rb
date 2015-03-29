# == Schema Information
#
# Table name: careas
#
#  id            :integer          not null, primary key
#  cmap_id       :integer          not null
#  name          :string(255)      not null
#  simple_name   :string(255)      not null
#  all_file_name :string(255)
#  pos_x         :integer          not null
#  pos_y         :integer          not null
#  size_w        :integer          not null
#  size_h        :integer          not null
#  pos_x2        :integer          not null
#  pos_y2        :integer          not null
#  size_w2       :integer          not null
#  size_h2       :integer          not null
#

require 'rails_helper'

RSpec.describe Carea, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
