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


      #Here you can only test the rendering of the js.erb, testing the proper js will be part of another tut.
      should "replace the .newComment content" do
          assert_match(%($(".newComment").html),@response.body)
      end

      should "display a form" do
        assert_match(%(<form),@response.body)
      end
    end
  end

  context "handle :create" do
    context "by html" do
        setup do
           post :create, :comment => { :body => "My comment" }
        end
          should_change "Comment.count", :by => 1

          should_redirect_to("the index"){comments_path()}
      end

  end

end

