class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end


  require 'net/http'
  require 'uri'

  def get_public_with_lessons
    url = URI.parse("http://localhost:3001/api-V1/JKD673890RTSDFG45FGHJSUY/get_public_with_lessons.json")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyeggs = JSON.parse(res.body)
    rescue
      studyeggs=[]
    end
    return studyeggs
  end
  
  def get_lesson_questions(lesson_id)
    url = URI.parse("http://localhost:3001/api-V1/JKD673890RTSDFG45FGHJSUY/get_all_lesson_questions/#{lesson_id}.json")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyegg = JSON.parse(res.body)
    rescue
      studyegg = nil
    end
    return studyegg
  end

  def import_from_qb
    public_eggs = get_public_with_lessons
    public_eggs.each do |p|
      p['chapters'].each do |ch|
        @lesson_id = ch['id'].to_i
        puts @lesson_id
        if @lesson_id
          questions = get_lesson_questions(@lesson_id)
          next if questions['questions'].nil?
          questions['questions'].each do |q|
            @q_id = q['id'].to_i
            @question = q['question']
            @answer = ''
            q['answers'].each do |a|
              @answer = a['answer'] if a['correct']
            end
            new_q = Question.find_by_q_id(@q_id)
            unless new_q
              Question.create(:q_id => @q_id, 
                              :lesson_id => @lesson_id, 
                              :question => @question,
                              :answer => @answer)
            end
          end
        end
      end
    end
    render :nothing => true
  end

  def create_tweets
    @questions = Question.all
    @questions.each do |q|
      quest = clean_question(q)
      next if quest.question =~ /Which of the following/ or quest.question =~ /image/ or quest.question =~ /picture/
      if "#{quest.question} ##{quest.q_id}".length + 14 < 141
        puts "Tweet for #{quest.q_id}"
        quest.update_attributes(:tweet => "#{quest.question} ##{quest.q_id}", :url => "http://studyegg.com/review/#{quest.lesson_id}/#{quest.q_id}")
      end
    end
  end

  def clean_question(q)
    a = q.answer
    a.gsub!('<sub>','')
    a.gsub!('</sub>','')
    a.gsub!('<sup>-</sup>','-')
    a.gsub!('<sup>+</sup>','+')
    a.gsub!('<sup>','^')
    a.gsub!('</sup>','')

    quest = q.question

    if quest[0..3].downcase=='true'
      i = quest.downcase.index('false')
      quest = "T\\F: "+ quest[(i+7)..-1]
    end

    quest.gsub!('<sub>','')
    quest.gsub!('</sub>','')
    quest.gsub!('<sup>-</sup>','-')
    quest.gsub!('<sup>+</sup>','+')
    quest.gsub!('<sup>','^')
    quest.gsub!('</sup>','')

    q.update_attributes(:answer => a, :question => quest)
    return q
  end
end
