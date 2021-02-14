def calculate_tax(annual_salary)    
    yearly_income_tax = 0        
    if annual_salary < 20000            
        yearly_income_tax = 0         
    elsif annual_salary <= 40000            
        yearly_income_tax = 0.1 * (annual_salary - 20000)     
    elsif annual_salary <= 80000             
        yearly_income_tax = (0.2 * (annual_salary - 40000)) + (0.1 * 20000)        
    elsif annual_salary <= 180000            
        yearly_income_tax = (0.3 * (annual_salary - 80000))  + (0.2 * 40000) + (0.1 * 20000)        
    elsif annual_salary > 180000            
        yearly_income_tax = (0.4 * (annual_salary - 180000)) + (0.3 * 100000)  + (0.2 * 40000) + (0.1 * 20000)        
    end    
    return yearly_income_tax
end


def generate_monthly_payslip(name, annual_salary)    
    puts "Monthly Payslip for: '#{name}"    
    # Calculate monthly gross income
    gross_monthly_salary = annual_salary / 12
    puts "Gross Monthly Income: $'#{gross_monthly_salary}'"
    # Calculate monthly income tax    
    # divide by 12
    monthly_tax = calculate_tax(annual_salary) / 12
    puts "Monthly Income Tax: $'#{monthly_tax}'"
    net_monthly_income = gross_monthly_salary - monthly_tax
    puts "Net Monthly Income: $'#{net_monthly_income}'"
end
    
    generate_monthly_payslip("Ren", 60000)