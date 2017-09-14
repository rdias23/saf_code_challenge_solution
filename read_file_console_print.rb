
### DIRECTIONS SUPPLIED BY SAF PLATFORM ###
#For the solution, please use either Ruby, Javascript or Java.
#
#Please do not use any external libraries to solve this problem. You may only use external libraries or tools for building or testing purposes (e.g., Rspec, JUnit, Jest, Mocha, Rake, etc.).
#
#We expect you to submit what you believe is “production-quality” code that you would be able to run, modify, and maintain. Although not required, please consider using version control.
#
#In addition to your code submission, please include the following:
#- A brief explanation of any assumptions you make regarding design or requirements
#- Detailed instructions on how to run the application
#
#Please limit the amount of time you spend on the problem to **3 hours**. If you haven't completed the challenge within the allotted time, please submit the work you have completed.
#
#### Problem
#There are two additional files with input data. Each input will contain three lines:
#
#The first line is the name of the fund.
#The second line is the year of the fund.
#The third is 12 comma-separated numbers representing monthly returns for one year.
#
#Please write a program that reads in the inputs from text file and prints the formatted solution to console.
### END OF DIRECTIONS SUPPLIED BY SAF PLATFORM ###

### NOTES SUPPLIED BY RAY DIAS, DEVELOPER APPLICANT ###
#I wrote this on my personal computer (Macbook Pro) with the vim text editor using ruby 2.1.4p265 (2014-10-27 revision 48166) [x86_64-darwin14.0]
#So... if you are using that version, I suppose, that would maximize the chance of this program working... But, I think it should work for all versions of ruby
#Note: This program assumes that the read_file_console_print.rb file is inside the same directory as the text files that you want to be processed. 
#Note: This program assumes that the text files will be in the correct format (described in the SAF Platform supplied directions).
#Note: You can run the program from the command line if you are currently in the same directory as the read_file_console_print.rb and the text files to be processed.
#Note: For the purposes of this program, a 'text file' is any file that ends with the file extension '.txt'
#Note: I took "Cumulative Return" to mean I should just add up all of the values. I checked and double-checked the result and it seems correct, but it does not match what the example scenarios told me to expect: 2.66% and 9.55% .... instead I got 2.69% and 9.63% .... not sure what that is about.
#Note: I know that my method of truncating the decimal places is a bit different than the provided scenarios... In my method, they get rounded up in the last place: 66.67% instead of 66.66% ... So that's one small deviation... in some cases you would think it better my way, I am sure...
# Note: In order to run the program, place the read_file_console_print.rb file inside the same directory as the input text files, and then navigate to that directory with "Terminal" (Mac OSX), and from the command line run this command: 'ruby read_file_console_print.rb'
### END OF NOTES SUPPLIED BY RAY DIAS, DEVELOPER APPLICANT ###

class ReadFileConsolePrint
  @@instance = ReadFileConsolePrint.new

  def self.instance
    return @@instance
  end

  def print(file_name)
    @file_arr = File.readlines(file_name)
    @fund_name = @file_arr[0].delete!("\n").rstrip!
    @file_year = @file_arr[1].delete!("\n")
    
    @cum_return = @file_arr[2].split(",").inject(0){|sum,x| sum.to_f + x.to_f }
    @num_positive = @file_arr[2].split(",").count { |x| x.to_f > 0 }
     # just in case one slips in there that does not have a number for every single month in the year... that's why not dividing by 12 explicitly
    @percent_positive_months = ((@num_positive * 100.0) / @file_arr[2].split(",").length)
    @best_month_monthly_return_val = @file_arr[2].split(",").map { |x| x.to_f }.max
  
    puts "--------------->"
  
    puts "reading from file '#{file_name}'"
    puts @fund_name
    puts "Year: " + @file_year
    puts "Cumulative Return: " +("%0.2f" % @cum_return).to_s + "%"
    puts "% Positive Months: " + ("%0.2f" % @percent_positive_months).to_s + "%"
    puts "Best Month: " + ("%0.2f" % @best_month_monthly_return_val).to_s + "%"

    puts "--------------->"
    puts ""
  end

  private_class_method :new
end

@files_in_this_dir = Dir["*.txt"]

puts ""
puts "Processing information for #{@files_in_this_dir.length} text file#{@files_in_this_dir.length == 1 ? '' : 's'} in the current directory!"
puts ""

@files_in_this_dir.each do |file|
  ReadFileConsolePrint.instance.print(file)
end
