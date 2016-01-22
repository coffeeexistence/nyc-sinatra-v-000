class LandmarksController < ApplicationController

	get '/landmarks/new' do  
		erb :'landmarks/new_landmark'
	end

	get '/landmarks' do  
		@landmarks=Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/:id' do  
		@landmarks=[Landmark.find(params[:id])]
		erb :'landmarks/index'
	end

	get '/landmarks/:id/edit' do  
		@landmark=Landmark.find(params[:id])
		erb :'landmarks/edit_landmark'
	end

	post '/figures/:id/delete' do  
		Landmark.find(params[:id]).delete
		redirect '/landmarks'
	end

	get '/landmarks/:id/delete' do  
		Landmark.find(params[:id]).delete
		redirect '/landmarks'
	end

	post '/landmarks/:id' do  
		puts "--EDITING EXISTING ENTRY--"
		landmark=Landmark.find(params[:id])
		landmark.name=params[:landmark][:name]
		landmark.year_completed=params[:landmark][:year_completed]
		landmark.save
		redirect "/landmarks/#{landmark.id}"
	end

	post '/landmarks' do  
		#binding.pry
		puts "--MAKING NEW ENTRY--"
		puts params
		new_landmark=Landmark.new(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
		new_landmark.save
		#binding.pry
		@landmarks=Landmark.all
		erb :'landmarks/index'
	end
end
