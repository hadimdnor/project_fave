require 'sinatra'
require 'json'
require 'sinatra/json'
require_relative 'tax_calculation.rb'
require 'httparty'
require 'pry'


# post '/taxapi' do
#     employee_name = params["employee_name"]
#     employee_annual_salary = params["annual_salary"].to_i
#     hash = { 'monthly_payslip' => generate_monthly_payslip(employee_name, employee_annual_salary) }
#     json = hash.to_json
#     # JSON.parse(hash)
#     binding.pry
#     redirect '/tax'
# end

post '/api' do
    name = params['name']
    salary= params['salary'].to_i
    hash = { 'monthly_payslip' => generate_monthly_payslip(name, salary ) }
    return json(hash)
    # binding.pry
    # # JSON.parse(hash)
    
end


get '/api' do
    hash = { 'monthly_payslip' => generate_monthly_payslip("Ren", 60000) }
    return json(hash)
    # binding.pry
    # # JSON.parse(hash)
    
end



# post '/somewhere/' do
#     request.body.rewind
#     request_payload = JSON.parse request.body.read
   
#     p request_payload
   
#     "win"
# end


# get '/' do
#     erb :index 
# end

get '/' do

    tax_output = HTTParty.post('http://localhost:4567/api') 
    # {"monthly_payslip"=>{"employee_name"=>"Ren", "gross_monthly_income"=>5000, "monthly_income_tax"=>500.0, "net_monthly_income"=>4500.0}}

    employee_name = tax_output.values[0]["employee_name"]
    gross_monthly_income = tax_output.values[0]["gross_monthly_income"]
    monthly_income_tax = tax_output.values[0]["monthly_income_tax"]
    net_monthly_income = tax_output.values[0]["net_monthly_income"]
    # binding.pry

    erb :index, locals: {
        employee_name: employee_name,
        gross_monthly_income: gross_monthly_income,
        monthly_income_tax: monthly_income_tax,
        net_monthly_income: net_monthly_income,
    }
end