require 'rails_helper'

# RSpec.describe "users/index", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe "index.html.erb" do
	it "contains 'All Users'" do
		visit(users_path)
		expect(page.has_content?("All Users")).to eq(true)
	end

	context "View User" do
		#create new user
		user = User.new(username: "bob", email: "bob@bob.com", password: "bobspassword", password_confirmation: "bobspassword")
		user.save

		it "contains link to user page" do
			visit(users_path)
			expect(find_link(user.username.capitalize).visible?).to eq(true)
		end

		it "should redirect to user page" do
			visit(users_path)
			click_link(user.username.capitalize)
			expect(page.has_content?("#{user.username}'s profile")).to eq(true)
		end
	end
end