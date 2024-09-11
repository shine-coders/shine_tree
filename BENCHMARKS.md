[0m[38;5;13m   Compiled[0m in 0.12s
[0m[38;5;13m    Running[0m benchmark.main
# ShineTree Benchmarks

## Folding

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.fold -> n = 100|1.01us|1.0us|17.27|0.0us|35.78ms|4355099|
|list.fold -> n = 1_000|9.75us|9.0us|4.86|8.0us|2.33ms|505234|
|list.fold -> n = 10_000|96.0us|92.0us|15.89|91.0us|291.0us|51993|
|list.fold -> n = 100_000|968.83us|914.0us|152.29|912.0us|2.06ms|5159|
|iterator.fold -> n = 100|5.47us|3.0us|87.87|2.0us|7.48ms|897357|
|iterator.fold -> n = 1_000|44.8us|28.0us|100.05|25.0us|2.13ms|111272|
|iterator.fold -> n = 10_000|291.34us|263.0us|77.5|259.0us|1.38ms|17152|
|iterator.fold -> n = 100_000|2.96ms|2.66ms|522.78|2.62ms|6.85ms|1692|
|shine_tree.fold_l -> n = 100|0.71us|0.0us|35.43|0.0us|47.33ms|6105578|
|shine_tree.fold_l -> n = 1_000|7.02us|6.0us|17.47|5.0us|6.65ms|701643|
|shine_tree.fold_l -> n = 10_000|68.78us|62.0us|27.76|61.0us|2.29ms|72555|
|shine_tree.fold_l -> n = 100_000|691.89us|623.0us|222.58|620.0us|2.4ms|7225|



## Prepending Items

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|shine_tree.unshift(Nil) -> n = 100|4.71us|2.0us|96.09|1.0us|13.21ms|1033919|
|shine_tree.unshift(Nil) -> n = 1_000|46.04us|23.0us|116.08|19.0us|2.3ms|108269|
|shine_tree.unshift(Nil) -> n = 10_000|414.97us|312.0us|152.08|275.0us|1.93ms|12041|
|shine_tree.unshift(Nil) -> n = 100_000|5.09ms|4.67ms|716.14|3.87ms|8.84ms|983|
|[item, ..rest] -> n = 100|0.75us|0.0us|88.84|0.0us|41.23ms|5684550|
|[item, ..rest] -> n = 1_000|6.65us|2.0us|102.81|2.0us|8.48ms|737895|
|[item, ..rest] -> n = 10_000|64.96us|86.0us|136.97|22.0us|2.47ms|76763|
|[item, ..rest] -> n = 100_000|597.45us|823.0us|93.43|519.0us|1.78ms|8364|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100|4.53us|2.0us|96.51|1.0us|8.71ms|1077184|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 1_000|44.26us|28.0us|115.0|16.0us|2.14ms|112560|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 10_000|389.49us|363.0us|169.83|237.0us|5.54ms|12832|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100_000|4.81ms|4.54ms|771.46|3.51ms|8.93ms|1039|



## Converting to ShineTree

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|iterator.to_list -> n = 100|5.8us|3.0us|91.4|3.0us|7.98ms|839367|
|iterator.to_list -> n = 1_000|39.28us|34.0us|45.7|32.0us|2.64ms|126909|
|iterator.to_list -> n = 10_000|652.25us|634.0us|143.53|459.0us|1.93ms|7663|
|iterator.to_list -> n = 100_000|7.38ms|8.76ms|833.4|6.2ms|11.13ms|677|
|shine_tree.from_iterator -> n = 100|10.69us|9.0us|98.94|4.0us|4.65ms|463284|
|shine_tree.from_iterator -> n = 1_000|86.68us|51.0us|115.13|47.0us|1.56ms|57591|
|shine_tree.from_iterator -> n = 10_000|721.14us|1.01ms|165.86|569.0us|1.72ms|6932|
|shine_tree.from_iterator -> n = 100_000|8.13ms|9.25ms|777.78|7.25ms|12.24ms|615|



## Appending Trees/lists

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.append -> n = 100|0.39us|0.0us|26.46|0.0us|46.13ms|9722301|
|list.append -> n = 1_000|4.74us|2.0us|22.87|2.0us|1.94ms|1028344|
|list.append -> n = 10_000|28.34us|30.0us|18.86|22.0us|680.0us|175403|
|list.append -> n = 100_000|490.17us|239.0us|363.46|201.0us|2.06ms|10194|
|shine_tree.append -> n = 100|0.36us|0.0us|76.72|0.0us|72.42ms|10200465|
|shine_tree.append -> n = 1_000|0.69us|0.0us|85.05|0.0us|48.25ms|6242082|
|shine_tree.append -> n = 10_000|0.92us|1.0us|88.73|0.0us|37.34ms|4845986|
|shine_tree.append -> n = 100_000|1.15us|1.0us|88.24|0.0us|28.17ms|3929173|



