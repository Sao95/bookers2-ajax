class SearchesController < ApplicationController
  
  def search
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # @model, @content, @methodを代入した、search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'user'
      if method == 'perfect_match'
        User.where(name: content)
      elsif method == "forward_match"
        @users = User.where("name LIKE?","%#{content}")
      elsif method == "backward_match"
        @users = User.where("#{content}")
      elsif method == "partial_match"
        @users = User.where("name LIKE?","%#{content}%")
      # else
      #   @users = User.all
      end
    # 選択したモデルがbookだったら
    elsif model == 'book'
      if method == 'perfect_match'
        Book.where(title: content)
      elsif method == "forward_match"
        @books = Book.where("title LIKE?","%#{content}")
      elsif method == "backward_match"
        @books = Book.where("#{content}")
      elsif method == "partial_match"
        @books = Book.where("title LIKE?","%#{content}%")
      # else
      #   @books = Book.all
      end
    end
  end
end
