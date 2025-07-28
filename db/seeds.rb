# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create a global Super Admin Account
superadmin_account = Account.find_or_create_by!(
  name: "Global Admin",
  slug: "global-admin",
  subdomain: "admin",
  active: true
)

# Create Super Admin User (Muzammil)
superadmin = User.find_or_create_by!(
  email: "muzammil@example.com"
) do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.first_name = "Muzammil"
  user.last_name = "Ashraf"
  user.role = :super_admin   # use symbol instead of string
  user.account = superadmin_account
end

puts "Super Admin created: #{superadmin.email}"

# Shared company account
company_account = Account.find_or_create_by!(
  name: "Main Company Account", slug: "main-company", subdomain: "company", active: true
)

# Define companies and admins
companies_data = [
  { name: "PakWheels", location: "Lahore", website: "https://pakwheels.com", description: "Automobile Marketplace", admin: { first_name: "Ashraf", last_name: "Ahmed", email: "ashraf@pakwheels.com" } },
  { name: "Tkxel", location: "Lahore", website: "https://tkxel.com", description: "Software House", admin: { first_name: "Talha", last_name: "Iqbal", email: "talha@tkxel.com" } },
  { name: "Systems Ltd", location: "Karachi", website: "https://systemsltd.com", description: "Enterprise Solutions", admin: { first_name: "Saleh", last_name: "Khan", email: "saleh@systems.com" } }
]

job_titles = [ "Associate Software Engineer", "Software Engineer", "Data Analyst" ]

# Create companies and their admin use
companies_data.each do |company_attrs|
  admin_info = company_attrs.delete(:admin)

  admin_user = User.find_or_create_by!(email: admin_info[:email]) do |user|
    user.password = "password123"
    user.password_confirmation = "password123"
    user.first_name = admin_info[:first_name]
    user.last_name = admin_info[:last_name]
    user.role = :company_admin
    user.account = company_account
  end

  company = Company.find_or_create_by!(name: company_attrs[:name], user: admin_user, account: company_account) do |c|
    c.assign_attributes(company_attrs)
  end

  puts "Company created: #{company.name} with admin #{admin_user.email}"

  job_titles.each do |title|
    Job.find_or_create_by!(
      title: title,
      company: company,
      user: admin_user,
      account: company_account,
      location: company.location,
      job_type: ["Full-Time", "Remote", "Part-Time"].sample,
      status: "open",
      salary_range: "$70,000 - $110,000",
      description: "Exciting role at #{company.name} for #{title}.",
      requirements: "Relevant experience and tech skills required."
    )
  end
end

# Create an applicant user
applicant = User.find_or_create_by!(email: "abdul@applicant.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.first_name = "Abdul"
  user.last_name = "Rehman"
  user.role = :applicant
  user.account = company_account
end

puts "Applicant created: #{applicant.email}"
puts "Seeding complete!"
