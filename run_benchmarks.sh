{
  printf "# ShineTree Benchmarks\n\n" ;
  printf "## append\n\n" ;
  gleam run -m benchmarks/append ;
  printf "## count\n\n" ;
  gleam run -m benchmarks/count ;
  printf "## from_iterator\n\n" ;
  gleam run -m benchmarks/from_iterator ; 
  printf "## shift\n\n" ;
  gleam run -m benchmarks/shift ;
  printf "## sort\n\n" ;
  gleam run -m benchmarks/sort ;
  printf "## fold\n\n" ;
  gleam run -m benchmarks/fold ;
  printf "## range\n\n" ;
  gleam run -m benchmarks/range ;
  printf "## size\n\n" ;
  gleam run -m benchmarks/size ;
  printf "## unshift\n\n" ;
  gleam run -m benchmarks/unshift ;
  printf "## group\n\n" ;
  gleam run -m benchmarks/group
} \
| sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" \
> BENCHMARKS.md
