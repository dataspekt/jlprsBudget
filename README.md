This simple R package contains datasets of Croatian local administrative units' budgets and tools for extraction and aggregation of values from individual accounts, as well as for importing budget data from tables published by Ministry of finance.

Available datasets cover periods [2010-2014](http://www.mfin.hr/hr/ostvarenje-proracuna-jlprs-za-period-2010-2014) and [2014-2017](http://www.mfin.hr/hr/ostvarenje-proracuna-jlprs-za-period-2014-2017). Only data for LAU-2 level (towns and municipalities) is currently included.

### Usage

To extract values of account "611" for period 2014-2016 use:

```r
data(jlprsBudget.2014.2017)
extract(jlprsBudget.2014.2017, pattern = "^611$", period = 2014:2016)
```

To aggregate, set column name when extracting:

```r
extract(jlprsBudget.2014.2017, pattern = "^611$", period = 2014:2016, cn = "p611")
```

Alternatively, you can select account for extraction by its description:

```r
extract(jlprsBudget.2014.2017, pattern = "^Porez i prirez na dohodak (AOP 004 do 009 - 010 - 011)$", scol = "desc", period = 2014:2016, cn = "p611")
```

Beware of complexities of the chart of accounts as it *does* contain duplicate keys and descriptions!

Importing data from published tables is more involved as you will probably have to assign unique ID to each local administrative unit in order to use it, which is not covered here. To import tables you could use:

```r
import.budget("21 Zagreb 2017.xlsx", rm.sheets = NULL, rm.cols = c(5,7,9))
```

### Licence

Free software (GPL-3).
