import { $ } from "bun";
import fs from "node:fs";
const benchmark_stream = fs.createWriteStream("./BENCHMARKS.md", {
    encoding: "utf-8"
});

benchmark_stream.write("# ShineTree Benchmarks\n\n");
benchmark_stream.write("## append\n\n");
const append = await $`gleam run -m benchmarks/append`.text();
benchmark_stream.write(append);

benchmark_stream.write("## count\n\n");
const count = await $`gleam run -m benchmarks/count`.text();
benchmark_stream.write(count);

benchmark_stream.write("## shift\n\n");
const shift = await $`gleam run -m benchmarks/shift`.text();
benchmark_stream.write(shift);

benchmark_stream.write("## sort\n\n");
const sort = await $`gleam run -m benchmarks/sort`.text();
benchmark_stream.write(sort);

benchmark_stream.write("## fold\n\n");
const fold = await $`gleam run -m benchmarks/fold`.text();
benchmark_stream.write(fold);

benchmark_stream.write("## range\n\n");
const range = await $`gleam run -m benchmarks/range`.text();
benchmark_stream.write(range);

benchmark_stream.write("## size\n\n");
const size = await $`gleam run -m benchmarks/size`.text();
benchmark_stream.write(size);

benchmark_stream.write("## unshift\n\n");
const unshift = await $`gleam run -m benchmarks/unshift`.text();
benchmark_stream.write(unshift);

benchmark_stream.write("## group\n\n");
const group = await $`gleam run -m benchmarks/group`.text();
benchmark_stream.write(group);
