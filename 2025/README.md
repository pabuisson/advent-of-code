# AoC 2025

A Crystal project for the Advent of Code 2025. Each day is a class `DayNN` defined in a `src/day_nn.cr` file, and defines both a `part_1(input, must_log)` and `part_2(input, must_log) methods that must return the expected value.

A global `Base` class includes common constants and stuff, along with a macro that allows to run a specific day without needing to add any code to the daily classes. Just run the following commands:

```shell
$ crystal run src/day_nn.cr
```

Or if you want the verbose mode:

```shell
$ crystal run src/day_nn.cr -- -v
$ crystal run src/day_nn.cr -- --verbose
```


## Contributors

- [Pierre-Adrien Buisson](https://github.com/pabuisson) - creator and maintainer
