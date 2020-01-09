require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test "tip must have title" do
    tip = Tip.new body: 'The Tip',
                  user: users(:one)
    refute tip.valid?
  end

  test "tip must have body" do
    tip = Tip.new title: 'Tip Title',
                  user: users(:one)
    refute tip.valid?
  end

  test "tip must have user" do
    tip = Tip.new title: 'Tip Title',
                  body: 'The Tip'
    refute tip.valid?
  end

  test "tip's title can not be more than 100 characters" do
    tip = Tip.new title: 'This is a Tip Title that is way more than 100 characters to test the Tip model validation for the title length.',
                  body: 'The Tip',
                  user: users(:one)
    refute tip.valid?
  end

  test "tip can be updated" do
    tip = Tip.create! title: "Tip Title",
                        body: "The Tip",
                        user: users(:one)
    assert tip.update(title: 'New Title', body: 'New Body', user: users(:two))
  end

  test "most_recently_updated returns the last 4 tips updated" do
    6.times do |i|
      tip = Tip.create! title: "Tip #{i+1}",
                        body: "The Tip #{i+1}",
                        user: users(:one)
    end
    [1, 3, 2, 6].each do |i|
      Tip.find_by(title: "Tip #{i}").update!(body: "New body #{i}")
    end
    tips = Tip.most_recently_updated
    assert_equal tips.length, 4
    assert_equal tips[0].title, 'Tip 6'
    assert_equal tips[1].title, 'Tip 2'
    assert_equal tips[2].title, 'Tip 3'
    assert_equal tips[3].title, 'Tip 1'
  end

  test "title_contains scope search tips by title" do
    tip_1 = Tip.create! title: "My best tip",
                        body: "Always have a cup of coffee next to you!",
                        user: users(:one)
    tip_2 = Tip.create! title: "Patience is a virtue",
                        body: "Someone recently gave this tip: 'You have to be patient'.",
                        user: users(:one)
    assert_equal Tip.title_contains('tip').length, 1
  end

  test "body_contains scope search tips by body" do
    tip_1 = Tip.create! title: "My best tip",
                        body: "Always have a cup of coffee next to you!",
                        user: users(:one)
    tip_2 = Tip.create! title: "Patience is a virtue",
                        body: "Someone recently gave this tip: 'You have to be patient'.",
                        user: users(:one)
    assert_equal Tip.body_contains('someone').length, 1
  end

  test "search scope search tips by title and body" do
    tip_1 = Tip.create! title: "My best tip",
                        body: "Always have a cup of coffee next to you and have some patience!",
                        user: users(:one)
    tip_2 = Tip.create! title: "Patience is a virtue",
                        body: "Someone recently gave this tip: 'You have to be patient'.",
                        user: users(:one)
    assert_equal Tip.search('patience').length, 2
  end
end
