class FiguresController < ApplicationController

	get '/figures/new' do  
		puts "hello?"
		erb :'figures/new_figure'
	end

	get '/figures' do  
		@figures=Figure.all
		erb :'figures/index'
	end

	get '/figures/:id' do  
		@figure=Figure.find(params[:id])
		erb :'figures/view_figure'
	end

	get '/figures/:id/edit' do  
		@figure=Figure.find(params[:id])
		erb :'figures/edit_figure'
	end

	post '/figures/:id/delete' do  
		Figure.find(params[:id]).delete
		redirect '/figures'
	end

	get '/figures/:id/delete' do  
		Figure.find(params[:id]).delete
		redirect '/figures'
	end

	post '/figures/:id' do  
		puts "--EDITING EXISTING ENTRY--"
		#binding.pry
		puts params
		figure=Figure.find(params[:id])
		#binding.pry
		figure.name=params[:figure][:name]
		figure.save

		figure.titles.clear
		if params[:figure][:title_ids]
			params[:figure][:title_ids].each do |id|
				figure.titles << Title.find(id)
			end
		end

		figure.landmarks.clear
		if params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |id|
				figure.landmarks << Landmark.find(id)
			end
		end

		if params[:landmark][:name]!=""
			landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
			landmark.figure_id=figure.id 
			landmark.save
		end

		if params[:title][:name]!=""
			title = Title.find_or_create_by(name: params[:title][:name])
			title.save
			figure.titles << title
		end
		redirect "/figures/#{figure.id}"
	end

	post '/figures' do  
		#binding.pry
		puts "--MAKING NEW ENTRY--"
		puts params
		new_figure=Figure.new(name: params[:figure][:name])
		new_figure.save
		if params[:figure][:title_ids]
			params[:figure][:title_ids].each do |id|
				new_figure.titles << Title.find(id)
			end
			#binding.pry
		end

		if params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |id|
				new_figure.landmarks << Landmark.find(id)
			end
		end

		if params[:landmark][:name]!=""
			landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
			landmark.figure_id=new_figure.id 
			landmark.save
		end

		if params[:title][:name]!=""
			title = Title.find_or_create_by(name: params[:title][:name])
			title.save
			new_figure.titles << title
		end
		@figures=Figure.all
		erb :'figures/index'
	end

end
