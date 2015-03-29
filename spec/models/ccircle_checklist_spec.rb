# == Schema Information
#
# Table name: ccircle_checklists
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  comiket_id   :integer          not null
#  clayout_id   :integer          not null
#  space_no_sub :integer          default(0), not null
#  day          :integer          not null
#  circle_name  :string(255)      not null
#  circle_url   :string(255)
#  comment      :string(255)
#  cost         :string(255)
#  color        :string(255)      default("black"), not null
#  rank         :integer          default(1), not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe CcircleChecklist, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
