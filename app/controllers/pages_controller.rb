class PagesController < ApplicationController
	before_action :logged_in, only: [:main]

	def main

	end

	def about
	end

	def vard
	end

	private

	def logged_in
		if user_signed_in?
			redirect_to vard_path
		end

	end

end
