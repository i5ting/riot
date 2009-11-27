require 'teststrap'

context "An equals assertion macro" do
  setup do
    Riot::Assertion.new("blue") { "foo" }
  end

  asserts(":pass when expectation met") do
    topic.equals("foo").run(Riot::Situation.new) == [:pass]
  end

  context "that is failing" do
    setup { topic.equals("bar").run(Riot::Situation.new) }

    asserts(":fail") { topic.first == :fail }
    asserts("message") { topic.last == %Q{expected "bar", not "foo"} }
  end # that is failing
end # An equals assertion macro

context "An equals assertion macro with numeric topic" do
  setup do
    Riot::Assertion.new("blue") { 31415 }
  end

  asserts(":pass when in expected range") do
    topic.equals(30000..32000).run(Riot::Situation.new) == [:pass]
  end

  context "when not in expected range" do
    setup { topic.equals(32000..33000).run(Riot::Situation.new) }

    asserts(":fail") { topic.first == :fail }
    asserts("message") { topic.last == %Q{expected 32000..33000, not 31415} }
  end
end
