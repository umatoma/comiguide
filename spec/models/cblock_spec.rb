# == Schema Information
#
# Table name: cblocks
#
#  id       :integer          not null, primary key
#  carea_id :integer          not null
#  name     :string(255)      not null
#  pos_x    :integer          not null
#  pos_y    :integer          not null
#

require 'rails_helper'

RSpec.describe Cblock, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
