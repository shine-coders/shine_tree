|===+|===+   Compiled|===+ in 0.01s
|===+|===+    Running|===+ benchmark.main


## data set: Reduce 100 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.reduce(data) ...
Benchmarking shine_tree.reduce ...
Calculating statistics...
Formatting results...

Name                        ips        average  deviation         median         99th %
shine_tree.reduce        1.55 M      646.32 ns  ±7299.04%         500 ns        1400 ns
list.reduce(data)        1.08 M      924.88 ns  ±2632.60%         800 ns        1700 ns

Comparison: 
shine_tree.reduce        1.55 M
list.reduce(data)        1.08 M - 1.43x slower +278.55 ns

Memory usage statistics:

Name                 Memory usage
shine_tree.reduce            96 B
list.reduce(data)             0 B - 0.00x memory usage -96 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name              Reduction count
shine_tree.reduce             267
list.reduce(data)             301 - 1.13x reduction count +34

**All measurements for reduction count were the same**


## data set: Reduce 10_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.reduce(data) ...
Benchmarking shine_tree.reduce ...
Calculating statistics...
Formatting results...

Name                        ips        average  deviation         median         99th %
shine_tree.reduce       18.06 K       55.37 μs   ±156.06%       51.60 μs       99.64 μs
list.reduce(data)       11.34 K       88.15 μs   ±653.22%       79.90 μs      141.38 μs

Comparison: 
shine_tree.reduce       18.06 K
list.reduce(data)       11.34 K - 1.59x slower +32.78 μs

Memory usage statistics:

Name                 Memory usage
shine_tree.reduce           192 B
list.reduce(data)             0 B - 0.00x memory usage -192 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name              Reduction count
shine_tree.reduce         26.66 K
list.reduce(data)         30.00 K - 1.13x reduction count +3.34 K

**All measurements for reduction count were the same**


## data set: Reduce 1_000_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.reduce(data) ...
Benchmarking shine_tree.reduce ...
Calculating statistics...
Formatting results...

Name                        ips        average  deviation         median         99th %
shine_tree.reduce        171.46        5.83 ms    ±14.25%        5.65 ms        9.25 ms
list.reduce(data)        117.34        8.52 ms    ±11.80%        8.26 ms       12.89 ms

Comparison: 
shine_tree.reduce        171.46
list.reduce(data)        117.34 - 1.46x slower +2.69 ms

Memory usage statistics:

Name                 Memory usage
shine_tree.reduce           320 B
list.reduce(data)             0 B - 0.00x memory usage -320 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name              Reduction count
shine_tree.reduce          2.67 M
list.reduce(data)          3.00 M - 1.13x reduction count +0.33 M

**All measurements for reduction count were the same**


## data set: 100 prepends

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking [item, ..rest] * n ...
Benchmarking shine_tree.unshift(Nil) * n ...
Calculating statistics...
Formatting results...

Name                                  ips        average  deviation         median         99th %
[item, ..rest] * n                 1.24 M        0.81 μs  ±9806.83%        0.30 μs        1.10 μs
shine_tree.unshift(Nil) * n        0.21 M        4.65 μs  ±1984.18%        1.80 μs        5.40 μs

Comparison: 
[item, ..rest] * n                 1.24 M
shine_tree.unshift(Nil) * n        0.21 M - 5.77x slower +3.85 μs

Memory usage statistics:

Name                           Memory usage
[item, ..rest] * n                  1.56 KB
shine_tree.unshift(Nil) * n        10.45 KB - 6.69x memory usage +8.89 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                        Reduction count
[item, ..rest] * n                      101
shine_tree.unshift(Nil) * n             403 - 3.99x reduction count +302

**All measurements for reduction count were the same**


## data set: 10_000 prepends

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking [item, ..rest] * n ...
Benchmarking shine_tree.unshift(Nil) * n ...
Calculating statistics...
Formatting results...

Name                                  ips        average  deviation         median         99th %
[item, ..rest] * n                16.45 K       60.78 μs   ±549.68%       43.60 μs      517.28 μs
shine_tree.unshift(Nil) * n        2.57 K      389.51 μs    ±84.23%      308.10 μs     1000.62 μs

Comparison: 
[item, ..rest] * n                16.45 K
shine_tree.unshift(Nil) * n        2.57 K - 6.41x slower +328.73 μs

Memory usage statistics:

Name                           Memory usage
[item, ..rest] * n                 0.153 MB
shine_tree.unshift(Nil) * n         1.07 MB - 6.99x memory usage +0.91 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                        Reduction count
[item, ..rest] * n                  15.89 K
shine_tree.unshift(Nil) * n         44.84 K - 2.82x reduction count +28.94 K

**All measurements for reduction count were the same**


## data set: 1_000_000 prepends

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking [item, ..rest] * n ...
Benchmarking shine_tree.unshift(Nil) * n ...
Calculating statistics...
Formatting results...

Name                                  ips        average  deviation         median         99th %
[item, ..rest] * n                  31.51       31.73 ms    ±11.35%       31.30 ms       43.49 ms
shine_tree.unshift(Nil) * n          9.74      102.71 ms    ±22.54%       97.25 ms      193.04 ms

Comparison: 
[item, ..rest] * n                  31.51
shine_tree.unshift(Nil) * n          9.74 - 3.24x slower +70.97 ms

Memory usage statistics:

Name                           Memory usage
[item, ..rest] * n                 15.26 MB
shine_tree.unshift(Nil) * n       106.81 MB - 7.00x memory usage +91.55 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                                average  deviation         median         99th %
[item, ..rest] * n                   1.13 M     ±2.79%         1.12 M         1.29 M
shine_tree.unshift(Nil) * n          3.88 M     ±0.58%         3.87 M         3.97 M

Comparison: 
[item, ..rest] * n                   1.12 M
shine_tree.unshift(Nil) * n          3.88 M - 3.44x reduction count +2.75 M


## data set: from iterator of size 100

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking iterator.to_list ...
Benchmarking shine_tree.from_iterator ...
Calculating statistics...
Formatting results...

Name                               ips        average  deviation         median         99th %
iterator.to_list              199.08 K        5.02 μs  ±1922.27%        2.70 μs        8.30 μs
shine_tree.from_iterator       93.62 K       10.68 μs   ±967.63%        4.50 μs       21.00 μs

Comparison: 
iterator.to_list              199.08 K
shine_tree.from_iterator       93.62 K - 2.13x slower +5.66 μs

Memory usage statistics:

Name                        Memory usage
iterator.to_list                12.76 KB
shine_tree.from_iterator        24.23 KB - 1.90x memory usage +11.48 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                     Reduction count
iterator.to_list                  0.96 K
shine_tree.from_iterator          1.35 K - 1.41x reduction count +0.39 K

**All measurements for reduction count were the same**


## data set: from iterator of size 10_000

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking iterator.to_list ...
Benchmarking shine_tree.from_iterator ...
Calculating statistics...
Formatting results...

Name                               ips        average  deviation         median         99th %
iterator.to_list                1.61 K      621.59 μs    ±65.94%      581.80 μs     1283.31 μs
shine_tree.from_iterator        1.53 K      653.18 μs    ±45.18%      596.35 μs     1423.06 μs

Comparison: 
iterator.to_list                1.61 K
shine_tree.from_iterator        1.53 K - 1.05x slower +31.59 μs

Memory usage statistics:

Name                        Memory usage
iterator.to_list                 1.16 MB
shine_tree.from_iterator         2.35 MB - 2.03x memory usage +1.19 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                     Reduction count
iterator.to_list                100.01 K
shine_tree.from_iterator        132.52 K - 1.33x reduction count +32.52 K

**All measurements for reduction count were the same**


## data set: from iterator of size 1_000_000

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking iterator.to_list ...
Benchmarking shine_tree.from_iterator ...
Calculating statistics...
Formatting results...

Name                               ips        average  deviation         median         99th %
iterator.to_list                  8.56      116.76 ms    ±12.35%      115.10 ms      164.14 ms
shine_tree.from_iterator          6.12      163.44 ms    ±14.14%      158.05 ms      224.94 ms

Comparison: 
iterator.to_list                  8.56
shine_tree.from_iterator          6.12 - 1.40x slower +46.68 ms

Memory usage statistics:

Name                        Memory usage
iterator.to_list               129.06 MB
shine_tree.from_iterator       234.60 MB - 1.82x memory usage +105.54 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                             average  deviation         median         99th %
iterator.to_list                  9.31 M     ±0.40%         9.30 M         9.42 M
shine_tree.from_iterator         12.79 M     ±0.40%        12.77 M        12.95 M

Comparison: 
iterator.to_list                  9.30 M
shine_tree.from_iterator         12.79 M - 1.37x reduction count +3.48 M


## data set: append 100 items to 100 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.append(n) ...
Benchmarking shine_tree.append(n) ...
Calculating statistics...
Formatting results...

Name                           ips        average  deviation         median         99th %
shine_tree.append(n)        2.59 M      385.67 ns ±18622.04%         100 ns         400 ns
list.append(n)              2.48 M      402.54 ns ±10733.18%         200 ns         500 ns

Comparison: 
shine_tree.append(n)        2.59 M
list.append(n)              2.48 M - 1.04x slower +16.87 ns

Memory usage statistics:

Name                    Memory usage
shine_tree.append(n)         0.71 KB
list.append(n)               1.31 KB - 1.85x memory usage +0.60 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                 Reduction count
shine_tree.append(n)              26
list.append(n)                     4 - 0.15x reduction count -22

**All measurements for reduction count were the same**


## data set: append 10_000 items to 10_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.append(n) ...
Benchmarking shine_tree.append(n) ...
Calculating statistics...
Formatting results...

Name                           ips        average  deviation         median         99th %
shine_tree.append(n)        1.02 M        0.98 μs  ±8899.05%        0.30 μs        1.20 μs
list.append(n)            0.0260 M       38.39 μs  ±1009.52%       15.80 μs      105.10 μs

Comparison: 
shine_tree.append(n)        1.02 M
list.append(n)            0.0260 M - 39.26x slower +37.41 μs

Memory usage statistics:

Name                    Memory usage
shine_tree.append(n)         1.88 KB
list.append(n)              49.78 KB - 26.55x memory usage +47.91 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                 Reduction count
shine_tree.append(n)        0.0660 K
list.append(n)                3.99 K - 60.50x reduction count +3.93 K

**All measurements for reduction count were the same**


## data set: append 1_000_000 items to 1_000_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.append(n) ...
Benchmarking shine_tree.append(n) ...
Calculating statistics...
Formatting results...

Name                           ips        average  deviation         median         99th %
shine_tree.append(n)      605.77 K     0.00165 ms  ±9251.18%     0.00050 ms     0.00150 ms
list.append(n)            0.0980 K       10.20 ms    ±94.71%        5.01 ms       38.33 ms

Comparison: 
shine_tree.append(n)      605.77 K
list.append(n)            0.0980 K - 6179.11x slower +10.20 ms

Memory usage statistics:

Name                    Memory usage
shine_tree.append(n)      0.00285 MB
list.append(n)               2.27 MB - 799.34x memory usage +2.27 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                         average  deviation         median         99th %
shine_tree.append(n)        0.0950 K     ±0.00%       0.0950 K       0.0950 K
list.append(n)               85.08 K    ±28.02%        78.50 K       176.34 K

Comparison: 
shine_tree.append(n)        0.0950 K
list.append(n)               85.08 K - 895.55x reduction count +84.98 K


## data set: calculate size of 100 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.length(n) ...
Benchmarking shine_tree.size(n) ...
Calculating statistics...
Formatting results...

Name                         ips        average  deviation         median         99th %
shine_tree.size(n)       30.25 M       33.06 ns ±10767.51%           0 ns         100 ns
list.length(n)            6.08 M      164.52 ns ±13749.17%         100 ns         200 ns

Comparison: 
shine_tree.size(n)       30.25 M
list.length(n)            6.08 M - 4.98x slower +131.46 ns

Memory usage statistics:

Name                  Memory usage
shine_tree.size(n)             0 B
list.length(n)                 0 B - 1.00x memory usage +0 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name               Reduction count
shine_tree.size(n)               1
list.length(n)                   6 - 6.00x reduction count +5

**All measurements for reduction count were the same**


## data set: calculate size of 10_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.length(n) ...
Benchmarking shine_tree.size(n) ...
Calculating statistics...
Formatting results...

Name                         ips        average  deviation         median         99th %
shine_tree.size(n)       27.27 M      0.0367 μs ±14865.99%           0 μs       0.100 μs
list.length(n)          0.0593 M       16.87 μs   ±823.97%       15.70 μs       37.40 μs

Comparison: 
shine_tree.size(n)       27.27 M
list.length(n)          0.0593 M - 460.24x slower +16.84 μs

Memory usage statistics:

Name                  Memory usage
shine_tree.size(n)             0 B
list.length(n)                 0 B - 1.00x memory usage +0 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name               Reduction count
shine_tree.size(n)               1
list.length(n)                 625 - 625.00x reduction count +624

**All measurements for reduction count were the same**


## data set: calculate size of 1_000_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.length(n) ...
Benchmarking shine_tree.size(n) ...
Calculating statistics...
Formatting results...

Name                         ips        average  deviation         median         99th %
shine_tree.size(n)       26.88 M     0.00004 ms  ±7448.78%           0 ms     0.00010 ms
list.length(n)         0.00040 M        2.52 ms   ±151.91%        2.09 ms        8.47 ms

Comparison: 
shine_tree.size(n)       26.88 M
list.length(n)         0.00040 M - 67687.73x slower +2.52 ms

Memory usage statistics:

Name                  Memory usage
shine_tree.size(n)             0 B
list.length(n)                 0 B - 1.00x memory usage +0 B

**All measurements for memory usage were the same**

Reduction count statistics:

Name               Reduction count
shine_tree.size(n)       0.00100 K
list.length(n)             62.50 K - 62500.00x reduction count +62.50 K

**All measurements for reduction count were the same**


## data set: create range of 100 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.range(1, n) ...
Benchmarking shine_tree.range(1, n) ...
Calculating statistics...
Formatting results...

Name                             ips        average  deviation         median         99th %
shine_tree.range(1, n)      678.59 K        1.47 μs  ±8140.59%        0.40 μs        1.60 μs
list.range(1, n)            640.36 K        1.56 μs  ±4403.23%        0.80 μs           2 μs

Comparison: 
shine_tree.range(1, n)      678.59 K
list.range(1, n)            640.36 K - 1.06x slower +0.0880 μs

Memory usage statistics:

Name                      Memory usage
shine_tree.range(1, n)         2.10 KB
list.range(1, n)               1.56 KB - 0.74x memory usage -0.53906 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                   Reduction count
shine_tree.range(1, n)             121
list.range(1, n)                   302 - 2.50x reduction count +181

**All measurements for reduction count were the same**


## data set: create range of 10_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.range(1, n) ...
Benchmarking shine_tree.range(1, n) ...
Calculating statistics...
Formatting results...

Name                             ips        average  deviation         median         99th %
shine_tree.range(1, n)       10.73 K       93.20 μs   ±140.38%       81.60 μs      219.81 μs
list.range(1, n)              8.81 K      113.55 μs   ±426.02%       97.70 μs      238.10 μs

Comparison: 
shine_tree.range(1, n)       10.73 K
list.range(1, n)              8.81 K - 1.22x slower +20.35 μs

Memory usage statistics:

Name                      Memory usage
shine_tree.range(1, n)       208.41 KB
list.range(1, n)             156.25 KB - 0.75x memory usage -52.15625 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                   Reduction count
shine_tree.range(1, n)         15.10 K
list.range(1, n)               35.26 K - 2.33x reduction count +20.16 K

**All measurements for reduction count were the same**


## data set: create range of 1_000_000 items

Not all of your protocols have been consolidated. In order to achieve the
best possible accuracy for benchmarks, please ensure protocol
consolidation is enabled in your benchmarking environment.

Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz
Number of Available Cores: 2
Available memory: 15.62 GB
Elixir 1.17.2
Erlang 27.0.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 4 s
memory time: 8 s
reduction time: 4 s
parallel: 2
inputs: none specified
Estimated total run time: 36 s

Benchmarking list.range(1, n) ...
Benchmarking shine_tree.range(1, n) ...
Calculating statistics...
Formatting results...

Name                             ips        average  deviation         median         99th %
shine_tree.range(1, n)         28.67       34.88 ms    ±49.78%       35.85 ms       70.48 ms
list.range(1, n)               19.80       50.51 ms    ±25.35%       47.77 ms      122.66 ms

Comparison: 
shine_tree.range(1, n)         28.67
list.range(1, n)               19.80 - 1.45x slower +15.63 ms

Memory usage statistics:

Name                      Memory usage
shine_tree.range(1, n)        20.34 MB
list.range(1, n)              15.26 MB - 0.75x memory usage -5.08616 MB

**All measurements for memory usage were the same**

Reduction count statistics:

Name                           average  deviation         median         99th %
shine_tree.range(1, n)          1.04 M     ±3.15%         1.03 M         1.15 M
list.range(1, n)                3.15 M     ±0.49%         3.14 M         3.21 M

Comparison: 
shine_tree.range(1, n)          1.03 M
list.range(1, n)                3.15 M - 3.02x reduction count +2.10 M
