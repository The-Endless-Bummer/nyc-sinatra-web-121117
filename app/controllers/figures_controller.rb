class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  # new
  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  # create
  post '/figures' do
    # binding.pry
    @figure = Figure.create(name: params[:figure][:name])
    if !params[:landmark][:name].empty?
      l = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << l
      # binding.pry
    end
    if !params[:title][:name].empty?
       t = Title.create(name: params[:title][:name])
      @figure.titles << t
    end
    params[:figure][:title_ids].each do |title_id_instance|
      @figure.titles << Title.find(title_id_instance)
    end
    params[:figure][:landmark_ids].each do |landmark_id_instance|
      @figure.landmarks << Landmark.find(landmark_id_instance)
      # binding.pry
    end
    redirect :"/figures/#{ @figure.id }"

  end

  # show one
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  # edit
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  #update
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    redirect :"/figures/#{ @figure.id }"
  end

  # destroy
  delete '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect :'/figures'
  end
end
