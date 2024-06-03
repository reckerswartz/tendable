require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# Function to prompt the user for answers
def do_prompt(store)
  # Initialize an empty hash to store the answers
  answers = {}

  # Loop over each question
  QUESTIONS.each_key do |question_key|
    # Print the question
    print QUESTIONS[question_key]

    # Get the user's answer
    ans = gets.chomp

    # Store the answer as a boolean value (true if 'yes' or 'y', false otherwise)
    answers[question_key] = ans.casecmp("yes").zero? || ans.casecmp("y").zero?
  end

  # Open a transaction and store the answers
  store.transaction { store[:answers] = store.fetch(:answers, []).push(answers) }
end

# Function to report the results
def do_report(store)
  # Open a transaction to read the answers
  store.transaction do
    # Get all the answers
    all_answers = store.fetch(:answers, [])

    # If there are no answers, print a message and return
    if all_answers.empty?
      puts "No answers yet."
      return
    end

    # Calculate and print the rating for the last run
    last_run_rating = 100 * all_answers.last.values.count(true) / QUESTIONS.size
    puts "Rating for last run: %d%%" % last_run_rating

    # Calculate and print the average rating for all runs
    total_rating = all_answers.reduce(0) do |sum, ans| 
      sum + 100 * ans.values.count(true) / QUESTIONS.size
    end
    average_rating = total_rating / all_answers.size.to_f
    puts "Average rating for all runs: %d%%" % average_rating
  end
end

# Call the prompt and report functions
do_prompt(store)
do_report(store)
