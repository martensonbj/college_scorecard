require 'pry'
require 'csv'

class Scorecard

  @path = '/Users/bmartenson/turing/3module/posse_challenges/college_scorecard/college_scorecard.rb'

  def initialize(ARGV[1], ARGV[2])
    ARGV[1](ARGV[2])
  end

  def by_state(state)
    data.each do |row|
      puts row["INSTNM"] if row["STABBR"] == state
    end
  end

  def top_average_faculty_salary(num)
    salaries = data.map do |row|
      row["AVGFACSAL"].to_i
    end.sort.reverse

    salaries[0..(num-1)]
  end

  def median_debt_between(num1, num2)
    debt = {}
    data.map do |row|
      if (num1.to_f < row["GRAD_DEBT_MDN"].to_f) && (num2.to_f > row["GRAD_DEBT_MDN"].to_f)
        debt[row["INSTNM"]] = row["GRAD_DEBT_MDN"]
      end
    end

    ordered = debt.sort_by{|k, v| v}.reverse

    ordered.map! do |k, v|
      puts "#{k} $(#{v})"
    end
  end
end
