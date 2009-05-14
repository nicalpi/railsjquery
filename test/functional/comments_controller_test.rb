require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  #Very basics test to show how to test Jquery with Rails and Shoulda

  context "display :index page" do
    setup do
      get :index
    end

    should_respond_with :success

    should "display a factice post" do
      assert_select('div#post',/factice/)
    end

    should "display a link to create a comment" do
      assert_select('a',/new comment/)
    end
  end

  #Testing the comment form rendering
  context "handle :new" do

    context "by html" do
        setup do
          get :new
        end

        should_respond_with :success
        should_assign_to :comments

        should "display a factice post" do
          assert_select('div#post',/factice/)
        end
      #In both case
        should "display a form" do
          assert_select("div.newComment form")
      end

    end

    context "by ajax" do
      setup do
        xhr :get, :new
      end

      should_respond_with :success
      should_not_assign_to :comments #we don't need another DB call, we are in xhr

      should "replace the .newComment content" do
          assert_match(%($(".newComment").html),@response.body)
      end

      should "display a form" do
        assert_match(%(form),@response.body)
      end

    end

  end

end

