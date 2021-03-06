class QuestionsController < ApplicationController
  before_filter :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => :search

  # GET /questions
  # GET /questions.json
  def index
    @theme = Theme.find_by(slug: params[:theme_slug]);
    @questions = Question.where(theme_id: @theme.id)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @articles = @question.articles.sort { |article1, article2| article2.created_at <=> article1.created_at }
    @article = @articles.first
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to action: :show, theme_slug: @question.theme.slug, slug: @question.slug }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to action: :show, theme_slug: @question.theme.slug, slug: @question.slug }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to controller: :pages, action: :home, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    respond_to do |format|
      format.json { render json: Question.search(search_params[:search], params[:theme_slug]) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :theme_id)
    end

    def search_params
      params.require(:question).permit(:search)
    end
end
