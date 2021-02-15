require 'sinatra'
require 'json'
require 'sinatra/json'
require_relative 'tax_calculation.rb'
require 'httparty'
require 'pry'
require 'pg'



# post '/taxapi' do
#     employee_name = params["employee_name"]
#     employee_annual_salary = params["annual_salary"].to_i
#     hash = { 'monthly_payslip' => generate_monthly_payslip(employee_name, employee_annual_salary) }
#     json = hash.to_json
#     # JSON.parse(hash)
#     binding.pry
#     redirect '/tax'
# end

def run_sql(sql) 
    db =PG.connect(dbname: 'employees_db')
    employees = db.exec(sql)
    db.close
    return employees
end

post '/api' do
    name = params['name']
    salary= params['salary'].to_i
    hash = { 'monthly_payslip' => generate_monthly_payslip(name, salary ) }
    monthly_income_tax = hash["monthly_payslip"]["monthly_income_tax"]
    time_date = Time.now.strftime("%c")

    run_sql("INSERT INTO employees(submission_time, name, annual_salary, monthly_income_tax) VALUES('#{time_date}','#{name}','#{salary}','#{monthly_income_tax}')")
  
 
    return json(hash)
    # binding.pry
    # # JSON.parse(hash)
    
end

get '/db' do
     db_result = run_sql("SELECT * FROM  employees ORDER BY id")
     db_result.to_a[0]
     hash = {"id"=>"1",
        "submission_time"=>"2021-02-15 23:24:26",
        "name"=>"hadi",
        "annual_salary"=>"1000000",
        "monthly_income_tax"=>"30666.666666666668"}
    json(hash)
    
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

    tax_output = HTTParty.get('http://localhost:4567/db') 
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