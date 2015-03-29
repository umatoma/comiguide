# == Schema Information
#
# Table name: clayouts
#
#  id        :integer          not null, primary key
#  cblock_id :integer          not null
#  space_no  :integer          not null
#  layout    :integer          not null
#  pos_x     :integer          not null
#  pos_y     :integer          not null
#

require 'rails_helper'

RSpec.describe Clayout, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
