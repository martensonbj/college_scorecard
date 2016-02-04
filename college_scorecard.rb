require 'pry'
require 'csv'

class Scorecard

  attr_reader :data

  def initialize
    @data = CSV.foreach('2013_college_scorecards.csv', headers: true)
    @method = ARGV[0]
    @arg1 = ARGV[1]
    @arg2 = ARGV[2]
  end

  def determine_method
    if @method == "by_state"
      by_state(@arg1)
    elsif @method == "top_average_faculty_salary"
      top_average_faculty_salary(@arg1)
    else @method == "median_debt_between"
      median_debt_between(@arg1, @arg2)
    end
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

sc = Scorecard.new
sc.determine_method
