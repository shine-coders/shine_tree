# ShineTree Benchmarks

## append

   Compiled in 0.05s
    Running benchmarks/append.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.append -> n = 100|0.45us|0.0us|43.46|0.0us|45.37ms|8008228|
|list.append -> n = 1_000|3.88us|2.0us|45.63|2.0us|26.98ms|1251932|
|list.append -> n = 10_000|26.33us|21.0us|73.68|19.0us|20.29ms|188810|
|list.append -> n = 100_000|413.15us|374.0us|509.95|167.0us|30.3ms|12128|
|shine_tree.append -> n = 100|0.38us|0.0us|92.8|0.0us|98.85ms|10053552|
|shine_tree.append -> n = 1_000|0.69us|0.0us|102.17|0.0us|123.6ms|6287248|
|shine_tree.append -> n = 10_000|0.91us|0.0us|102.63|0.0us|85.49ms|4888296|
|shine_tree.append -> n = 100_000|1.13us|1.0us|97.72|0.0us|43.16ms|4046049|



## count

   Compiled in 0.05s
    Running benchmarks/count.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List count evens -> n = 100|1.74us|1.0us|17.5|1.0us|16.11ms|2659214|
|List count evens -> n = 1_000|16.89us|15.0us|63.76|15.0us|20.05ms|293807|
|List count evens -> n = 10_000|168.63us|158.0us|186.4|149.0us|27.42ms|29609|
|List count evens -> n = 100_000|1.91ms|1.57ms|1507.77|1.5ms|33.23ms|2621|
|ShineTree count evens -> n = 100|1.39us|2.0us|31.95|1.0us|31.92ms|3346790|
|ShineTree count evens -> n = 1_000|13.41us|12.0us|73.91|11.0us|22.92ms|370217|
|ShineTree count evens -> n = 10_000|133.56us|124.0us|175.53|121.0us|24.06ms|37387|
|ShineTree count evens -> n = 100_000|1.32ms|1.22ms|497.29|1.2ms|14.03ms|3778|



## from_iterator

   Compiled in 0.05s
    Running benchmarks/from_iterator.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|iterator.to_list -> n = 100|5.4us|3.0us|121.06|2.0us|64.36ms|902626|
|iterator.to_list -> n = 1_000|36.99us|55.0us|130.39|26.0us|20.14ms|134752|
|iterator.to_list -> n = 10_000|593.1us|572.0us|641.0|374.0us|35.43ms|8425|
|iterator.to_list -> n = 100_000|6.42ms|5.85ms|1201.07|5.3ms|18.91ms|778|
|shine_tree.from_iterator -> n = 100|9.65us|4.0us|114.16|3.0us|37.67ms|512812|
|shine_tree.from_iterator -> n = 1_000|86.01us|45.0us|238.47|40.0us|26.28ms|58022|
|shine_tree.from_iterator -> n = 10_000|699.59us|526.0us|332.07|485.0us|15.16ms|7145|
|shine_tree.from_iterator -> n = 100_000|7.37ms|6.78ms|2033.91|6.48ms|43.26ms|678|



## shift

   Compiled in 0.04s
    Running benchmarks/shift.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list (take one item at a time, until empty) -> n = 100|0.29us|0.0us|4.93|0.0us|9.94ms|11425501|
|list (take one item at a time, until empty) -> n = 1_000|2.89us|3.0us|29.12|2.0us|29.71ms|1641178|
|list (take one item at a time, until empty) -> n = 10_000|26.25us|25.0us|13.87|23.0us|3.35ms|189367|
|list (take one item at a time, until empty) -> n = 100_000|253.75us|289.0us|207.52|228.0us|22.06ms|19685|
|shine_tree.shift (against best case scenario list) -> n = 100|7.32us|2.0us|116.99|2.0us|31.27ms|671737|
|shine_tree.shift (against best case scenario list) -> n = 1_000|71.13us|30.0us|197.35|24.0us|9.67ms|70104|
|shine_tree.shift (against best case scenario list) -> n = 10_000|705.47us|298.0us|543.93|291.0us|29.89ms|7085|
|shine_tree.shift (against best case scenario list) -> n = 100_000|8.48ms|7.49ms|2388.11|6.86ms|47.71ms|590|
|shine_tree.pop (lists can't do this at all) -> n = 100|7.19us|4.0us|119.1|1.0us|35.57ms|684529|
|shine_tree.pop (lists can't do this at all) -> n = 1_000|70.41us|27.0us|230.1|21.0us|29.65ms|70843|
|shine_tree.pop (lists can't do this at all) -> n = 10_000|679.55us|856.0us|525.0|267.0us|25.62ms|7354|
|shine_tree.pop (lists can't do this at all) -> n = 100_000|8.05ms|7.64ms|1694.46|6.6ms|33.13ms|621|



## sort

   Compiled in 0.05s
    Running benchmarks/sort.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List sort -> n = 100|10.32us|7.0us|76.39|6.0us|26.59ms|479416|
|List sort -> n = 1_000|150.95us|137.0us|240.94|128.0us|39.59ms|33091|
|List sort -> n = 10_000|2.19ms|2.13ms|314.77|2.05ms|11.8ms|2283|
|List sort -> n = 100_000|34.54ms|32.0ms|5845.32|29.02ms|73.15ms|145|
|ShineTree sort -> n = 100|13.26us|8.0us|114.05|7.0us|28.83ms|373556|
|ShineTree sort -> n = 1_000|212.22us|147.0us|305.31|136.0us|19.37ms|23539|
|ShineTree sort -> n = 10_000|2.78ms|2.61ms|929.75|1.83ms|21.18ms|1795|
|ShineTree sort -> n = 100_000|34.3ms|36.0ms|5639.34|27.98ms|70.42ms|145|



## fold

   Compiled in 0.05s
    Running benchmarks/fold.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.fold -> n = 100|0.94us|1.0us|22.86|0.0us|17.44ms|4433277|
|list.fold -> n = 1_000|8.63us|7.0us|57.69|7.0us|31.15ms|570367|
|list.fold -> n = 10_000|87.65us|81.0us|164.64|78.0us|22.0ms|56930|
|list.fold -> n = 100_000|876.99us|846.0us|445.98|785.0us|23.9ms|5699|
|iterator.fold -> n = 100|4.96us|3.0us|91.63|2.0us|21.32ms|989189|
|iterator.fold -> n = 1_000|40.72us|24.0us|153.38|21.0us|32.53ms|122427|
|iterator.fold -> n = 10_000|234.14us|217.0us|138.77|216.0us|14.99ms|21340|
|iterator.fold -> n = 100_000|2.4ms|2.67ms|768.9|2.22ms|25.24ms|2081|
|shine_tree.fold_l -> n = 100|0.57us|0.0us|46.35|0.0us|73.13ms|7409110|
|shine_tree.fold_l -> n = 1_000|5.47us|5.0us|45.07|4.0us|33.64ms|897499|
|shine_tree.fold_l -> n = 10_000|56.67us|48.0us|150.68|46.0us|29.0ms|88000|
|shine_tree.fold_l -> n = 100_000|577.29us|584.0us|281.3|467.0us|15.68ms|8656|



## range

   Compiled in 0.07s
    Running benchmarks/range.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|List range of size n -> n = 100|1.46us|1.0us|75.37|0.0us|32.18ms|3172242|
|List range of size n -> n = 1_000|13.45us|8.0us|91.2|7.0us|9.7ms|368792|
|List range of size n -> n = 10_000|104.53us|95.0us|185.06|79.0us|22.47ms|47762|
|List range of size n -> n = 100_000|1.24ms|1.32ms|702.54|1.02ms|24.76ms|4016|
|ShineTree range of size n -> n = 100|1.05us|1.0us|89.92|0.0us|49.76ms|4359871|
|ShineTree range of size n -> n = 1_000|8.73us|5.0us|106.94|3.0us|29.09ms|565988|
|ShineTree range of size n -> n = 10_000|74.34us|45.0us|165.46|39.0us|18.3ms|67127|
|ShineTree range of size n -> n = 100_000|2.62ms|2.1ms|954.76|1.8ms|24.82ms|1911|



## size

   Compiled in 0.04s
    Running benchmarks/size.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.size -> n = 100|0.16us|0.0us|10.0|0.0us|33.55ms|15711838|
|list.size -> n = 1_000|2.22us|2.0us|24.19|1.0us|18.43ms|2092006|
|list.size -> n = 10_000|16.47us|33.0us|47.71|14.0us|21.14ms|300046|
|list.size -> n = 100_000|113.46us|105.0us|48.65|102.0us|7.32ms|43993|
|shine_tree.size -> n = 100|0.03us|0.0us|6.54|0.0us|32.4ms|28133030|
|shine_tree.size -> n = 1_000|0.03us|0.0us|3.54|0.0us|10.47ms|20487610|
|shine_tree.size -> n = 10_000|0.04us|0.0us|7.67|0.0us|29.44ms|20185780|
|shine_tree.size -> n = 100_000|0.03us|0.0us|6.33|0.0us|19.17ms|22538207|



## unshift

   Compiled in 0.05s
    Running benchmarks/unshift.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|shine_tree.unshift(Nil) -> n = 100|6.28us|2.0us|133.67|1.0us|35.23ms|779441|
|shine_tree.unshift(Nil) -> n = 1_000|55.73us|23.0us|188.99|16.0us|24.72ms|89388|
|shine_tree.unshift(Nil) -> n = 10_000|535.85us|294.0us|562.53|244.0us|39.83ms|9325|
|shine_tree.unshift(Nil) -> n = 100_000|6.56ms|6.47ms|1978.9|3.95ms|35.21ms|762|
|[item, ..rest] -> n = 100|1.02us|0.0us|125.73|0.0us|64.91ms|4207056|
|[item, ..rest] -> n = 1_000|8.87us|3.0us|152.06|1.0us|35.17ms|552812|
|[item, ..rest] -> n = 10_000|71.26us|41.0us|277.62|21.0us|29.46ms|69919|
|[item, ..rest] -> n = 100_000|985.82us|590.0us|859.53|447.0us|35.85ms|5065|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100|6.07us|4.0us|140.58|1.0us|32.57ms|809162|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 1_000|62.99us|1.19ms|290.01|13.0us|48.32ms|79192|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 10_000|539.36us|337.0us|443.14|214.0us|14.85ms|9265|
|shine_tree.push(Nil) (lists can't do this at all) -> n = 100_000|7.44ms|6.22ms|3020.44|3.73ms|43.14ms|672|



## group

   Compiled in 0.06s
    Running benchmarks/group.main

| Name | Mean | Median | Std. | Min | Max | Iterations |
|---|---|---|---|---|---|---|
|list.group (n % 7) -> n = 100|11.25us|8.0us|105.91|7.0us|44.01ms|438551|
|list.group (n % 7) -> n = 1_000|113.07us|86.0us|224.34|75.0us|30.15ms|44115|
|list.group (n % 7) -> n = 10_000|1.31ms|1.31ms|779.38|871.0us|31.09ms|3813|
|list.group (n % 7) -> n = 100_000|13.35ms|15.47ms|3435.15|9.37ms|41.01ms|373|
|iterator.group (n % 7) -> n = 100|14.49us|9.0us|31.2|8.0us|6.19ms|341775|
|iterator.group (n % 7) -> n = 1_000|129.84us|98.0us|254.3|89.0us|30.4ms|38450|
|iterator.group (n % 7) -> n = 10_000|1.31ms|1.2ms|578.28|1.01ms|21.3ms|3804|
|iterator.group (n % 7) -> n = 100_000|17.53ms|17.36ms|4425.71|14.09ms|71.34ms|285|
|shine_tree.group (n % 7) -> n = 100|9.09us|6.0us|96.96|5.0us|11.48ms|541024|
|shine_tree.group (n % 7) -> n = 1_000|105.09us|72.0us|236.11|62.0us|20.16ms|47397|
|shine_tree.group (n % 7) -> n = 10_000|1.09ms|715.0us|855.06|673.0us|21.11ms|4595|
|shine_tree.group (n % 7) -> n = 100_000|10.71ms|16.49ms|2262.55|7.38ms|20.63ms|467|



