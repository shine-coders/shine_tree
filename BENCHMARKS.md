# ShineTree Benchmarks\n\n
[0m[38;5;13m  Compiling[0m shine_tree
[0m[38;5;13m   Compiled[0m in 0.95s
[0m[38;5;13m    Running[0m benchmarks/append.main
## Appending Trees/lists

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.append -> n = 100|0.75us|0.0us|81.85|0.0us|65.17ms|4647440|
|list.append -> n = 1_000|8.99us|5.0us|50.04|4.0us|12.84ms|545541|
|list.append -> n = 10_000|51.6us|51.0us|43.73|40.0us|7.37ms|96474|
|list.append -> n = 100_000|1.03ms|595.0us|762.71|533.0us|5.36ms|4850|
|shine_tree.append -> n = 100|0.79us|0.0us|119.86|0.0us|87.17ms|4747039|
|shine_tree.append -> n = 1_000|1.47us|0.0us|123.02|0.0us|49.61ms|2935294|
|shine_tree.append -> n = 10_000|1.96us|1.0us|126.71|0.0us|37.73ms|2239641|
|shine_tree.append -> n = 100_000|2.58us|2.0us|124.57|0.0us|29.57ms|1758910|



[0m[38;5;13m   Compiled[0m in 0.18s
[0m[38;5;13m    Running[0m benchmarks/count.main
## Element counting

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List count evens -> n = 100|2.45us|3.0us|31.52|2.0us|26.74ms|1872090|
|List count evens -> n = 1_000|22.93us|22.0us|18.72|20.0us|4.83ms|216372|
|List count evens -> n = 10_000|217.88us|203.0us|14.38|202.0us|622.0us|22917|
|List count evens -> n = 100_000|2.13ms|2.04ms|109.29|2.03ms|2.75ms|2343|
|ShineTree count evens -> n = 100|2.46us|2.0us|51.75|2.0us|38.51ms|1898809|
|ShineTree count evens -> n = 1_000|22.84us|23.0us|26.29|22.0us|6.2ms|217398|
|ShineTree count evens -> n = 10_000|229.29us|225.0us|58.28|223.0us|7.28ms|21789|
|ShineTree count evens -> n = 100_000|2.07ms|2.06ms|58.39|2.03ms|2.69ms|2418|



[0m[38;5;13m   Compiled[0m in 0.18s
[0m[38;5;13m    Running[0m benchmarks/from_iterator.main
## Converting to ShineTree

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|iterator.to_list -> n = 100|12.38us|7.0us|152.48|3.0us|8.32ms|391127|
|iterator.to_list -> n = 1_000|47.68us|42.0us|14.01|37.0us|1.9ms|104392|
|iterator.to_list -> n = 10_000|860.37us|848.0us|117.57|587.0us|4.21ms|5808|
|iterator.to_list -> n = 100_000|10.48ms|10.12ms|1115.01|9.31ms|15.49ms|477|
|shine_tree.from_iterator -> n = 100|18.52us|10.0us|150.35|6.0us|6.41ms|266996|
|shine_tree.from_iterator -> n = 1_000|122.12us|80.0us|175.0|69.0us|5.04ms|40857|
|shine_tree.from_iterator -> n = 10_000|1.01ms|1.09ms|174.15|842.0us|4.33ms|4956|
|shine_tree.from_iterator -> n = 100_000|13.17ms|12.12ms|1907.24|11.7ms|22.78ms|379|



[0m[38;5;13m   Compiled[0m in 0.18s
[0m[38;5;13m    Running[0m benchmarks/shift.main
## Shifting Trees/lists

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list (take one item at a time, until empty) -> n = 100|0.46us|1.0us|1.41|0.0us|2.93ms|6712335|
|list (take one item at a time, until empty) -> n = 1_000|4.93us|6.0us|17.48|4.0us|12.04ms|965011|
|list (take one item at a time, until empty) -> n = 10_000|42.58us|42.0us|18.78|40.0us|3.07ms|116739|
|list (take one item at a time, until empty) -> n = 100_000|366.96us|352.0us|21.08|352.0us|1.45ms|13617|
|shine_tree.shift (against best case scenario list) -> n = 100|16.8us|7.0us|192.49|5.0us|9.14ms|292151|
|shine_tree.shift (against best case scenario list) -> n = 1_000|163.53us|71.0us|394.31|56.0us|6.32ms|30513|
|shine_tree.shift (against best case scenario list) -> n = 10_000|1.66ms|10.94ms|834.79|542.0us|14.13ms|3004|
|shine_tree.shift (against best case scenario list) -> n = 100_000|19.21ms|18.57ms|886.76|16.55ms|22.73ms|260|
|shine_tree.pop (lists can't do this at all) -> n = 100|17.12us|7.0us|193.76|6.0us|8.48ms|287428|
|shine_tree.pop (lists can't do this at all) -> n = 1_000|167.09us|79.0us|389.93|70.0us|6.38ms|29868|
|shine_tree.pop (lists can't do this at all) -> n = 10_000|1.68ms|2.33ms|778.26|590.0us|6.99ms|2970|
|shine_tree.pop (lists can't do this at all) -> n = 100_000|19.62ms|18.95ms|2145.93|14.72ms|47.98ms|255|



[0m[38;5;13m   Compiled[0m in 0.13s
[0m[38;5;13m    Running[0m benchmarks/sort.main
## Sorting lists

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List sort -> n = 100|25.19us|22.0us|103.65|15.0us|6.55ms|196890|
|List sort -> n = 1_000|231.96us|228.0us|22.63|214.0us|855.0us|21533|
|List sort -> n = 10_000|4.48ms|4.51ms|421.28|3.38ms|6.55ms|1115|
|List sort -> n = 100_000|71.07ms|69.39ms|3782.71|62.73ms|79.27ms|70|
|ShineTree sort -> n = 100|49.68us|53.0us|55.18|46.0us|12.11ms|100285|
|ShineTree sort -> n = 1_000|2.0ms|1.33ms|795.48|1.13ms|5.58ms|2494|
|ShineTree sort -> n = 10_000|33.96ms|32.85ms|1918.85|30.78ms|42.39ms|148|
|ShineTree sort -> n = 100_000|1.13s|1.13s|5582.35|1.12s|1.14s|5|



[0m[38;5;13m   Compiled[0m in 0.15s
[0m[38;5;13m    Running[0m benchmarks/fold.main
## Folding

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.fold -> n = 100|1.08us|1.0us|9.87|1.0us|18.41ms|3671866|
|list.fold -> n = 1_000|10.11us|10.0us|26.02|9.0us|12.4ms|482472|
|list.fold -> n = 10_000|95.5us|100.0us|12.14|89.0us|2.42ms|52250|
|list.fold -> n = 100_000|902.09us|890.0us|14.93|890.0us|1.1ms|5541|
|iterator.fold -> n = 100|9.82us|6.0us|132.3|3.0us|9.14ms|497141|
|iterator.fold -> n = 1_000|66.05us|36.0us|171.69|36.0us|4.01ms|75443|
|iterator.fold -> n = 10_000|356.65us|378.0us|41.58|333.0us|4.08ms|14008|
|iterator.fold -> n = 100_000|3.54ms|3.37ms|178.36|3.36ms|4.37ms|1412|
|shine_tree.fold_l -> n = 100|1.21us|1.0us|69.3|0.0us|71.28ms|3649377|
|shine_tree.fold_l -> n = 1_000|10.02us|9.0us|31.66|9.0us|10.15ms|491289|
|shine_tree.fold_l -> n = 10_000|97.3us|97.0us|30.66|86.0us|4.39ms|51299|
|shine_tree.fold_l -> n = 100_000|935.78us|971.0us|85.68|871.0us|4.58ms|5342|



[0m[38;5;13m   Compiled[0m in 0.17s
[0m[38;5;13m    Running[0m benchmarks/range.main
## Creating List/Tree of size n from a range 1 to n

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List range of size n -> n = 100|3.64us|2.0us|114.43|1.0us|20.48ms|1263585|
|List range of size n -> n = 1_000|22.64us|20.0us|96.46|13.0us|3.88ms|218639|
|List range of size n -> n = 10_000|158.59us|155.0us|26.15|136.0us|1.22ms|31479|
|List range of size n -> n = 100_000|2.94ms|3.01ms|792.4|1.99ms|33.43ms|1699|
|ShineTree range of size n -> n = 100|2.14us|1.0us|118.07|0.0us|31.97ms|2058460|
|ShineTree range of size n -> n = 1_000|19.21us|11.0us|153.99|5.0us|6.78ms|256372|
|ShineTree range of size n -> n = 10_000|136.17us|158.0us|192.45|63.0us|4.01ms|36643|
|ShineTree range of size n -> n = 100_000|5.71ms|6.96ms|1089.53|3.41ms|9.19ms|875|



[0m[38;5;13m   Compiled[0m in 0.19s
[0m[38;5;13m    Running[0m benchmarks/size.main
## Checking Size

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.size -> n = 100|0.26us|1.0us|0.93|0.0us|1.03ms|9092548|
|list.size -> n = 1_000|3.74us|3.0us|0.8|3.0us|153.0us|1240069|
|list.size -> n = 10_000|31.95us|30.0us|2.5|28.0us|172.0us|155221|
|list.size -> n = 100_000|179.06us|189.0us|10.62|165.0us|331.0us|27881|
|shine_tree.size -> n = 100|0.06us|0.0us|0.34|0.0us|205.0us|15061079|
|shine_tree.size -> n = 1_000|0.06us|0.0us|0.41|0.0us|217.0us|15337262|
|shine_tree.size -> n = 10_000|0.06us|0.0us|0.37|0.0us|217.0us|16259060|
|shine_tree.size -> n = 100_000|0.06us|0.0us|0.52|0.0us|603.0us|13968283|



[0m[38;5;13m   Compiled[0m in 0.19s
[0m[38;5;13m    Running[0m benchmarks/unshift.main
## Prepending Items

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|shine_tree.unshift(Nil) -> n = 100|9.76us|5.0us|141.95|2.0us|9.87ms|499206|
|shine_tree.unshift(Nil) -> n = 1_000|83.45us|38.0us|199.77|30.0us|5.05ms|59716|
|shine_tree.unshift(Nil) -> n = 10_000|637.34us|467.0us|200.45|430.0us|3.64ms|7841|
|shine_tree.unshift(Nil) -> n = 100_000|10.03ms|9.54ms|2010.34|6.24ms|27.18ms|498|
|[item, ..rest] -> n = 100|1.54us|1.0us|118.99|0.0us|42.6ms|2711741|
|[item, ..rest] -> n = 1_000|13.32us|85.0us|157.36|3.0us|7.86ms|368375|
|[item, ..rest] -> n = 10_000|109.93us|74.0us|206.98|36.0us|3.7ms|45366|
|[item, ..rest] -> n = 100_000|1.49ms|1.33ms|128.41|1.05ms|4.09ms|3354|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100|9.5us|4.0us|144.95|2.0us|15.44ms|513117|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 1_000|82.41us|37.0us|189.66|28.0us|3.64ms|60463|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 10_000|640.56us|452.0us|233.06|415.0us|4.57ms|7801|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100_000|11.11ms|11.8ms|1648.17|6.81ms|16.65ms|450|



