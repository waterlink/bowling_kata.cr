# Bowling Kata (in Crystal)

## Rules of bowling

- Game consists of 10 frames.
  * in each frame player has 2 opportunities (rolls) to knock down 10 pins
  * score for a frame = total number of pins knocked down
  * and bonuses for spares and strikes
- Spare is when player knocks down all 10 pins in 2 tries
  * bonus = number of pins knocked down by the next roll
- Strike is when player knocks down all 10 pins in 1 try
  * bonus = number of pins knocked down in the next 2 rolls
- 10th frame
  * player who rolls spare or strike is allowed to do extra rolls to complete frame
  * however, no more than 3 rolls can be done in 10th frame

## Requirements

- Write a class named `Game` that has following methods:
  * `#roll(pins : Int)` called each time player does a roll. `pins` argument is
  the number of pins knocked down by that roll
  * `#score : Int` is called only at the end of the game. It returns the total
  score of the game

## Development

After cloning the repository:

- Use `shards install` to install development dependencies
- Use `crystal spec` to run the test suite

## Contributing

1. Fork it ( https://github.com/waterlink/bowling_kata.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer

## Credits

Kata description is inspired by
[Uncle Bob's BowlingKata](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata)
description
