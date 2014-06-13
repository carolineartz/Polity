require 'spec_helper'

describe "community_member_vote_positions/edit" do
  before(:each) do
    @community_member_vote_position = assign(:community_member_vote_position, stub_model(CommunityMemberVotePosition,
      :agree => false,
      :feedback => "MyText"
    ))
  end

  it "renders the edit community_member_vote_position form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", community_member_vote_position_path(@community_member_vote_position), "post" do
      assert_select "input#community_member_vote_position_agree[name=?]", "community_member_vote_position[agree]"
      assert_select "textarea#community_member_vote_position_feedback[name=?]", "community_member_vote_position[feedback]"
    end
  end
end
