# ShineTree Benchmarks

## append


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.append -> n = 100|0.96us|2.0us|39.69|0.0us|53.61ms|4623182|
|list.append -> n = 1_000|8.78us|6.0us|59.39|4.0us|4.25ms|560806|
|list.append -> n = 10_000|87.46us|62.0us|205.5|59.0us|5.22ms|57052|
|list.append -> n = 100_000|881.69us|660.0us|819.54|561.0us|6.88ms|5673|
|shine_tree.append -> n = 100|0.34us|0.0us|27.58|0.0us|77.9ms|11408641|
|shine_tree.append -> n = 1_000|0.56us|0.0us|15.79|0.0us|8.08ms|7476054|
|shine_tree.append -> n = 10_000|0.62us|0.0us|53.45|0.0us|79.67ms|7025792|
|shine_tree.append -> n = 100_000|0.68us|0.0us|42.57|0.0us|62.97ms|6483146|



## count


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List count evens -> n = 100|1.88us|2.0us|4.94|1.0us|1.97ms|2513321|
|List count evens -> n = 1_000|18.25us|18.0us|6.57|17.0us|2.3ms|272153|
|List count evens -> n = 10_000|180.14us|180.0us|12.58|179.0us|1.24ms|27733|
|List count evens -> n = 100_000|1.8ms|1.79ms|47.62|1.79ms|3.33ms|2772|
|ShineTree count evens -> n = 100|1.55us|1.0us|40.17|1.0us|37.92ms|3051918|
|ShineTree count evens -> n = 1_000|14.35us|14.0us|7.72|13.0us|1.64ms|344421|
|ShineTree count evens -> n = 10_000|139.42us|138.0us|13.34|137.0us|985.0us|35821|
|ShineTree count evens -> n = 100_000|1.39ms|1.38ms|37.35|1.38ms|2.91ms|3596|



## shift


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list (take one item at a time, until empty) -> n = 100|0.15us|0.0us|0.36|0.0us|62.0us|17653698|
|list (take one item at a time, until empty) -> n = 1_000|1.24us|1.0us|0.53|1.0us|251.0us|3692076|
|list (take one item at a time, until empty) -> n = 10_000|11.63us|12.0us|1.16|11.0us|147.0us|424671|
|list (take one item at a time, until empty) -> n = 100_000|118.24us|115.0us|9.35|114.0us|828.0us|42169|
|shine_tree.shift (against best case scenario list) -> n = 100|3.16us|4.0us|26.62|2.0us|19.11ms|1539391|
|shine_tree.shift (against best case scenario list) -> n = 1_000|35.41us|30.0us|16.52|29.0us|1.87ms|140745|
|shine_tree.shift (against best case scenario list) -> n = 10_000|352.44us|303.0us|99.85|301.0us|1.77ms|14178|
|shine_tree.shift (against best case scenario list) -> n = 100_000|3.59ms|3.23ms|367.56|3.08ms|7.95ms|1394|
|shine_tree.pop (lists can't do this at all) -> n = 100|2.71us|2.0us|22.99|2.0us|19.9ms|1791077|
|shine_tree.pop (lists can't do this at all) -> n = 1_000|28.29us|25.0us|17.77|23.0us|3.49ms|176015|
|shine_tree.pop (lists can't do this at all) -> n = 10_000|254.28us|246.0us|27.4|242.0us|1.71ms|19651|
|shine_tree.pop (lists can't do this at all) -> n = 100_000|2.45ms|2.46ms|113.9|2.39ms|4.64ms|2038|



## sort


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List sort -> n = 100|7.91us|8.0us|13.38|7.0us|7.21ms|625766|
|List sort -> n = 1_000|115.45us|111.0us|11.54|111.0us|1.22ms|43267|
|List sort -> n = 10_000|2.58ms|2.62ms|278.85|2.05ms|4.74ms|1938|
|List sort -> n = 100_000|35.28ms|38.97ms|3393.93|27.83ms|47.04ms|142|
|ShineTree sort -> n = 100|9.58us|9.0us|9.05|8.0us|4.84ms|516875|
|ShineTree sort -> n = 1_000|125.37us|119.0us|18.77|117.0us|1.05ms|39843|
|ShineTree sort -> n = 10_000|2.19ms|2.14ms|194.36|1.93ms|3.78ms|2284|
|ShineTree sort -> n = 100_000|42.69ms|32.73ms|5475.17|29.8ms|54.43ms|117|



## fold


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.fold -> n = 100|1.05us|1.0us|4.8|0.0us|7.44ms|4219694|
|list.fold -> n = 1_000|10.35us|10.0us|2.21|9.0us|687.0us|477276|
|list.fold -> n = 10_000|102.99us|102.0us|8.81|96.0us|753.0us|48483|
|list.fold -> n = 100_000|1.04ms|1.03ms|55.81|990.0us|2.62ms|4826|
|shine_tree.fold_l -> n = 100|0.57us|0.0us|45.93|0.0us|73.71ms|7533973|
|shine_tree.fold_l -> n = 1_000|4.14us|4.0us|18.7|3.0us|17.86ms|1179970|
|shine_tree.fold_l -> n = 10_000|41.12us|42.0us|8.4|39.0us|1.03ms|121288|
|shine_tree.fold_l -> n = 100_000|421.34us|403.0us|57.43|399.0us|1.93ms|11858|



## range


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List range of size n -> n = 100|1.06us|1.0us|36.87|0.0us|42.6ms|4379498|
|List range of size n -> n = 1_000|9.66us|9.0us|5.0|8.0us|837.0us|512449|
|List range of size n -> n = 10_000|97.34us|88.0us|26.38|88.0us|1.08ms|51304|
|List range of size n -> n = 100_000|1.22ms|1.19ms|100.11|1.17ms|3.1ms|4086|
|ShineTree range of size n -> n = 100|0.69us|1.0us|49.0|0.0us|64.78ms|6463627|
|ShineTree range of size n -> n = 1_000|5.5us|5.0us|15.36|4.0us|11.01ms|893411|
|ShineTree range of size n -> n = 10_000|52.69us|45.0us|20.38|43.0us|2.72ms|94674|
|ShineTree range of size n -> n = 100_000|1.07ms|926.0us|428.08|452.0us|3.47ms|4658|



## size


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.size -> n = 100|0.13us|1.0us|0.38|0.0us|478.0us|17925635|
|list.size -> n = 1_000|1.18us|2.0us|0.51|1.0us|250.0us|3810284|
|list.size -> n = 10_000|10.84us|11.0us|1.39|10.0us|236.0us|456457|
|list.size -> n = 100_000|109.83us|107.0us|10.29|106.0us|815.0us|45419|
|shine_tree.size -> n = 100|0.03us|0.0us|0.18|0.0us|69.0us|26862186|
|shine_tree.size -> n = 1_000|0.03us|0.0us|0.19|0.0us|332.0us|28064989|
|shine_tree.size -> n = 10_000|0.03us|0.0us|0.2|0.0us|269.0us|30697250|
|shine_tree.size -> n = 100_000|0.03us|0.0us|0.2|0.0us|316.0us|23925578|



## unshift


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|shine_tree.unshift(Nil) -> n = 100|2.19us|1.0us|24.3|1.0us|23.49ms|2197034|
|shine_tree.unshift(Nil) -> n = 1_000|23.23us|20.0us|10.53|20.0us|2.13ms|214277|
|shine_tree.unshift(Nil) -> n = 10_000|330.16us|271.0us|129.74|204.0us|2.6ms|15137|
|shine_tree.unshift(Nil) -> n = 100_000|3.67ms|3.75ms|988.98|2.63ms|6.77ms|1362|
|[item, ..rest] -> n = 100|0.36us|0.0us|76.57|0.0us|131.99ms|11135685|
|[item, ..rest] -> n = 1_000|2.3us|2.0us|4.19|1.0us|2.25ms|2093689|
|[item, ..rest] -> n = 10_000|22.96us|17.0us|19.16|16.0us|2.26ms|216678|
|[item, ..rest] -> n = 100_000|263.4us|177.0us|186.98|173.0us|4.37ms|18964|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100|2.19us|2.0us|39.47|1.0us|29.37ms|2195133|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 1_000|18.56us|18.0us|14.27|15.0us|4.34ms|267996|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 10_000|192.48us|161.0us|67.8|157.0us|1.73ms|25957|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100_000|3.2ms|2.2ms|1001.38|2.15ms|6.58ms|1564|



## group


| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.group (n % 7) -> n = 100|5.58us|5.0us|18.49|5.0us|9.6ms|883417|
|list.group (n % 7) -> n = 1_000|55.51us|53.0us|11.51|52.0us|1.94ms|89905|
|list.group (n % 7) -> n = 10_000|751.83us|667.0us|124.22|654.0us|2.22ms|6648|
|list.group (n % 7) -> n = 100_000|8.27ms|6.68ms|1455.86|6.65ms|11.97ms|605|
|shine_tree.group (n % 7) -> n = 100|4.58us|4.0us|5.77|3.0us|5.23ms|1068918|
|shine_tree.group (n % 7) -> n = 1_000|45.15us|40.0us|12.82|39.0us|545.0us|110458|
|shine_tree.group (n % 7) -> n = 10_000|562.89us|513.0us|67.5|507.0us|2.22ms|8879|
|shine_tree.group (n % 7) -> n = 100_000|5.65ms|5.56ms|577.81|5.22ms|8.16ms|884|



