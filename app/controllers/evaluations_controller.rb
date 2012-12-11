class EvaluationsController < ApplicationController
  def saveresults
    @evaluation = Evaluation.find(params[:id])
    @answersString = params[:answers].to_s
    @answers = params[:answers].to_s.split('x')
    @questions = @evaluation.questions
    @questions.each do |question|
      currentAnswer = @answers.shift
      currentAnswer = currentAnswer.to_i
      question.question_results.new(:Answer => currentAnswer).save
    end
    redirect_to evaluationresults_path(:id => params[:id])
  end

  def show
    @title = "Evaluations"
    @evaluation = Evaluation.find(0)
    @questions = @evaluation.questions
  end

  def questions
    @evaluation = Evaluation.find(params[:question][:evaluationid])
    @question = @evaluation.questions.new(params[:question]).save
    redirect_to  evaluationedit_path(:id => params[:question][:evaluationid])
  end

  def updatequestion
    Question.find(params[:questionid]).update_attributes(:content => params[:content])
    redirect_to  evaluationedit_path(:id => params[:id])
  end

  def deletequestion
    Question.delete(params[:questionid])
    redirect_to  evaluationedit_path(:id => params[:id])
  end

  def new
    @title = "Evaluations"
    @evaluation = Evaluation.new
    @evaluations = Evaluation.all
  end

  def create
    @title = "Evaluations"
    @evaluations = Evaluation.all
    @evaluation = Evaluation.new(params[:evaluation])
    @error = false
    if @evaluation.save
      redirect_to '/'
    else
      @error = true
      render 'new'
    end
  end

  def delete
    Evaluation.delete(params[:id])
    redirect_to '/'
  end

  def evaluationadmin
    @title = "Administration Page"
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluationinfo
    @title = "Evaluation Information"
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluationedit
    @title = "Edit Evaluation Questions"
    @evaluation = Evaluation.find(params[:id])
    @questions = @evaluation.questions
    @question = Question.new(params[:question])
  end

  def evaluationresults
    @title = "Evaluation Results"
    @evaluation = Evaluation.find(params[:id])
    @questions = @evaluation.questions
    @numQuestions = @questions.length
    @hasQuestions = false
    if(@numQuestions != 0)
      @hasQuestions = true
      @averageAnswers = Array.new(@numQuestions)
      @numberOfTimesAnswered = Array.new(@numQuestions)
      @total = 0
      @count = 0
      @hasResults = false
      if(@questions[0].question_results.length != 0)
        @hasResults = true
        @totalSubmissions = @questions[0].question_results.length
        @questions.each do |q|
          @total = 0
          q.question_results.each do |r|
            @total = @total + r.Answer.to_i
          end
          @averageAnswers[@count] = (@total.to_f/q.question_results.length.to_f).round * 135
          @numberOfTimesAnswered[@count] = q.question_results.length
          @count = @count + 1
        end
      end
    end
  end

  def takeevaluation
    @title = "Taking A Evaluation"
    @evaluation = Evaluation.find(params[:id])
    @questions = @evaluation.questions
    @question_result = "" 
  end

end
