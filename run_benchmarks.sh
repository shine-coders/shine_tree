{
  printf "# ShineTree Benchmarks\n\n" ;
  printf "## all\n\n" ;
  gleam run -m benchmarks/all ;
  printf "## append\n\n" ;
  gleam run -m benchmarks/append ;
  printf "## count\n\n" ;
  gleam run -m benchmarks/count ;
  printf "## fold\n\n" ;
  gleam run -m benchmarks/fold ;
  printf "## from_iterator\n\n" ;
  gleam run -m benchmarks/from_iterator ;
  printf "## group\n\n" ;
  gleam run -m benchmarks/group ;
  printf "## range\n\n" ;
  gleam run -m benchmarks/range ;
  printf "## shift\n\n" ;
  gleam run -m benchmarks/shift ;
  printf "## size\n\n" ;
  gleam run -m benchmarks/size ;
  printf "## sort\n\n" ;
  gleam run -m benchmarks/sort ;
  printf "## unshift\n\n" ;
  gleam run -m benchmarks/unshift
} \
| sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" \
> BENCHMARKS.md
