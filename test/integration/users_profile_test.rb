require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # include ApplicationHelper
  # ApplicationHelperは「teste_helper」でincludeしている為、ここでは読み込まない

  def setup
    @user = users(:michael)
  end

  test "profile desplay" do

    # ログイン状態でのHomeページの統計情報テスト
    first_user = User.first
    log_in_as(first_user)
    get root_path
    assert_template'static_pages/home'
    assert_select "a[href=?]", following_user_path(first_user)
    assert_select "a[href=?]", followers_user_path(first_user)
    assert_match first_user.following.count.to_s, response.body
    assert_match first_user.followers.count.to_s, response.body

    # Profileページのテスト
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select "a[href=?]", following_user_path(@user)
    assert_select "a[href=?]", followers_user_path(@user)
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
    assert_select 'div.pagination'
    assert_select 'div.pagination', count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

end
