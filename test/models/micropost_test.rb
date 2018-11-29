require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  # 作成したマイクロポストが有効化か
  test "should be valid" do
    assert @micropost.valid?
  end

  # マイクロポストのuser_idの存在性確認
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  # マイクロポストのcontentの存在性確認
  test "content should be present" do
    @micropost.content = "  "
    assert_not @micropost.valid?
  end

  # マイクロポストのcontentのmaxlengthが140を超える場合
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
