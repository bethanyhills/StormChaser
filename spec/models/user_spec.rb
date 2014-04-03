require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user)
  end
end
