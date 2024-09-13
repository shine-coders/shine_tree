echo "# ShineTree Benchmarks\n\n" > BENCHMARKS.md

gleam run -m benchmarks/append >> BENCHMARKS.md
gleam run -m benchmarks/count >> BENCHMARKS.md
gleam run -m benchmarks/from_iterator >> BENCHMARKS.md
gleam run -m benchmarks/shift >> BENCHMARKS.md  
gleam run -m benchmarks/sort >> BENCHMARKS.md
gleam run -m benchmarks/fold >> BENCHMARKS.md
gleam run -m benchmarks/range >> BENCHMARKS.md
gleam run -m benchmarks/size >> BENCHMARKS.md   
gleam run -m benchmarks/unshift >> BENCHMARKS.md
