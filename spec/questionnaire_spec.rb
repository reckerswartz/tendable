require "rspec"
require_relative "../questionnaire"

describe "do_prompt" do
  # delete the test.pstore file if it exists
  before { File.delete("test.pstore") if File.exist?("test.pstore") }
  let(:store) { PStore.new("test.pstore") }

  context "when user provides valid input" do
    it "stores the user's answers" do
      allow_any_instance_of(Object).to receive(:gets).and_return("y", "n", "y", "n", "y")
      do_prompt(store)
      store.transaction do
        expect(store[:answers].last).to eq({
          "q1" => true,
          "q2" => false,
          "q3" => true,
          "q4" => false,
          "q5" => true
        })
      end
    end
  end

  context "when user provides invalid input" do
    it "stores the user's answers as false" do
      allow_any_instance_of(Object).to receive(:gets).and_return("invalid", "invalid", "invalid", "invalid", "invalid")
      do_prompt(store)
      store.transaction do
        expect(store[:answers].last).to eq({
          "q1" => false,
          "q2" => false,
          "q3" => false,
          "q4" => false,
          "q5" => false
        })
      end
    end
  end
end

describe "do_report" do
  # delete the test.pstore file if it exists
  before { File.delete("test.pstore") if File.exist?("test.pstore") }
  let(:store) { PStore.new("test.pstore") }

  context "when there are no answers" do
    it 'reports "No answers yet."' do
      expect { do_report(store) }.to output("No answers yet.\n").to_stdout
    end
  end

  context "when there are answers" do
    it "calculates and reports the rating for the last run and the average rating for all runs" do
      store.transaction do
        store[:answers] = [
          {"q1" => true, "q2" => false, "q3" => true, "q4" => false, "q5" => true},
          {"q1" => false, "q2" => true, "q3" => false, "q4" => true, "q5" => false}
        ]
      end
      expect { do_report(store) }.to output("Rating for last run: 40%\nAverage rating for all runs: 50%\n").to_stdout
    end
  end
end
