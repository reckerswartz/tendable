# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

# Approach Explanation

The approach used in this code is to first define a set of questions in a hash, with the keys being the question identifiers and the values being the question text.

The `do_prompt` function is used to prompt the user for their answers to each question. The user's answers are stored in a hash, with the keys being the question identifiers and the values being boolean values representing whether the user answered 'yes' or 'no' to the question.

The `do_report` function is used to calculate and print the rating for the last run and the average rating for all runs. The rating for a run is calculated as the percentage of questions that the user answered 'yes' to. The average rating is calculated as the average of the ratings for all runs.

The user's answers and the ratings are persisted using the PStore library, which provides a simple file-based storage mechanism.

This approach allows for a flexible and extensible questionnaire system. New questions can be easily added to the questionnaire by adding them to the questions hash. The rating calculations are also flexible and can be easily modified to use different formulas if needed.