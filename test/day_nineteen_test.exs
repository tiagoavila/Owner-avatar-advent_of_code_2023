defmodule DayNineteenTest do
  use ExUnit.Case

  @tag skip: true
  test "DayNineteen - test part one" do
    assert File.read!("./inputs/day_nineteen/test_input.txt")
           |> DayNineteen.part_one() == 19_114
  end

  @tag skip: true
  test "Parse Rule to function" do
    rule = "a<2006:qkq"
    function = DayNineteen.parse_rule_to_function(rule)
    assert function.(%{"x" => 787, "m" => 2655, "a" => 1222, "s" => 2876}) == "qkq"
    assert function.(%{"x" => 787, "m" => 2655, "a" => 2016, "s" => 2876}) == :cont

    rule = "x<10:A"
    function = DayNineteen.parse_rule_to_function(rule)
    assert function.(%{"x" => 5, "m" => 2655, "a" => 1222, "s" => 2876}) == "A"
    assert function.(%{"x" => 787, "m" => 2655, "a" => 2016, "s" => 2876}) == :cont

    rule = "A"
    function = DayNineteen.parse_rule_to_function(rule)
    assert function.(%{"x" => 787, "m" => 2655, "a" => 1222, "s" => 2876}) == "A"

    rule = "rfg"
    function = DayNineteen.parse_rule_to_function(rule)
    assert function.(%{"x" => 787, "m" => 2655, "a" => 1222, "s" => 2876}) == "rfg"
  end

  @tag skip: true
  test "Parse Workflows to Map with Functions" do
    workflows = """
    px{a<2006:qkq,m>2090:A,rfg}
    pv{a>1716:R,A}
    lnx{m>1548:A,A}
    rfg{s<537:gd,x>2440:R,A}
    qs{s>3448:A,lnx}
    qkq{x<1416:A,crn}
    crn{x>2662:A,R}
    in{s<1351:px,qqz}
    qqz{s>2770:qs,m<1801:hdj,R}
    gd{a>3333:R,R}
    hdj{m>838:A,pv}
    """

    workflows_map = DayNineteen.parse_workflows_to_map_of_functions(workflows, "\n")

    assert Map.keys(workflows_map) |> Enum.sort() ==
             ["crn", "gd", "hdj", "in", "lnx", "pv", "px", "qkq", "qqz", "qs", "rfg"]
  end

  @tag skip: true
  test "Parse Part Rating to Map" do
    part_rating = "{x=787,m=2655,a=1222,s=2876}"
    part_rating_map = DayNineteen.parse_part_rating_to_map(part_rating)
    assert part_rating_map == %{"x" => 787, "m" => 2655, "a" => 1222, "s" => 2876}
  end

  @tag skip: true
  test "Test Workflow result for Part Rating" do
    workflows = """
    px{a<2006:qkq,m>2090:A,rfg}
    pv{a>1716:R,A}
    lnx{m>1548:A,A}
    rfg{s<537:gd,x>2440:R,A}
    qs{s>3448:A,lnx}
    qkq{x<1416:A,crn}
    crn{x>2662:A,R}
    in{s<1351:px,qqz}
    qqz{s>2770:qs,m<1801:hdj,R}
    gd{a>3333:R,R}
    hdj{m>838:A,pv}
    """

    workflows_map = DayNineteen.parse_workflows_to_map_of_functions(workflows, "\n")
    initial_workflow = "in"

    part_rating = DayNineteen.parse_part_rating_to_map("{x=787,m=2655,a=1222,s=2876}")
    assert DayNineteen.process_workflow(initial_workflow, part_rating, workflows_map) == "A"

    part_rating = DayNineteen.parse_part_rating_to_map("{x=1679,m=44,a=2067,s=496}")
    assert DayNineteen.process_workflow(initial_workflow, part_rating, workflows_map) == "R"

    part_rating = DayNineteen.parse_part_rating_to_map("{x=2036,m=264,a=79,s=2244}")
    assert DayNineteen.process_workflow(initial_workflow, part_rating, workflows_map) == "A"

    part_rating = DayNineteen.parse_part_rating_to_map("{x=2461,m=1339,a=466,s=291")
    assert DayNineteen.process_workflow(initial_workflow, part_rating, workflows_map) == "R"

    part_rating = DayNineteen.parse_part_rating_to_map("{x=2127,m=1623,a=2188,s=1013}")
    assert DayNineteen.process_workflow(initial_workflow, part_rating, workflows_map) == "A"
  end

  @tag skip: true
  test "DayNineteen - challenge part one" do
    assert File.read!("./inputs/day_nineteen/challenge_input.txt")
           |> DayNineteen.part_one()
           |> IO.inspect(label: "DayNineteen - challenge one")
  end

  @tag skip: true
  test "DayNineteen - challenge part two from igorb" do
    assert File.read!("./inputs/day_nineteen/test_input.txt")
           |> AdventOfCode.Day19.part_two() == 167_409_079_868_000
  end

  @tag skip: true
  test "DayNineteen - challenge part two from bjorng" do
    assert File.read!("./inputs/day_nineteen/test_input.txt")
           |> String.split("\r\n\r\n", trim: true)
           |> Day19.part2() == 167_409_079_868_000
  end

  # @tag skip: true
  test "DayNineteen - challenge part two from midouest" do
    assert File.read!("./inputs/day_nineteen/test_input.txt")
           |> MidouestDay19Part2.part2() == 167_409_079_868_000
  end

  test "DayNineteen - test part two" do
    assert File.read!("./inputs/day_nineteen/test_input.txt")
           |> DayNineteen.part_two() == 167_409_079_868_000
  end

  test "DayNineteen - challenge part two" do
  	assert File.read!("./inputs/day_nineteen/challenge_input.txt")
  	   |> DayNineteen.part_two()
  	   |> IO.inspect(label: "day_nineteen - challenge two")
  end
end
