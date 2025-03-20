# == Schema Information
#
# Table name: jwt_denylist
#
#  id         :integer          not null, primary key
#  jti        :string           not null
#  exp        :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
