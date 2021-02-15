require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pp'
require 'tax_calculation.rb'
require 'httparty'

post '/api' do
    hash = { 'Salary Slip' => generate_monthly_payslip('Ren' , 600000)}
    return json(hash)
end

get '/api' do