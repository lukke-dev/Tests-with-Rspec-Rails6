require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid if the lvl is not between 1 and 99' do
    expect(User.create(nickname: 'chronos', kind: :wizard, level: 100)).to_not be_valid
  end
  it 'return the correct hero title' do
    user = User.create(nickname: 'Asura', kind: :wizard, level: 1)
    expect(user.title).to eq('wizard Asura #1')
  end
end
