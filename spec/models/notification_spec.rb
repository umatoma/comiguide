# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  content      :text             not null
#  status       :integer          default(1), not null
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Notification, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
