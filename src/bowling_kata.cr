require "quick"

module BowlingKata
  class Game
  end

  class GameGen(A1, A2, B)
    include Quick::Generator(Array(Int32))

    PLUS = -> (l : Array(Int32), r : Array(Int32)) do
      l + r
    end

    def self.next
      round_rolls.reduce(&PLUS)
    end

    private def self.add_rolls
    end

    private def self.round_rolls
      rounds.map(&.rolls)
    end

    private def self.rounds
      regular_rounds + [final_round]
    end

    private def self.regular_rounds
      (0...9).map { Round.new(A1, B) }
    end

    private def self.final_round
      FinalRound.new(A2, B)
    end

    record Round, first, second do
      def initialize(a, b)
        @first = rand(a...b)
        @second = rand(b - first)
      end

      def rolls
        return [first] if strike?
        [first, second]
      end

      private def strike?
        first == 10
      end
    end

    record FinalRound, first, second, third do
      def initialize(a, b)
        @first = Round.new(a, b).rolls
        @second = Round.new(a, b).rolls
        @third = Round.new(a, b).rolls
      end

      def rolls
        return two_rounds_and_roll if two_strikes?
        return two_rounds if strike?(first)
        return round_and_roll if spare?
        first
      end

      private def two_rounds
        first + second
      end

      private def round_and_roll
        first + [second[0]]
      end

      private def two_rounds_and_roll
        first + second + [third[0]]
      end

      private def two_strikes?
        strike?(first) && strike?(second)
      end

      private def strike?(rolls)
        rolls == [10]
      end

      private def spare?
        first.sum == 10 && first.size == 2
      end
    end
  end

  alias AverageGame = GameGen(0, 0, 11)
  alias NearPerfectGame = GameGen(10, 0, 11)
  alias LuckyGame = GameGen(8, 0, 11)

  class ArrayGen(A, T)
    include Quick::Generator(typeof(self.class.next))

    def self.next
      (0..A).map { T.next }
    end
  end
end
