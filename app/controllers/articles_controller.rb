class ArticlesController < ApplicationController
  before_filter :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @question = Question.find_by(slug: params[:question_slug])
    @theme = @question.theme
    @articles = Article.where(question_id: @question.id)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @articles = @article.question.articles.sort { |article1, article2| article2.created_at <=> article1.created_at }
    if @articles.first.id == @article.id
      redirect_to controller: :questions, action: :show, theme_slug: @article.theme.slug, slug: @article.question.slug
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @question = @article.question
    @theme = @article.theme
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to action: :show, theme_slug: @article.theme.slug, question_slug: @article.question.slug, id: @article.id }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to action: :show, theme_slug: @article.theme.slug, question_slug: @article.question.slug, id: @article.id }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to controller: :pages, action: :home, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:content, :tags, :question_id)
    end
end
