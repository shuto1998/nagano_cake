class Admin::GenresController < ApplicationController

  #保存機能を作成する
  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to '/admin/genres'
  end

  def index
    @genre = Genre.new
  end

  def edit
  end

  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end
