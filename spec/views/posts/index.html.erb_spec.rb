require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  current_user = User.first_or_create!(email: 'travis@example.com', password: 'password', password_confirmation: 'password')

  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyNewText",
        user: current_user,
        views: 14
      ),
      Post.create!(
        title: "Title",
        body: "MyNewText",
        user: current_user,
        views: 12
      )
    ])
  end

  it "renders a list of posts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyNewText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(current_user.id.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(14.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(12.to_s), count: 1
  end
end
