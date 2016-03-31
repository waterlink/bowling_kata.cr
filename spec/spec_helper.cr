require "../src/bowling_kata.cr"
require "spec2"

macro check(args, expr)
  Quick.check({{"#{args}\n\tFailure: #{expr}"}}, {{args}}) do
    {{expr}}
  end
end
