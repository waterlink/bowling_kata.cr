require "./spec_helper"

module BowlingKata
  Spec2.describe Game do
    describe GameGen do
      {% for gen in [AverageGame, NearPerfectGame, LuckyGame] %}
      it "generates good {{gen}}" do
        check [g : {{gen}}], 11 <= g.size <= 21
        check [g : {{gen}}], correct?(g)
        check [g : {{gen}}], g.all? { |r| 0 <= r <= 10 }

        check [gs : ArrayGen(100, {{gen}}),
               score : Quick::Range(0, 11)],
               gs.any?(&has_score(score))

        check [g : {{gen}}], count_rounds(g) == 10
      end
      {% end %}

      it "generates well-sized AverageGame" do
        check [gs : ArrayGen(1000, AverageGame),
               size : Quick::Range(17, 22)],
              gs.any?(&has_size(size))
      end

      it "generates well-sized NearPerfectGame" do
        check [gs : ArrayGen(1000, NearPerfectGame),
               size : Quick::Range(11, 13)],
              gs.any?(&has_size(size))
      end

      it "generates well-sized LuckyGame" do
        check [gs : ArrayGen(2000, LuckyGame),
               size : Quick::Range(13, 17)],
              gs.any?(&has_size(size))
      end

      def has_score(score)
        -> (g : Array(Int32)) { g.includes?(score) }
      end

      def has_size(size)
        -> (g : Array(Int32)) { g.size == size }
      end

      def count_rounds(g : Array(Int32), rounds = 0)
        return rounds + g.size if g.size <= 1

        if (g[0] == 10 || g[0] + g[1] == 10) && rounds == 9
          if g.size == 3
            return 10
          end

          return -1
        end

        if g[0] == 10
          return count_rounds(g[1..-1], rounds + 1)
        end

        count_rounds(g[2..-1], rounds + 1)
      end

      def correct?(g : Array(Int32))
        return true if g.size <= 1

        if g[0] == 10
          return correct?(g[1..-1])
        end

        if 0 <= g[0] + g[1] <= 10
          return correct?(g[2..-1])
        end

        false
      end
    end
  end
end
