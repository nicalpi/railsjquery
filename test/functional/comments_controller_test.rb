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

    context "without message" do
       should "should display a message No comments ..." do
          assert_select("h3",/No comments/)
        end
    end

    context "with some comment" do
      setup do
        @comment = Factory(:comment,:body => "My created comment")
        get :index
      end
      should "display comment" do
        assert_select("#comment#{@comment.id}",/My created comment/)
      end
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

#Testing the comment creation
  context "handle :create" do
    context "by html" do
        setup do
           post :create, :comment => { :body => "My comment" }
        end
          should_change "Comment.count", :by => 1
          should_redirect_to("the index"){comments_path()}
      end
      context "by xhr" do
        setup do
           xhr :post, :create, :comment => { :body => "My xhr comment" }
        end
          should_change "Comment.count", :by => 1

          should "hide the message No comments ..." do
            assert_match(%($(".comments h3").hide()),@response.body)
          end

          should "hide the form comment" do
            assert_match(%($(".newComment form").hide()),@response.body)
          end

          should "display the created new created message" do
            assert_match(%(My xhr comment),@response.body)
          end

      end
  end

#Testing the comment update
  context "handle :update" do

    context "by html" do
      setup do
        @comment = Factory(:comment,:body => "my comment",:score => 0)
        put :update,:id => @comment.id, :comment => @comment
      end
      should_respond_with :redirect
      should_redirect_to("comments index") {comments_path}
      should_assign_to :comment
      should "update the score by 1" do
        assert_equal(1, assigns(:comment).score)
      end
    end

    context "by xhr" do
      setup do
        @comment = Factory(:comment,:body => "my comment",:score => 0)
        xhr :put,:update,:id => @comment.id, :comment => @comment
      end
      should_respond_with :success
      should_assign_to :comment
      should "update the score by 1" do
        assert_equal(1, assigns(:comment).score)
      end
      should "update the right comment" do
        assert_match(%($('#comment#{@comment.id} span.score').html("#{assigns(:comment).score}")),@response.body)
      end
    end
  end

  context "handle :delete" do
    setup { @comment = Factory(:comment) }
    context "by html" do
      setup do
        delete :destroy,:id => @comment
      end
      should_change "Comment.count", :by => -1
      should_respond_with :redirect
      should_redirect_to("comments index") {comments_path}
    end
    context "by xhr" do
      setup do
        xhr :delete,:destroy,:id => @comment
      end
      should_change "Comment.count", :by => -1
      should_respond_with :success
    end
  end



end

